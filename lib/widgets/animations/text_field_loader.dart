import 'package:app/widgets/animations/shimmer_rectangle.dart';
import 'package:app/widgets/containers/bordered_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldLoader extends StatelessWidget {
  const TextFieldLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShimmerRectangle(
      height: 50,
      width: 500.w,
    );
  }
}
