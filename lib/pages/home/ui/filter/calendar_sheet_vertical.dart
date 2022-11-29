import 'package:app/app/app_bloc_helper.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/bloc/price_range/price_range_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/widgets/animations/shimmer_rectangle.dart';
import 'package:app/widgets/app_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarSheetVertical extends StatefulWidget {
  const CalendarSheetVertical({Key? key}) : super(key: key);

  @override
  CalendarSheetVerticalState createState() => CalendarSheetVerticalState();
}

class CalendarSheetVerticalState extends State<CalendarSheetVertical> {
  @override
  void initState() {
    super.initState();
  }

  bool isInRange(DateTime date, DateTime? start, DateTime? end) {
    // if start is null, no date has been selected yet
    if (start == null) return false;
    // if only end is null only the start should be highlighted
    if (end == null) return date == start;
    // if both start and end aren't null check if date false in the range
    return ((date == start || date.isAfter(start)) &&
        (date == end || date.isBefore(end)));
  }

  Widget weekText(String text) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: kMediumSemiBold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filterCubit = context.watch<FilterCubit>();
    final departDate = filterCubit.state.departDate;
    final returnDate = filterCubit.state.returnDate;
    final isRoundTrip = filterCubit.state.flightType == FlightType.round;
    final priceState = context.watch<PriceRangeCubit>().state;
    final prices = priceState.prices;
    return Padding(
      padding: kPagePadding,
      child: SizedBox(
          height: 0.8.sh,
          child: Column(
            children: [
              kVerticalSpacerSmall,
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () => context.router.pop(),
                  child: Icon(
                    Icons.clear,
                    color: Styles.kTextColor,
                  ),
                ),
              ),
              kVerticalSpacerSmall,
              AppCardCalendar(
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "DEP ${AppDateUtils.formatDateWithoutLocale(departDate)}",
                          style: departDate == null
                              ? kMediumRegular
                              : kMediumSemiBold,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isRoundTrip,
                      child: Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.chevron_right),
                            Expanded(
                              child: Center(
                                child: Text(
                                    "ARR ${AppDateUtils.formatDateWithoutLocale(returnDate)}",
                                    style: returnDate == null
                                        ? kMediumRegular
                                        : kMediumSemiBold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              kVerticalSpacer,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  weekText('S'),
                  weekText('M'),
                  weekText('T'),
                  weekText('W'),
                  weekText('T'),
                  weekText('F'),
                  weekText('S'),
                ],
              ),
              kVerticalSpacerMini,
              Expanded(
                child: PagedVerticalCalendar(
                  minDate: DateTime.now(),
                  maxDate: DateTime.now().add(const Duration(days: 180)),
                  initialDate: departDate ?? DateTime.now(),
                  onMonthLoaded: (year, month) {
                    print("month loaded $year $month");
                    context.read<PriceRangeCubit>().getPrices(
                          filterCubit.state,
                          startFilter: DateTime(year, month, 1),
                        );
                  },
                  startWeekWithSunday: true,
                  onDayPressed: (value) async {
                    final isBefore = value.isBefore(DateTime.now());
                    if (isBefore) return;
                    if (isRoundTrip) {
                      if (departDate == null) {
                        context
                            .read<FilterCubit>()
                            .updateDate(departDate: value, returnDate: null);
                      } else if (returnDate == null) {
                        context.read<FilterCubit>().updateDate(
                            departDate: departDate, returnDate: value);
                        await Future.delayed(const Duration(seconds: 1));
                        if (mounted) {
                          context.router.pop();
                        }
                      } else {
                        context
                            .read<FilterCubit>()
                            .updateDate(departDate: value, returnDate: null);
                      }
                    } else {
                      context
                          .read<FilterCubit>()
                          .updateDate(departDate: value, returnDate: null);
                      await Future.delayed(const Duration(seconds: 1));
                      if (mounted) {
                        context.router.pop();
                      }
                    }
                  },
                  onPaginationCompleted: (direction) {},
                  monthBuilder: (context, month, year) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat("MMM yyyy").format(
                          DateTime(year, month),
                        ),
                        style:
                            kMediumMedium.copyWith(color: Styles.kPrimaryColor),
                      ),
                    );
                  },
                  dayBuilder: (context, date) {
                    final inRange = isInRange(date, departDate, returnDate);
                    final sameMonth =
                        AppDateUtils.sameMonth(date, priceState.loadingDate);
                    final event = prices.firstWhereOrNull(
                        (event) => isSameDay(event.date, date));
                    final isBefore = date.isBefore(DateTime.now());
                    return Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color:
                            inRange ? Styles.kPrimaryColor : Colors.transparent,
                        border: Border.all(
                          color: Colors.white,
                          width: 0.3,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${date.day}",
                            style: kSmallRegular.copyWith(
                              color: inRange
                                  ? Colors.white
                                  : isBefore
                                      ? Styles.kBorderColor
                                      : null,
                            ),
                          ),
                          Expanded(
                            child: Visibility(
                              visible:
                                  priceState.blocState == BlocState.loading &&
                                      (sameMonth || event?.departPrice == null),
                              replacement: event == null
                                  ? const SizedBox()
                                  : Align(
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              "MYR",
                                              style: kExtraSmallHeavy.copyWith(
                                                color: inRange
                                                    ? Colors.white
                                                    : null,
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              NumberUtils.formatNum(
                                                departDate == null
                                                    ? event.departPrice
                                                    : returnDate == null
                                                        ? event.returnPrice
                                                        : event.departPrice,
                                              ),
                                              style: kSmallSemiBold.copyWith(
                                                color: inRange
                                                    ? Colors.white
                                                    : null,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: const ShimmerRectangle(
                                  height: 10,
                                  width: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
