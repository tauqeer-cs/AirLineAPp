import 'package:flutter/material.dart';

enum SupportedLocale { en, my }

/// Defines widgets which are to used as DropDown Date Picker.
// ignore: must_be_immutable
class DropdownDatePicker extends StatefulWidget {
  ///DropDown select text style
  final TextStyle? textStyle;

  ///DropDown container box decoration
  final BoxDecoration? boxDecoration;

  ///InputDecoration for DropDown
  final InputDecoration? inputDecoration;

  ///DropDown expand icon
  final Icon? icon;

  ///Start year for date picker
  ///Default is 1900
  final int? startYear;

  ///End year for date picker
  ///Default is Current year
  final int? endYear;

  ///Start year for date picker
  ///Default is 1900
  final int? startMonth;

  ///End year for date picker
  ///Default is Current year
  final int? endMonth;

  ///Start year for date picker
  ///Default is 1900
  final int? startDate;

  ///End year for date picker
  ///Default is Current year
  final int? endDate;

  ///width between each drop down
  ///Default is 12.0
  final double width;

  ///Return selected date
  ValueChanged<String?>? onChangedDay;

  ///Return selected month
  ValueChanged<String?>? onChangedMonth;

  ///Return selected year
  ValueChanged<String?>? onChangedYear;

  ///Error message for Date
  String errorDay;

  ///Error message for Month
  String errorMonth;

  ///Error message for Year
  String errorYear;

  ///Hint for Month drop down
  ///Default is "Month"
  String hintMonth;

  ///Hint for Year drop down
  ///Default is "Year"
  String hintYear;

  ///Hint for Day drop down
  ///Default is "Day"
  String hintDay;

  ///Hint Textstyle for drop down
  TextStyle? hintTextStyle;

  ///Is Form validator enabled
  ///Default is false
  final bool isFormValidator;

  ///Is Expanded for dropdown
  ///Default is true
  final bool isExpanded;

  ///Selected Day between 1 to 31
  final int? selectedDay;

  ///Selected Month between 1 to 12
  final int? selectedMonth;

  ///Selected Year between startYear and endYear
  final int? selectedYear;

  ///Default [isDropdownHideUnderline] = false. Wrap with DropdownHideUnderline for the dropdown to hide the underline.
  final bool isDropdownHideUnderline;

  final SupportedLocale locale;

  /// default true
  bool showYear;
  bool showMonth;
  bool showDay;

  /// month expanded flex
  int monthFlex;

  /// day expanded flex
  int dayFlex;

  /// year expanded flex
  int yearFlex;

