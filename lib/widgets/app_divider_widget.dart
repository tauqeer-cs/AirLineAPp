import 'package:app/theme/styles.dart';
import 'package:flutter/material.dart';

class AppDividerWidget extends StatelessWidget {
  final Color? color;

  const AppDividerWidget({Key? key, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? Color.fromRGBO(237, 242, 244, 1),
      thickness: 2,
      height: 1,
    );
  }
}


class AppDividerFadeWidget extends StatelessWidget {

  const AppDividerFadeWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Styles.kTextColor.withOpacity(0.6),
      thickness: 2,
      height: 1,
    );
  }
}