import 'package:app/widgets/animations/shimmer_rectangle.dart';
import 'package:app/widgets/containers/bordered_container.dart';
import 'package:flutter/material.dart';

class TextFieldLoader extends StatelessWidget {
  const TextFieldLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
      child: ShimmerRectangle(
        height: 50,
        width: 500,
      ),
    );
  }
}
