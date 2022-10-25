import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppLogoWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final bool useWhite;

  const AppLogoWidget({
    Key? key,
    this.width,
    this.height,
    this.useWhite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      useWhite
          ? "assets/images/native/logo_white.png"
          : "assets/images/native/logo.png",
      width: width ?? 183.w,
      height: height ?? 72.h,
      fit: BoxFit.contain,
    );
  }
}
