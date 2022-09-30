import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_sheet_handler.dart';
import 'package:app/widgets/bottom_sheet_header_widget.dart';
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
    final departDate = context.watch<FilterCubit>().state.departDate;
    final returnDate = context.watch<FilterCubit>().state.returnDate;

    return Padding(
      padding: kPagePadding,
      child: SizedBox(
        height: 0.55.sh,
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
          ),
          headerStyle: const HeaderStyle(formatButtonVisible: false),
          firstDay: DateTime.now(),
          lastDay: DateTime.now().add(Duration(days: 90)),
          focusedDay: departDate ?? _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          rangeStartDay: departDate,
          rangeEndDay: returnDate,
          calendarFormat: CalendarFormat.month,
          rangeSelectionMode: _rangeSelectionMode,
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                context
                    .read<FilterCubit>()
                    .updateDate(departDate: null, returnDate: null);
                _rangeSelectionMode = RangeSelectionMode.toggledOff;
              });
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
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Colors.white,
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
