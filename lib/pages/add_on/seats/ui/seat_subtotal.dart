import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/utils/number_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatSubtotal extends StatelessWidget {
  final Widget child;
  final bool isDeparture;
  const SeatSubtotal({
    Key? key,
    required this.child,
    required this.isDeparture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    return Container(
      decoration: BoxDecoration(
          color: Styles.kSubTextColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -2),
              blurRadius: 6,
            ),
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Seats Subtotal",
                  style: kLargeRegular.copyWith(color: Colors.white),
                ),
                Text(
                  "MYR ${NumberUtils.formatNumber(filter?.numberPerson.getTotalSeatsPartial(isDeparture).toDouble())}",
                  style: kLargeHeavy.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}