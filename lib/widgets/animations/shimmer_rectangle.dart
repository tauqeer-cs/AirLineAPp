import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerRectangle extends StatelessWidget {
  final double? width, height, radius;

  const ShimmerRectangle({
    Key? key,
    this.width = 500,
    this.height = 25,
    this.radius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFD0D1E1),
      highlightColor: const Color(0xFF9899B0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 8),
          color: Colors.white,
        ),
        width: width,
        height: height,
      ),
    );
  }
}
