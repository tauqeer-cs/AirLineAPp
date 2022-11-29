import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlStyle {
  static Map<String, Style> htmlStyle(
      {Color? overrideColor, double? overrideSize}) {
    return {
      "*": Style(
        fontSize: FontSize(overrideSize ?? 14),
        color: overrideColor ?? Styles.kSubTextColor,
      ),
      "span": Style(
        fontSize: FontSize(overrideSize ?? 14),
        color: overrideColor ?? Styles.kSubTextColor,
        fontWeight: FontWeight.w400,
        height: Height(1.5),
      ),
      "p": Style(
        fontSize: FontSize(overrideSize ?? 14),
        color: overrideColor ?? Styles.kSubTextColor,
        fontWeight: FontWeight.w400,
      ),
    };
  }
}
