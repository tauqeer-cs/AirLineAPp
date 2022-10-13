import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/pages/checkout/pages/select_meals/ui/meal_card.dart';
import 'package:app/pages/checkout/pages/select_seats/ui/seats_legend.dart';
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
    final  bundleNotice= context.watch<CmsSsrCubit>().state.bundleNotice;

    final meals = isDeparture ? mealGroup?.outbound : mealGroup?.inbound;
    print("meals length $isDeparture ${meals?.length}");
    return Column(
      children: [
        ContainerNotice(sharedNotice: bundleNotice),
        ...(meals ?? []).map((e) => MealCard(meal: e)).toList()
      ],
    );
  }
}
