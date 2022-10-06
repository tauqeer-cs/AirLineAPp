import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/pages/checkout/pages/select_baggage/ui/baggage_card.dart';
import 'package:app/pages/checkout/pages/select_meals/ui/meal_card.dart';
import 'package:app/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailableBaggage extends StatelessWidget {
  const AvailableBaggage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingState = context.watch<BookingCubit>().state;
    final baggageGroup = bookingState.verifyResponse?.flightSSR?.baggageGroup;
    final isDeparture = context.watch<IsDepartureCubit>().state;
    final baggage = isDeparture ? baggageGroup?.outbound : baggageGroup?.inbound;
    return Column(
      children: (baggage ?? []).map((e) => BaggageCard(selectedBundle: e)).toList(),
    );
  }
}
