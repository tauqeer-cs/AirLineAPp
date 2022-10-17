import 'package:app/theme/styles.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/shape/curve_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: 150,
              width: 1.sw,
              color: Styles.kPrimaryColor,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  "assets/images/design/skycloud.png",
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          ),
          SafeArea(child: child),
        ],
      ),
    );
  }
}
