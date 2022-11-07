import 'package:app/theme/styles.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? edgeInsets;
  final bool isHighlighted;
  const AppCard({Key? key, required this.child, this.edgeInsets, this.isHighlighted = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgeInsets ?? const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
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
