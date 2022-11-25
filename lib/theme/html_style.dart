import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlStyle{
  static Map<String, Style> htmlStyle(){
    return {
      "span": Style(
        fontSize: FontSize(14),
        color: Styles.kSubTextColor,
        fontWeight: FontWeight.w400,
        height: Height(1.5),
      ),
      "p": Style(
        fontSize: FontSize(14),
        color: Styles.kSubTextColor,
        fontWeight: FontWeight.w400,
      ),
    };
  }
}