import 'package:app/theme/styles.dart';
import 'package:flutter/material.dart';

class WaveBackground extends StatelessWidget {
  final Widget child;

  const WaveBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Styles.kPrimaryColor,
        ),
        Positioned.fill(
          child: Image.asset(
            "assets/images/design/gridBackground.png",
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}
