import 'package:app/pages/add_on/summary/ui/baggage_summary_detail.dart';
import 'package:app/pages/add_on/summary/ui/flight_detail.dart';
import 'package:app/pages/add_on/summary/ui/meal_summary_detail.dart';
import 'package:app/pages/add_on/summary/ui/seat_detail.dart';
import 'package:app/pages/add_on/summary/ui/special_summary_detail.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/flight_detail.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:flutter/material.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      children: [
        FlightSummaryDetail(isDeparture: true),
        FlightSummaryDetail(isDeparture: false),
        SeatSummaryDetail(),
        MealSummaryDetail(),
        BaggageSummaryDetail(),
        SpecialSummaryDetail(),
      ],
    );
  }
}
