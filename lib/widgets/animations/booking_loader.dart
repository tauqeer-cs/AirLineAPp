import 'package:app/theme/spacer.dart';
import 'package:app/widgets/animations/shimmer_rectangle.dart';
import 'package:flutter/material.dart';

class BookingLoader extends StatelessWidget {
  const BookingLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ShimmerRectangle(height: 50),
        kVerticalSpacer,
        const ShimmerRectangle(),
        kVerticalSpacer,
        const ShimmerRectangle(height: 300),
        kVerticalSpacerBig,
        const ShimmerRectangle(height: 50),
        kVerticalSpacer,
        const ShimmerRectangle(),
        kVerticalSpacer,
        const ShimmerRectangle(height: 300),
      ],
    );
  }
}
