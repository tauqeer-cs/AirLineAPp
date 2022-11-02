import 'dart:ui';

import 'package:flutter/material.dart';

class GreyCard extends StatelessWidget {
  final Widget child;
  final BorderRadius? borderRadius;
  final EdgeInsets? edgeInsets;
  final double margin;
  const GreyCard({
    Key? key,
    required this.child,
    this.edgeInsets,
    this.borderRadius, this.margin = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5.0),
        child: Container(
          margin: EdgeInsets.all(margin),
          padding: edgeInsets ?? EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Color.fromRGBO(235, 235, 235, 0.75),
              borderRadius: borderRadius ?? BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.21),
                  spreadRadius: 0,
                  blurRadius: 6,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ]),
          child: child,
        ),
      ),
    );
  }
}
