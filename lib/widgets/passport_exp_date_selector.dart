import 'package:app/widgets/app_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../theme/styles.dart';
import '../theme/typography.dart';

class PassportExpiryDatePicker extends StatefulWidget {
  final Function(int, int, int,bool) onChanged;

  final DateTime? initalValues;

  const PassportExpiryDatePicker({super.key, required this.onChanged, required this.initalValues});

  @override
  _PassportExpiryDatePickerState createState() =>
      _PassportExpiryDatePickerState();
}

class _PassportExpiryDatePickerState extends State<PassportExpiryDatePicker> {
  late int selectedDay;
  late int selectedMonth;
  late int selectedYear;
  late int maxYear;

  bool isDateValid(int day, int month, int year) {
    // Get the current date
    DateTime currentDate = DateTime.now();

    // Check if the provided year is in the future
    if (year < currentDate.year) {
      return false;
    }

    // Check if the provided month is valid (1 to 12)
    if (month < 1 || month > 12) {
      return false;
    }

    // Check if the provided day is valid for the given month and year
    int daysInMonth = DateTime(year, month + 1, 0).day;
    if (day < 1 || day > daysInMonth) {
      return false;
    }

    // Create a DateTime object from the provided parameters
    DateTime selectedDate = DateTime(year, month, day);

    // Check if the selected date is today or in the past
    if (selectedDate.isBefore(currentDate) ||
        selectedDate.isAtSameMomentAs(currentDate)) {
      return false;
    }

    // All checks passed, the date is valid and not in the past or today
    return true;
  }

  @override
  void initState() {
    super.initState();
    if(this.widget.initalValues != null ) {

      selectedDay =  widget.initalValues?.day ?? 1;
      selectedMonth = widget.initalValues?.month ?? 1;
      selectedYear = widget.initalValues?.year ?? 2024;
      if(selectedYear == 1){
        initSetup();
      }
      maxYear = 2033;

    }
    else {
      initSetup();
    }

  }

