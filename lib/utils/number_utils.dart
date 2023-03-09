import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NumberUtils {
  static String formatNumber(double? number) {
    NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");
    return numberFormat.format(number ?? 0);
  }

  static String formatNum(num? number) {
    NumberFormat numberFormat = NumberFormat("#,##0.00", "en_US");
    return numberFormat.format(number ?? 0);
  }

  static String formatNumberNoTrailing(num? number) {
    NumberFormat numberFormat = NumberFormat("#,##0", "en_US");
    return numberFormat.format(number ?? 0);
  }

  static String formatLotDigit(double? number) {
    NumberFormat numberFormat = NumberFormat("#,##0.0000000000", "en_US");
    final string = numberFormat.format(number ?? 0);
    RegExp regex = RegExp(r"([.]*0+)(?!.*\d)");
    String s = string.toString().replaceAll(regex, '');
    String r = s.toString().replaceAll("-", '');
    return r;
  }

  static String formatVolume(double? num) {
    if (num == null) return "";
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(2)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(2)} B";
    } else {
      return num.toString();
    }
  }

  static String getTimeString(num? num) {
    final value = (num ?? 0).toInt();
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    return '${hour.toString().padLeft(2, "0")} hr ${minutes.toString().padLeft(2, "0")} mins';
  }
}

extension DigitColor on double {
  Color? getColor() {
    if (this == 0) return null;
    if (this < 0) return Colors.red;
    return Colors.green;
  }
}
