import 'package:app/app/app_bloc_helper.dart';
import 'package:app/models/search_date_range.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/bloc/price_range/price_range_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/widgets/animations/shimmer_rectangle.dart';
import 'package:app/widgets/app_sheet_handler.dart';
import 'package:app/widgets/bottom_sheet_header_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarSheet extends StatefulWidget {
  const CalendarSheet({Key? key}) : super(key: key);

  @override
  CalendarSheetState createState() => CalendarSheetState();
}

class CalendarSheetState extends State<CalendarSheet> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

  @override
  void initState() {
    super.initState();
  }

  saveCalendar() {}

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
        height: 0.75.sh,
        child: TableCalendar(
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
                        color: Styles.kDisabledButton, letterSpacing: 1.5),
                  ),
                ],
              );
            },
            singleMarkerBuilder:
                (BuildContext context, date, DateRangePrice? events) {
              if (priceState.blocState == BlocState.loading)
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ShimmerRectangle(
                    height: 10,
                    width: 30,
                  ),
                );
              if (events == null) return SizedBox();
              return Column(
                children: [
                  kVerticalSpacerMini,
                  Text(
                    "MYR",
                    style: kTinyHeavy,
                  ),
                  Text(
                    NumberUtils.formatNum(departDate==null? events.returnPrice : events.departPrice),
                    style: kSmallSemiBold.copyWith(color: Styles.kPrimaryColor),
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
            return prices.where((event) => isSameDay(event.date, day)).toList();
          },
          headerStyle: const HeaderStyle(formatButtonVisible: false),
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(Duration(days: 90)),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          rangeStartDay: departDate,
          rangeEndDay: returnDate,
          calendarFormat: CalendarFormat.month,
          rangeSelectionMode:
              !isRoundTrip ? RangeSelectionMode.disabled : _rangeSelectionMode,
          onDaySelected: (selectedDay, focusedDay) {
            if (isRoundTrip) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  context
                      .read<FilterCubit>()
                      .updateDate(departDate: _selectedDay, returnDate: null);
                  _rangeSelectionMode = RangeSelectionMode.toggledOff;
                });
              }
            } else {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                context
                    .read<FilterCubit>()
                    .updateDate(departDate: _selectedDay, returnDate: null);
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
            if(start!=null && end!=null){
              context.router.pop();
            }
          },
          onPageChanged: (focusedDay) {
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
              color: returnDate == null ? Colors.white : Styles.kPrimaryColor,
              border: Border.all(color: Styles.kPrimaryColor),
              shape: BoxShape.circle,
            ),
            rangeStartTextStyle: kMediumMedium.copyWith(
              color: returnDate != null ? Colors.white : Styles.kPrimaryColor,
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
