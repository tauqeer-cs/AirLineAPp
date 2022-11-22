import 'dart:ui';

import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';

class SignupContainer extends StatelessWidget {
  final Widget child;
  final int step;
  final String? name;

  const SignupContainer(
      {Key? key, required this.child, required this.step, this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(40),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(40),
            ),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [
                  0.01,
                  0.1,
                ],
                colors: [
                  Colors.white.withOpacity(0.5),
                  Colors.white
                ]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kVerticalSpacer,
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
