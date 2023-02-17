import 'package:app/theme/styles.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? edgeInsets;
  final bool isHighlighted;
  final bool roundedInBottom;

  const AppCard(
      {Key? key,
      required this.child,
      this.edgeInsets,
      this.isHighlighted = false,
      this.customColor,
      this.roundedInBottom = false,})
      : super(key: key);

  final Color? customColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgeInsets ?? const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: customColor ?? Theme.of(context).cardColor,
        borderRadius: roundedInBottom
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              )
            : BorderRadius.circular(15),
        boxShadow: [
          1 == 1
              ? BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, 2), // moves the shadow downwards
                )
              : BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 4), // changes position of shadow
                ),
        ],
        border: Border.all(
          color: isHighlighted ? Styles.kPrimaryColor : const Color(0xFFE0E0E0),
          width: 2,
        ),
      ),
      child: child,
    );
  }
}

class AppCardCalendar extends StatelessWidget {
  final Widget child;
  final EdgeInsets? edgeInsets;
  final bool isHighlighted;

  const AppCardCalendar(
      {Key? key,
      required this.child,
      this.edgeInsets,
      this.isHighlighted = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgeInsets ?? const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        border: Border.all(
          color: isHighlighted ? Styles.kPrimaryColor : const Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
