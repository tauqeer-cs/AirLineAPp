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
      child: new ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: new BackdropFilter(
          filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: new Container(
            padding: EdgeInsets.all(12),
            decoration: new BoxDecoration(
                color: color != null
                    ? color?.withOpacity(0.8)
                    : Colors.white.withOpacity(0.8)),
            child: new Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