  DropdownDatePicker({
    super.key,
    this.textStyle,
    this.boxDecoration,
    this.inputDecoration,
    this.icon,
    this.startYear,
    this.endYear,
    this.width = 12.0,
    this.onChangedDay,
    this.onChangedMonth,
    this.onChangedYear,
    this.isDropdownHideUnderline = false,
    this.errorDay = 'Please select day',
    this.errorMonth = 'Please select month',
    this.errorYear = 'Please select year',
    this.hintMonth = 'Month',
    this.hintDay = 'Day',
    this.hintYear = 'Year',
    this.hintTextStyle,
    this.isFormValidator = false,
    this.isExpanded = true,
    this.selectedDay,
    this.selectedMonth,
    this.selectedYear,
    this.locale = SupportedLocale.en,
    this.showDay = true,
    this.showMonth = true,
    this.showYear = true,
    this.monthFlex = 2,
    this.dayFlex = 1,
    this.yearFlex = 2,
    this.startMonth,
    this.endMonth,
    this.startDate,
    this.endDate,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DropdownDatePickerState createState() => _DropdownDatePickerState();
}

class _DropdownDatePickerState extends State<DropdownDatePicker> {
  var monthselVal = '';
  var dayselVal = '';
  var yearselVal = '';
  int daysIn = 32;
  late List<int> listdates = [];
  late List<int> listyears = [];
  late List<int> listMonths = [];

  @override
  void initState() {
    super.initState();
    print("end year is ${widget.endYear} start year ${widget.startYear}");
    print("end month is ${widget.endMonth} start month ${widget.startMonth}");
    print("end date is ${widget.endMonth} start date ${widget.startDate}");

    dayselVal = widget.selectedDay != null ? widget.selectedDay.toString() : '';
    monthselVal =
        widget.selectedMonth != null ? widget.selectedMonth.toString() : '';
    yearselVal =
        widget.selectedYear != null ? widget.selectedYear.toString() : '';
    listyears =
        Iterable<int>.generate((widget.endYear ?? DateTime.now().year) + 1)
            .skip(widget.startYear ?? 1900)
            .toList()
            .reversed
            .toList();
    adjustDates();
    adjustMonths();
  }

  bool get isStartYearSelected => yearselVal == widget.startYear.toString();

  bool get isStartMonthSelected => monthselVal == widget.startMonth.toString();

  bool get isEndYearSelected => yearselVal == widget.endYear.toString();

  bool get isEndMonthSelected => monthselVal == widget.endMonth.toString();

  adjustDates() {
    print("adjust dates");
    if (widget.startDate != null &&
        isStartYearSelected &&
        isStartMonthSelected) {
      listdates.removeRange(0, widget.startDate!);
    } else if (widget.endDate != null &&
        isEndYearSelected &&
        isEndMonthSelected) {
      listdates.removeRange(daysInMonth, widget.endDate!);
    } else {
      print("repopulate date");
      repopulateDate();
    }
  }

  adjustMonths() {
    print("adjust months $isEndYearSelected");
    if (widget.startMonth != null && isStartYearSelected) {
      listMonths.removeRange(0, widget.startMonth!);
    } else if (widget.endMonth != null && isEndYearSelected) {
      print("end year is true");
      listMonths.removeRange(widget.endMonth!, 12);
    } else {
      repopulateMonth();
    }
  }

  repopulateDate() {
    if(yearselVal == '' || monthselVal == ''){
      listdates = [];
      return;
    }
    listdates = Iterable<int>.generate(daysInMonth).skip(1).toList();
  }

  repopulateMonth() {
    if(yearselVal == ''){
      listdates = [];
      return;
    }
    listMonths = Iterable<int>.generate(13).skip(1).toList();
  }

  ///Month selection dropdown function
  monthSelected(value) {
    widget.onChangedMonth!(value);
    monthselVal = value;
    adjustDates();
    checkDates(daysInMonth);
    update();
  }

  ///check dates for selected month and year
  void checkDates(days) {
    print("month selected is $monthselVal");
    if(monthselVal == ''){
      print("month is empty in check dates");
      dayselVal = '';
      widget.onChangedDay!('');
      update();
      return;
    }
    if (dayselVal != '') {
      if (int.parse(dayselVal) > days) {
        dayselVal = '';
        widget.onChangedDay!('');
        update();
      } else if (!listdates.contains(int.parse(dayselVal))) {
        dayselVal = '';
        widget.onChangedDay!('');
        update();
      }
    }
  }

  ///check months for selected year
  void checkMonths() {
    if (monthselVal != '') {
      if (listMonths.contains(int.parse(monthselVal))) {
        monthselVal = '';
        widget.onChangedMonth!('');
        update();
      }
    }
  }

  ///find days in month and year
  int get daysInMonth {
    if (yearselVal == '' || monthselVal == '') return 1;
    final year = int.parse(yearselVal);
    final month = int.parse(monthselVal);
    return DateTimeRange(
            start: DateTime(year, month, 1), end: DateTime(year, month + 1))
        .duration
        .inDays;
  }

  ///day selection dropdown function
  daysSelected(value) {
    widget.onChangedDay!(value);
    dayselVal = value;
    update();
  }

  ///year selection dropdown function
  yearsSelected(value) {
    widget.onChangedYear!(value);
    yearselVal = value;
    adjustMonths();
    checkMonths();
    adjustDates();
    checkDates(daysInMonth);
    update();
  }

  String numberToName(int number) {
    switch (widget.locale) {
      case SupportedLocale.en:
        switch (number) {
          case 1:
            return "January";
          case 2:
            return "February";
          case 3:
            return "March";
          case 4:
            return "April";
          case 5:
            return "May";
          case 6:
            return "June";
          case 7:
            return "July";
          case 8:
            return "August";
          case 9:
            return "September";
          case 10:
            return "October";
          case 11:
            return "November";
          case 12:
            return "December";
        }
        break;
      case SupportedLocale.my:
        switch (number) {
          case 1:
            return "January";
          case 2:
            return "February";
          case 3:
            return "March";
          case 4:
            return "April";
          case 5:
            return "May";
          case 6:
            return "June";
          case 7:
            return "July";
          case 8:
            return "August";
          case 9:
            return "September";
          case 10:
            return "October";
          case 11:
            return "November";
          case 12:
            return "December";
        }
    }
    return "";
  }

  ///list of months , en
  List<dynamic> listMonths_en = [
    {"id": 1, "value": "January"},
    {"id": 2, "value": "February"},
    {"id": 3, "value": "March"},
    {"id": 4, "value": "April"},
    {"id": 5, "value": "May"},
    {"id": 6, "value": "June"},
    {"id": 7, "value": "July"},
    {"id": 8, "value": "August"},
    {"id": 9, "value": "September"},
    {"id": 10, "value": "October"},
    {"id": 11, "value": "November"},
    {"id": 12, "value": "December"}
  ];

  ///list of months , zh_CN
  List<dynamic> listMonths_zh_CN = [
    {"id": 1, "value": "1月"},
    {"id": 2, "value": "2月"},
    {"id": 3, "value": "3月"},
    {"id": 4, "value": "4月"},
    {"id": 5, "value": "5月"},
    {"id": 6, "value": "6月"},
    {"id": 7, "value": "7月"},
    {"id": 8, "value": "8月"},
    {"id": 9, "value": "9月"},
    {"id": 10, "value": "10月"},
    {"id": 11, "value": "11月"},
    {"id": 12, "value": "12月"}
  ];

  ///list of months , it_IT
  List<dynamic> listMonths_it_IT = [
    {"id": 1, "value": "Gennaio"},
    {"id": 2, "value": "Febbraio"},
    {"id": 3, "value": "Marzo"},
    {"id": 4, "value": "Aprile"},
    {"id": 5, "value": "Maggio"},
    {"id": 6, "value": "Giugno"},
    {"id": 7, "value": "Luglio"},
    {"id": 8, "value": "Agosto"},
    {"id": 9, "value": "Settembre"},
    {"id": 10, "value": "Ottobre"},
    {"id": 11, "value": "Novembre"},
    {"id": 12, "value": "Dicembre"}
  ];

  ///list of months , tr
  List<dynamic> listMonths_tr = [
    {"id": 1, "value": "Ocak"},
    {"id": 2, "value": "Şubat"},
    {"id": 3, "value": "Mart"},
    {"id": 4, "value": "Nisan"},
    {"id": 5, "value": "Mayıs"},
    {"id": 6, "value": "Haziran"},
    {"id": 7, "value": "Temmuz"},
    {"id": 8, "value": "Ağustos"},
    {"id": 9, "value": "Eylül"},
    {"id": 10, "value": "Ekim"},
    {"id": 11, "value": "Kasım"},
    {"id": 12, "value": "Aralık"}
  ];

  ///list of months , fr_FR
  List<dynamic> listMonths_fr_FR = [
    {"id": 1, "value": "Janvier"},
    {"id": 2, "value": "Fevrier"},
    {"id": 3, "value": "Mars"},
    {"id": 4, "value": "Avril"},
    {"id": 5, "value": "Mai"},
    {"id": 6, "value": "Juin"},
    {"id": 7, "value": "Juillet"},
    {"id": 8, "value": "Aout"},
    {"id": 9, "value": "Septembre"},
    {"id": 10, "value": "Octobre"},
    {"id": 11, "value": "Novembre"},
    {"id": 12, "value": "Décembre"}
  ];

  ///update function
  update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.showMonth)
          Expanded(
            flex: widget.monthFlex,
            child: Container(
              decoration: widget.boxDecoration ?? const BoxDecoration(),
              child: SizedBox(
                // height: 49,
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: widget.isDropdownHideUnderline
                      ? DropdownButtonHideUnderline(
                          child: monthDropdown(),
                        )
                      : monthDropdown(),
                ),
              ),
            ),
          ),
        if (widget.showMonth) w(widget.width),
        if (widget.showDay)
          Expanded(
            flex: widget.dayFlex,
            child: Container(
              decoration: widget.boxDecoration ?? const BoxDecoration(),
              child: SizedBox(
                  // height: 49,
                  child: ButtonTheme(
                alignedDropdown: true,
                child: widget.isDropdownHideUnderline
                    ? DropdownButtonHideUnderline(
                        child: dayDropdown(),
                      )
                    : dayDropdown(),
              )),
            ),
          ),
        if (widget.showDay) w(widget.width),
        if (widget.showYear)
          Expanded(
            flex: widget.yearFlex,
            child: Container(
              decoration: widget.boxDecoration ?? const BoxDecoration(),
              child: SizedBox(
                // height: 49,
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: widget.isDropdownHideUnderline
                      ? DropdownButtonHideUnderline(
                          child: yearDropdown(),
                        )
                      : yearDropdown(),
                ),
              ),
            ),
          ),
      ],
    );
  }

  ///month dropdown
  DropdownButtonFormField<String> monthDropdown() {
    return DropdownButtonFormField<String>(
        decoration: widget.inputDecoration ??
            (widget.isDropdownHideUnderline ? removeUnderline() : null),
        isExpanded: widget.isExpanded,
        hint: Text(widget.hintMonth, style: widget.hintTextStyle),
        icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
        value: monthselVal == '' ? null : monthselVal,
        onChanged: (value) {
          monthSelected(value);
        },
        validator: (value) {
          return widget.isFormValidator
              ? value == null
                  ? widget.errorMonth
                  : null
              : null;
        },
        items: listMonths.map((item) {
          return DropdownMenuItem<String>(
            value: item.toString(),
            child: Text(
              numberToName(item),
              style: widget.textStyle ??
                  const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
            ),
          );
        }).toList());
  }

  ///Remove underline from dropdown
  InputDecoration removeUnderline() {
    return const InputDecoration(
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
  }

  ///year dropdown
  DropdownButtonFormField<String> yearDropdown() {
    return DropdownButtonFormField<String>(
        decoration: widget.inputDecoration ??
            (widget.isDropdownHideUnderline ? removeUnderline() : null),
        hint: Text(widget.hintYear, style: widget.hintTextStyle),
        isExpanded: widget.isExpanded,
        icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
        value: yearselVal == '' ? null : yearselVal,
        onChanged: (value) {
          yearsSelected(value);
        },
        validator: (value) {
          return widget.isFormValidator
              ? value == null
                  ? widget.errorYear
                  : null
              : null;
        },
        items: listyears.map((item) {
          return DropdownMenuItem<String>(
            value: item.toString(),
            child: Text(
              item.toString(),
              style: widget.textStyle ??
                  const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
            ),
          );
        }).toList());
  }

  ///day dropdown
  DropdownButtonFormField<String> dayDropdown() {
    return DropdownButtonFormField<String>(
        decoration: widget.inputDecoration ??
            (widget.isDropdownHideUnderline ? removeUnderline() : null),
        hint: Text(widget.hintDay, style: widget.hintTextStyle),
        isExpanded: widget.isExpanded,
        icon: widget.icon ?? const Icon(Icons.expand_more, color: Colors.grey),
        value: dayselVal == '' ? null : dayselVal,
        onChanged: (value) {
          daysSelected(value);
        },
        validator: (value) {
          return widget.isFormValidator
              ? value == null
                  ? widget.errorDay
                  : null
              : null;
        },
        items: listdates.map((item) {
          return DropdownMenuItem<String>(
            value: item.toString(),
            child: Text(item.toString(),
                style: widget.textStyle ??
                    const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
          );
        }).toList());
  }

  ///sizedbox for width
  Widget w(double count) => SizedBox(
        width: count,
      );
}
