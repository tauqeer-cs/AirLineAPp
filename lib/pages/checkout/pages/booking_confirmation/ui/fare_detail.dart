import 'package:app/models/fare_summary_in_out.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/confirmation_baggage.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/confirmation_meals.dart';
import 'package:flutter/material.dart';

import 'confirmation_seats.dart';
import 'fares_and_bundles.dart';

class FareDetail extends StatelessWidget {
  final BoundBookingSummary bookingSummary;
  final bool isDeparture;

  const FareDetail(
      {Key? key, required this.bookingSummary, required this.isDeparture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaresAndBundles(isDeparture: isDeparture),
        ConfirmationSeats(isDeparture: isDeparture),
        ConfirmationMeals(isDeparture: isDeparture),
        ConfirmationBaggage(isDeparture: isDeparture),
        ConfirmationBaggage(boolIsSports: true,isDeparture: isDeparture),
        ConfirmationBaggage(isInsurance: true,isDeparture: isDeparture),
      ],
    );
  }
}
