import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCircle extends StatelessWidget {
  final double size;

  const ShimmerCircle({
    Key? key,
    this.size = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFD0D1E1),
      highlightColor: const Color(0xFF9899B0),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
        width: size,
        height: size,
      ),
    );
  }
}
