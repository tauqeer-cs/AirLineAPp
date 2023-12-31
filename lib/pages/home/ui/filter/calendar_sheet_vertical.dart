import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_logger.dart';
import 'package:app/models/search_date_range.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/bloc/price_range/price_range_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/widgets/animations/shimmer_rectangle.dart';
import 'package:app/widgets/app_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';
import 'package:paged_vertical_calendar/utils/date_utils.dart';
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
    final locale = context.locale.toString();
    initializeDateFormatting(locale, null);
    return SizedBox(
        height: 0.8.sh,
        child: Stack(
          children: [
            Padding(
              padding: kPagePadding,
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
                            child: AutoSizeText(
                              "${"departureShort".tr()} ${AppDateUtils.formatDateWithoutLocale(departDate, locale: locale)}",
                              style: departDate == null
                                  ? kMediumRegular
                                  : kMediumSemiBold,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isRoundTrip,
                          child: const Icon(Icons.chevron_right),
                        ),
                        Visibility(
                          visible: isRoundTrip,
                          child: Expanded(
                            child: Center(
                              child: AutoSizeText(
                                  maxLines: 1,
                                  "${"returnShort".tr()} ${AppDateUtils.formatDateWithoutLocale(returnDate, locale: locale)}",
                                  style: returnDate == null
                                      ? kMediumRegular
                                      : kMediumSemiBold),
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
                      weekText('calendar.daySundayShort'.tr()),
                      weekText('calendar.dayMondayShort'.tr()),
                      weekText('calendar.dayTuesdayShort'.tr()),
                      weekText('calendar.dayWednesdayShort'.tr()),
                      weekText('calendar.dayThursdayShort'.tr()),
                      weekText('calendar.dayFridayShort'.tr()),
                      weekText('calendar.daySaturdayShort'.tr()),
                    ],
                  ),
                  kVerticalSpacerMini,
                  Expanded(
                    child: PagedVerticalCalendar(
                      invisibleMonthsThreshold: 12,
                      minDate:
                      DateTime(DateTime.now().year, DateTime.now().month, 1)
                          .removeTime(),
                      maxDate: DateTime.now()
                          .add(
                        const Duration(days: 365),
                      )
                          .removeTime(),
                      initialDate: departDate?.removeTime() ??
                          DateTime.now().removeTime(),
                      onMonthLoaded: (year, month) {
                        context.read<PriceRangeCubit>().getPrices(
                            filterCubit.state,
                            startFilter: DateTime(year, month, 1),
                            currency:
                            filterCubit.state.origin?.currency ?? 'MYR');
                      },
                      startWeekWithSunday: true,
                      onDayPressed: (value) async {
                        final now = DateTime.now();
                        final isBefore = value.isBefore(
                            DateTime(now.year, now.month, now.day, 0, 0, 0));
                        if (isBefore) return;
                        if (isRoundTrip) {
                          if (departDate == null) {
                            context.read<FilterCubit>().updateDate(
                                departDate: value, returnDate: null);
                          } else if (returnDate == null) {
                            if (value.isBefore(departDate)) {
                              context.read<FilterCubit>().updateDate(
                                  departDate: value, returnDate: departDate);
                            } else {
                              context.read<FilterCubit>().updateDate(
                                  departDate: departDate, returnDate: value);
                            }
                            // await Future.delayed(const Duration(seconds: 1));
                            // if (mounted) {
                            //   context.router.pop();
                            // }
                          } else {
                            context.read<FilterCubit>().updateDate(
                                departDate: value, returnDate: null);
                          }
                        } else {
                          context
                              .read<FilterCubit>()
                              .updateDate(departDate: value, returnDate: null);
                          // await Future.delayed(const Duration(seconds: 1));
                          // if (mounted) {
                          //   context.router.pop();
                          // }
                        }
                      },
                      onPaginationCompleted: (direction) {
                        logger.d("pagination completed");
                      },
                      monthBuilder: (context, month, year) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            DateFormat("MMM yyyy", locale).format(
                              DateTime(year, month),
                            ),
                            style: kMediumMedium.copyWith(
                                color: Styles.kPrimaryColor),
                          ),
                        );
                      },
                      dayBuilder: (context, date) {
                        final inRange = isInRange(date, departDate, returnDate);
                        final now = DateTime.now();
                        final sameMonth = AppDateUtils.sameMonth(
                            date, priceState.loadingDate);
                        final event = prices.firstWhereOrNull(
                                (event) => isSameDay(event.date, date));
                        final isSelectedDepart = isSameDay(departDate, date);
                        final isSelectedReturn = isSameDay(returnDate, date);

                        final isBefore = date.isBefore(
                            DateTime(now.year, now.month, now.day, 0, 0, 0));
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: inRange
                                ? isSelectedDepart || isSelectedReturn
                                ? Styles.kPrimaryColor
                                : Styles.kPrimaryColor.withOpacity(0.5)
                                : Colors.transparent,
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
                                      : null,//change this to red to make it red. It was null before
                                ),
                              ),
                              Expanded(
                                child: Visibility(
                                  visible: priceState.blocState ==
                                      BlocState.loading &&
                                      (sameMonth || event?.departPrice == null),
                                  replacement: event != null &&
                                      isShowDate(
                                        date: date,
                                        departDate: departDate,
                                        returnDate: returnDate,
                                      )
                                      ? Align(
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            filterCubit.state.origin
                                                ?.currency ??
                                                'MYR',
                                            style: kExtraSmallMedium
                                                .copyWith(
                                                color: inRange
                                                    ? Colors.white
                                                    : null,////change this to red to make it red. It was null before
                                                fontSize: 6),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            NumberUtils
                                                .formatNumberNoTrailing(
                                              getPrice(
                                                price: event,
                                                isDepartDate:
                                                isSelectedDepart,
                                                isReturnDate:
                                                isSelectedReturn,
                                                isRoundTrip: isRoundTrip,
                                                departDate: departDate,
                                                returnDate: returnDate,
                                              ),
                                            ),
                                            style: (event?.departPrice ??
                                                0.0) >
                                                999
                                                ? kMediumHeavy.copyWith(
                                              color: inRange
                                                  ? Colors.white
                                                  : null,////change this to red to make it red. It was null before,
                                            )
                                                : kLargeHeavy.copyWith(
                                              color: inRange
                                                  ? Colors.white
                                                  : null,////change this to red to make it red. It was null before,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                      : const SizedBox(),
                                  child: const Align(
                                    alignment: Alignment.bottomRight,
                                    child: ShimmerRectangle(
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
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 25),
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
                    color: Colors.white.withOpacity(0.75),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        spreadRadius: 0,
                        offset: const Offset(0, -2),
                      )
                    ]),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          context
                              .read<FilterCubit>()
                              .updateDate(departDate: null, returnDate: null);
                        },
                        child: Text("reset".tr()),
                      ),
                    ),
                    kHorizontalSpacer,
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text("apply".tr()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  num? getPrice({
    required bool isDepartDate,
    required bool isReturnDate,
    required bool isRoundTrip,
    DateTime? departDate,
    DateTime? returnDate,
    DateTime? date,
    DateRangePrice? price,
  }) {
    if (!isRoundTrip || departDate == null) {
      return price?.departPrice;
    }
    if (isSameDay(departDate, returnDate)) {
      return price?.returnPrice;
    }
    if (isDepartDate) {
      return price?.departPrice;
    }
    if (isReturnDate || returnDate == null) {
      return price?.returnPrice;
    }
    return price?.departPrice;
  }

  bool isShowDate({
    required DateTime date,
    DateTime? departDate,
    DateTime? returnDate,
  }) {
    if (departDate == null) return true;
    if (date.isBefore(departDate)) {
      return false;
    }
    return true;
  }
}
