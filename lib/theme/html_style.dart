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
        padding: EdgeInsets.zero,
        margin: Margins.zero,
      ),
      "span": Style(
        fontSize: FontSize(overrideSize ?? 14),
        color: overrideColor ?? Styles.kSubTextColor,
        fontWeight: FontWeight.w400,
        height: Height(1.5),
        padding: EdgeInsets.zero,
        margin: Margins.zero,
      ),
      "p": Style(
        fontSize: FontSize(overrideSize ?? 14),
        color: overrideColor ?? Styles.kSubTextColor,
        fontWeight: FontWeight.w400,
        padding: EdgeInsets.zero,
        margin: Margins.zero,

      ),
      "a": Style(
        fontSize: FontSize(overrideSize ?? 14),
        color: Styles.kBlueColor,
        textDecorationColor: Styles.kBlueColor,
        fontWeight: FontWeight.w700,
        padding: EdgeInsets.zero,
        margin: Margins.zero,

      ),
    };
  }
}