  void initSetup() {
    final currentDate = DateTime.now().add(Duration(days: 30));
    selectedDay = 1;
    selectedMonth = 1;
    selectedYear = currentDate.year+1;
    maxYear = currentDate.year + 10;
    widget.onChanged(selectedDay, selectedMonth, selectedYear,true);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    final List<int> daysInMonth = [
      31,
      28,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];

    int maxDays = 31;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            'passportExpDate'.tr(),
            style: kSmallSemiBold.copyWith(color: Styles.kTextColor),
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: buildBoxDecoration(),
                child: DropdownButton<int>(
                  value: selectedDay,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      if (isDateValid(newValue, selectedMonth, selectedYear)) {
                        setState(() {
                          selectedDay = newValue;
                        });
                        widget.onChanged(newValue, selectedMonth, selectedYear,false);
                      } else {
                        Toast.of(context)
                            .show(message: 'Invalid date selected');
                      }
                    } else {
                      Toast.of(context).show(message: 'Invalid date selected');
                    }
                  },
                  items: List<DropdownMenuItem<int>>.generate(
                    maxDays,
                    (index) => DropdownMenuItem<int>(
                      value: index + 1,
                      child: Center(
                          child:
                              Text((index + 1).toString())), // Center the text
                    ),
                  ),
                  underline: const SizedBox(),
                  // Remove the underline
                  icon: buildIcon(),
                  // Dropdown arrow icon
                  iconSize: 24,
                  // Adjust the icon size
                  elevation: 0,
                  // No shadow
                  isExpanded: true,
                  style: setFont(),
                  // Customize font size
                  dropdownColor: Colors.white,
                  // Customize dropdown background color
                  itemHeight: itemHeight(),
                  // Customize item height
                  menuMaxHeight: 240, // Customize maximum menu height
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Container(
                decoration: buildBoxDecoration(),
                child: DropdownButton<int>(
                  value: selectedMonth,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      if (isDateValid(selectedDay, newValue, selectedYear)) {
                        setState(() {
                          selectedMonth = newValue!;
                        });
                        widget.onChanged(selectedDay, newValue, selectedYear,false);
                      } else {
                        Toast.of(context)
                            .show(message: 'Invalid month selected');
                      }
                    } else {
                      Toast.of(context).show(message: 'Invalid month selected');
                    }
                  },
                  items: List<DropdownMenuItem<int>>.generate(
                    12,
                    (index) => DropdownMenuItem<int>(
                      value: index + 1,
                      child:
                          Center(child: Text(months[index])), // Center the text
                    ),
                  ),
                  underline: SizedBox(),
                  // Remove the underline
                  icon: buildIcon(),
                  // Dropdown arrow icon
                  iconSize: 32,
                  // Adjust the icon size
                  elevation: 0,
                  // No shadow
                  isExpanded: true,
                  style: setFont(),
                  // Customize font size
                  dropdownColor: Colors.white,
                  // Customize dropdown background color
                  itemHeight: itemHeight(),
                  // Customize item height
                  menuMaxHeight: 240, // Customize maximum menu height
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 1,
              child: Container(
                decoration: buildBoxDecoration(),
                child: DropdownButton<int>(
                  value: selectedYear,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      if (isDateValid(selectedDay, selectedMonth, newValue)) {
                        setState(() {
                          selectedYear = newValue;
                        });
                        widget.onChanged(selectedDay, selectedMonth, newValue,false);
                      } else {
                        Toast.of(context)
                            .show(message: 'Invalid month selected');
                      }

                      setState(() {
                        selectedYear = newValue!;
                      });
                    } else {
                      Toast.of(context).show(message: 'Invalid year selected');
                    }
                  },
                  items: [
                    DropdownMenuItem<int>(
                      value: 2023,
                      child: Center(
                          child: Text((2023).toString())), // Center the text
                    ),
                    DropdownMenuItem<int>(
                      value: 2024,
                      child: Center(
                          child: Text((2024).toString())), // Center the text
                    ),
                    DropdownMenuItem<int>(
                      value: 2025,
                      child: Center(
                          child: Text((2025).toString())), // Center the text
                    ),
                    DropdownMenuItem<int>(
                      value: 2026,
                      child: Center(
                          child: Text((2026).toString())), // Center the text
                    ),
                    DropdownMenuItem<int>(
                      value: 2027,
                      child: Center(
                          child: Text((2027).toString())), // Center the text
                    ),
                    DropdownMenuItem<int>(
                      value: 2028,
                      child: Center(
                          child: Text((2028).toString())), // Center the text
                    ),
                    DropdownMenuItem<int>(
                      value: 2029,
                      child: Center(
                          child: Text((2029).toString())), // Center the text
                    ),
                    DropdownMenuItem<int>(
                      value: 2030,
                      child: Center(
                          child: Text((2030).toString())), // Center the text
                    ),
                    DropdownMenuItem<int>(
                      value: 2031,
                      child: Center(
                          child: Text((2031).toString())), // Center the text
                    ),
                    DropdownMenuItem<int>(
                      value: 2032,
                      child: Center(
                          child: Text((2032).toString())), // Center the text
                    ),
                    DropdownMenuItem<int>(
                      value: 2033,
                      child: Center(
                          child: Text((2033).toString())), // Center the text
                    ),

                  ],
                  underline: SizedBox(),
                  // Remove the underline
                  icon: buildIcon(),
                  // Dropdown arrow icon
                  iconSize: 32,
                  // Adjust the icon size
                  elevation: 0,
                  // No shadow
                  isExpanded: true,
                  style: setFont(),
                  // Customize font size
                  dropdownColor: Colors.white,
                  // Customize dropdown background color
                  itemHeight: itemHeight(),
                  // Customize item height
                  menuMaxHeight: 240, // Customize maximum menu height
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Styles.kInactiveColor),
    );
  }

  double itemHeight() => 48;

  TextStyle setFont() => kMediumMedium.copyWith(color: Styles.kTextColor);

  Icon buildIcon() => Icon(
        Icons.keyboard_arrow_down_sharp,
        color: Styles.kInactiveColor,
      );
}
