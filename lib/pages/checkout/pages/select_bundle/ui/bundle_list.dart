import 'package:app/pages/checkout/ui/person_selector.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';

class BundleList extends StatelessWidget {
  const BundleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kVerticalSpacer,
        Text("Bundle", style: kGiantHeavy),
        PersonSelector(),
        Container(),
      ],
    );
  }
}
