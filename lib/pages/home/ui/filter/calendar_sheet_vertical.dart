import 'package:app/app/app_bloc_helper.dart';
import 'package:app/models/search_date_range.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/bloc/price_range/price_range_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/widgets/animations/shimmer_rectangle.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_sheet_handler.dart';
import 'package:app/widgets/bottom_sheet_header_widget.dart';
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
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

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
        child: true
            ? Column(
                children: [
                  kVerticalSpacerSmall,
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => context.router.pop(),
                      child: Icon(
                        Icons.clear,
                        color: Styles.kTextColor,
                      ),
                    ),
                  ),
                  kVerticalSpacerSmall,
                  AppCard(
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              "DEP ${AppDateUtils.formatDateWithoutLocale(departDate)}",
                              style: kMediumHeavy,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isRoundTrip,
                          child: Expanded(
                            child: Row(
                              children: [
                                Icon(Icons.chevron_right),
                                Expanded(
                                  child: Center(
                                      child: Text(
                                          "ARR ${AppDateUtils.formatDateWithoutLocale(returnDate)}",
                                          style: kMediumHeavy)),
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
                      maxDate: DateTime.now().add(Duration(days: 180)),
                      initialDate: departDate ?? DateTime.now(),
                      onMonthLoaded: (year, month) {
                        print("month loaded $year $month");
                      },
                      startWeekWithSunday: true,
                      onDayPressed: (value) {
                        final isBefore = value.isBefore(DateTime.now());
                        if (isBefore) return;
                        if (isRoundTrip) {
                          if (departDate == null) {
                            context.read<FilterCubit>().updateDate(
                                departDate: value, returnDate: null);
                          } else if (returnDate == null) {
                            //if (isSameDay(value, departDate)) return;

                            context.read<FilterCubit>().updateDate(
                                departDate: departDate, returnDate: value);
                            context.router.pop();
                          } else {
                            context.read<FilterCubit>().updateDate(
                                departDate: value, returnDate: null);
                          }
                        } else {
                          context
                              .read<FilterCubit>()
                              .updateDate(departDate: value, returnDate: null);
                          context.router.pop();
                        }
                      },
                      onPaginationCompleted: (direction) {
                        print("pagination completed $direction");
                      },
                      monthBuilder: (context, month, year) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            DateFormat("MMM yyyy").format(
                              DateTime(year, month),
                            ),
                            style: kMediumMedium.copyWith(
                                color: Styles.kPrimaryColor),
                          ),
                        );
                      },
                      dayBuilder: (context, date) {
                        final inRange = isInRange(date, departDate, returnDate);
                        final event = prices.firstWhereOrNull(
                            (event) => isSameDay(event.date, date));
                        final isBefore = date.isBefore(DateTime.now());
                        return Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: inRange
                                ? Styles.kPrimaryColor
                                : Colors.transparent,
                            border: Border.all(
                              color: isBefore ? Colors.grey : Colors.white,
                              width: 0.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${date.day}",
                                style: kSmallRegular.copyWith(
                                  color: inRange ? Colors.white : null,
                                ),
                              ),
                              Spacer(),
                              Visibility(
                                visible:
                                    priceState.blocState == BlocState.loading,
                                child: ShimmerRectangle(
                                  height: 10,
                                  width: 30,
                                ),
                                replacement: event == null
                                    ? SizedBox()
                                    : Align(
                                        alignment: Alignment.centerRight,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "MYR",
                                              style: kExtraSmallHeavy.copyWith(
                                                color: inRange
                                                    ? Colors.white
                                                    : null,
                                              ),
                                            ),
                                            Text(
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
                                          ],
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
              )
            : TableCalendar(
                calendarBuilders: CalendarBuilders(
                  headerTitleBuilder: (context, dateTime) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat.MMMM().format(dateTime).toUpperCase(),
                          style: kMediumHeavy.copyWith(letterSpacing: 1.5),
                        ),
                        Text(
                          " / ${DateFormat.y().format(dateTime)}",
                          style: kMediumHeavy.copyWith(
                              color: Styles.kDisabledButton,
                              letterSpacing: 1.5),
                        ),
                      ],
                    );
                  },
                  singleMarkerBuilder:
                      (BuildContext context, date, DateRangePrice? events) {
                    if (priceState.blocState == BlocState.loading) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: ShimmerRectangle(
                          height: 10,
                          width: 30,
                        ),
                      );
                    }
                    if (events == null) return SizedBox();
                    return Column(
                      children: [
                        kVerticalSpacerMini,
                        Text(
                          "MYR",
                          style: kTinyHeavy,
                        ),
                        Text(
                          NumberUtils.formatNum(departDate == null
                              ? events.returnPrice
                              : events.departPrice),
                          style: kSmallSemiBold.copyWith(
                              color: Styles.kPrimaryColor),
                        ),
                      ],
                    );
                  },
                ),
                rowHeight: 80,
                eventLoader: (day) {
                  if (priceState.blocState == BlocState.loading) {
                    return [DateRangePrice()];
                  }
                  return prices
                      .where((event) => isSameDay(event.date, day))
                      .toList();
                },
                headerStyle: const HeaderStyle(formatButtonVisible: false),
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(Duration(days: 90)),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                rangeStartDay: departDate,
                rangeEndDay: returnDate,
                calendarFormat: CalendarFormat.month,
                rangeSelectionMode: !isRoundTrip
                    ? RangeSelectionMode.disabled
                    : _rangeSelectionMode,
                onDaySelected: (selectedDay, focusedDay) {
                  if (isRoundTrip) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        context.read<FilterCubit>().updateDate(
                            departDate: _selectedDay, returnDate: null);
                        _rangeSelectionMode = RangeSelectionMode.toggledOff;
                      });
                    }
                  } else {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      context.read<FilterCubit>().updateDate(
                          departDate: _selectedDay, returnDate: null);
                    });
                    context.router.pop();
                  }
                },
                onRangeSelected: (start, end, focusedDay) {
                  context
                      .read<FilterCubit>()
                      .updateDate(departDate: start, returnDate: end);
                  setState(() {
                    _selectedDay = null;
                    _focusedDay = focusedDay;
                    _rangeSelectionMode = RangeSelectionMode.toggledOn;
                  });
                  print("on range selected ${start} ${end}");
                  if (start != null && end != null) {
                    context.router.pop();
                  }
                },
                onPageChanged: (focusedDay) {
                  print("page changed $focusedDay");
                  // context
                  //     .read<FilterCubit>()
                  //     .updateDate(departDate: focusedDay, returnDate: null);
                  context
                      .read<PriceRangeCubit>()
                      .getPrices(filterCubit.state, startFilter: focusedDay);
                  _focusedDay = focusedDay;
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Styles.kPrimaryColor,
                    border: Border.all(color: Styles.kPrimaryColor),
                    shape: BoxShape.circle,
                  ),
                  rangeHighlightColor: Styles.kPrimaryColor.withOpacity(0.3),
                  rangeStartDecoration: BoxDecoration(
                    color: returnDate == null
                        ? Colors.white
                        : Styles.kPrimaryColor,
                    border: Border.all(color: Styles.kPrimaryColor),
                    shape: BoxShape.circle,
                  ),
                  rangeStartTextStyle: kMediumMedium.copyWith(
                    color: returnDate != null
                        ? Colors.white
                        : Styles.kPrimaryColor,
                  ),
                  rangeEndDecoration: BoxDecoration(
                    color: Styles.kPrimaryColor,
                    border: Border.all(color: Styles.kPrimaryColor),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
      ),
    );
  }
}
