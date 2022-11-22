import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/pages/add_on/ui/passenger_selector.dart';
import 'package:app/pages/add_on/seats/ui/seat_legend.dart';
import 'package:app/pages/add_on/seats/ui/seat_plan.dart';
import 'package:app/pages/add_on/seats/ui/seat_remove.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatsSection extends StatelessWidget {
  final bool isDeparture;
  const SeatsSection({Key? key, this.isDeparture = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IsDepartureCubit()..changeDeparture(isDeparture),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: kPageHorizontalPadding,
            child: Text(
              "Seats",
              style: kHugeSemiBold.copyWith(
                color: Styles.kOrangeColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          kVerticalSpacer,
          const Padding(
            padding: kPageHorizontalPadding,
            child: PassengerSelector(),
          ),
          kVerticalSpacerSmall,
          const Padding(
            padding: kPageHorizontalPaddingBig,
            child: SeatsLegend(),
          ),
          kVerticalSpacer,
          const SeatPlan(),
          kVerticalSpacer,
          const SeatRemove(),
        ],
      ),
    );
  }
}
