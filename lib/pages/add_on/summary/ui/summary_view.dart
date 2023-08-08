import 'package:app/pages/add_on/summary/ui/baggage_summary_detail.dart';
import 'package:app/pages/add_on/summary/ui/flight_detail.dart';
import 'package:app/pages/add_on/summary/ui/meal_summary_detail.dart';
import 'package:app/pages/add_on/summary/ui/seat_detail.dart';
import 'package:app/pages/add_on/summary/ui/special_summary_detail.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/flight_detail.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/search_flight/search_flight_cubit.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var currency = context.watch<SearchFlightCubit>().state.flights?.flightResult?.requestedCurrencyOfFareQuote ?? 'MYR';

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      children: [
        FlightSummaryDetail(isDeparture: true,currency: currency,),
        FlightSummaryDetail(isDeparture: false,currency: currency,),
        SeatSummaryDetail(currency: currency,),
        MealSummaryDetail(currency: currency,),
        BaggageSummaryDetail(currency: currency, sports: false,),
        BaggageSummaryDetail(currency: currency, sports: true,),

         SpecialSummaryDetail(currency: currency),
      ],
    );
  }
}
