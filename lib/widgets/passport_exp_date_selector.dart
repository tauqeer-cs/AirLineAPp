import 'package:flutter/material.dart';

class PassportExpiryDatePicker extends StatefulWidget {
  @override
  _PassportExpiryDatePickerState createState() =>
      _PassportExpiryDatePickerState();
}

class _PassportExpiryDatePickerState extends State<PassportExpiryDatePicker> {
  late int selectedDay;
  late int selectedMonth;
  late int selectedYear;
  late int maxYear;

  @override
  void initState() {
    super.initState();
    final currentDate = DateTime.now();
    selectedDay = currentDate.day;
    selectedMonth = currentDate.month;
    selectedYear = currentDate.year;
    maxYear = currentDate.year + 10; // Allow selecting dates up to 10 years from now
  }

  @override
  Widget build(BuildContext context) {
    final List<String> months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];

    final List<int> daysInMonth = [
      31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
    ];

    int maxDays = daysInMonth[selectedMonth - 1];
    if (selectedMonth == 2 && _isLeapYear(selectedYear)) {
      maxDays = 29;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Select Passport Expiry Date',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: DropdownButton<int>(
                value: selectedDay,
                onChanged: (newValue) {
                  setState(() {
                    selectedDay = newValue!;
                  });
                },
                items: List<DropdownMenuItem<int>>.generate(
                  maxDays,
                      (index) => DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text((index + 1).toString()),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: DropdownButton<int>(
                value: selectedMonth,
                onChanged: (newValue) {
                  setState(() {
                    selectedMonth = newValue!;
                  });
                },
                items: List<DropdownMenuItem<int>>.generate(
                  12,
                      (index) => DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text(months[index]),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: DropdownButton<int>(
                value: selectedYear,
                onChanged: (newValue) {
                  setState(() {
                    selectedYear = newValue!;
                  });
                },
                items: List<DropdownMenuItem<int>>.generate(
                  maxYear - selectedYear + 1,
                      (index) => DropdownMenuItem<int>(
                    value: selectedYear + index,
                    child: Text((selectedYear + index).toString()),
                  ),
                ),
              ),
            ),
          ],
        ),
        Text(
          'Valid Month: ${_getValidMonth(selectedMonth)}',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  bool _isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  String _getValidMonth(int selectedMonth) {
    final thirtyDaysMonths = [4, 6, 9, 11]; // April, June, September, November
    if (selectedMonth == 2) {
      return 'February';
    } else if (thirtyDaysMonths.contains(selectedMonth)) {
      return 'April, June, September, November';
    } else {
      return 'All months';
    }
  }
}

