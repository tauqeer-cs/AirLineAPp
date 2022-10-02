import 'package:app/theme/styles.dart';
import 'package:flutter/material.dart';

class AppDividerWidget extends StatelessWidget {
  final Color? color;

  const AppDividerWidget({Key? key, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? Styles.kPrimaryColor,
      thickness: 2,
      height: 1,
    );
  }
}
