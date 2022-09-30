import 'package:app/theme/styles.dart';
import 'package:flutter/material.dart';

class AppDividerWidget extends StatelessWidget {
  final bool isLight;

  const AppDividerWidget({Key? key, this.isLight=false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: isLight ? Styles.kPrimaryColor: Styles.kPrimaryColor,
      thickness: 2,
      height: 1,
    );
  }
}
