import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/pages/checkout/pages/select_meals/ui/meal_card.dart';
import 'package:app/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailableMeals extends StatelessWidget {
  const AvailableMeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingState = context.watch<BookingCubit>().state;
    final mealGroup = bookingState.verifyResponse?.flightSSR?.mealGroup;
    final isDeparture = context.watch<IsDepartureCubit>().state;

    final meals = isDeparture ? mealGroup?.outbound : mealGroup?.outbound;
    return Column(
      children: (meals ?? []).map((e) => MealCard(meal: e)).toList(),
    );
  }
}
