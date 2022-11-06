import 'dart:ui';

import 'package:flutter/material.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final Color? color;

  const GlassCard({Key? key, required this.child, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: color != null
                    ? color?.withOpacity(0.8)
                    : Colors.white.withOpacity(0.8)),
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
