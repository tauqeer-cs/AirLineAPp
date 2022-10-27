import 'package:app/theme/styles.dart';
import 'package:flutter/material.dart';

class BorderedContainer extends StatelessWidget {
  final Widget child;

  const BorderedContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Styles.kBorderColor),
        ),
      ),
      child: Center(child: child),
    );
  }
}
