import 'package:app/pages/checkout/pages/booking_details/ui/list_of_passenger_info.dart';
import 'package:app/pages/checkout/pages/insurance/ui/zurich_container.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';

class InsuranceView extends StatelessWidget {
  const InsuranceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      children: [
        Text(
          "MYAirline Travel Insurance",
          style: kHugeHeavy,
        ),
        kVerticalSpacer,
        ZurichContainer(),
      ],
    );
  }
}

