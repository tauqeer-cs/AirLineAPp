import 'package:app/theme/spacer.dart';
import 'package:app/widgets/animations/shimmer_rectangle.dart';
import 'package:flutter/material.dart';

class BookingLoader extends StatelessWidget {
  const BookingLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerRectangle(height: 50),
        kVerticalSpacer,
        ShimmerRectangle(),
        kVerticalSpacer,
        ShimmerRectangle(height: 300),
        kVerticalSpacerBig,
        ShimmerRectangle(height: 50),
        kVerticalSpacer,
        ShimmerRectangle(),
        kVerticalSpacer,
        ShimmerRectangle(height: 300),
      ],
    );
  }
}
