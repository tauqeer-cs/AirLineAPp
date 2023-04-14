import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class AppTooltip extends StatelessWidget {
  final Widget child;
  const AppTooltip({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      triggerMode: TooltipTriggerMode.tap,
      preferredDirection: AxisDirection.up,
      backgroundColor: Color.fromRGBO(237, 242, 244, 1),
      margin: EdgeInsets.all(16),
      child: Icon(
        Icons.info,
        color: Styles.kPrimaryColor,
      ),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
