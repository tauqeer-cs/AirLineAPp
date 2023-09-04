import 'package:app/models/fare_summary_in_out.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/confirmation_baggage.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/confirmation_meals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../blocs/booking/booking_cubit.dart';
import '../../../../../blocs/search_flight/search_flight_cubit.dart';
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

    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final bookingTotal = context.watch<BookingCubit>().state;

    num? promoAmount = bookingTotal.selectedDeparture?.fareTypeWithTaxDetails?.first.fareInfoWithTaxDetails?.first.promotionAmount;

    String? promoName;

    if(isDeparture == false){

      promoAmount = bookingTotal.selectedReturn?.fareTypeWithTaxDetails?.first.fareInfoWithTaxDetails?.first.promotionAmount;
    }

    if((promoAmount ?? 0.0) > 0){
      promoName = filter?.promoCode;
    }



    return Column(
      children: [
        FaresAndBundles(isDeparture: isDeparture,promoAmount: promoAmount,promo: promoName,),
        ConfirmationSeats(isDeparture: isDeparture),
        ConfirmationMeals(isDeparture: isDeparture),
        ConfirmationBaggage(isDeparture: isDeparture),
        ConfirmationBaggage(boolIsSports: true,isDeparture: isDeparture),
        ConfirmationBaggage(isInsurance: true,isDeparture: isDeparture),
      ],
    );
  }
}
