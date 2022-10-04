import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatWidget extends StatelessWidget {
  final Seats seats;

  const SeatWidget({
    Key? key,
    required this.mapColor,
    required this.seats,
  }) : super(key: key);

  final Map<num?, Color>? mapColor;

  @override
  Widget build(BuildContext context) {
    final selectedPerson = context.watch<SelectedPersonCubit>().state;
    final state = context.watch<SearchFlightCubit>().state;
    final persons = state.filterState?.numberPerson;
    final focusedPerson = persons?.persons
        .firstWhereOrNull((element) => element == selectedPerson);
    final isDeparture = context.watch<IsDepartureCubit>().state;
    final otherSeats = persons?.selectedSeats(isDeparture);
    final seat = isDeparture
        ? focusedPerson?.departureSeats
        : focusedPerson?.returnSeats;
    final selected = seat == seats;
    final otherSelected = otherSeats?.contains(seats) ?? false;
    return GestureDetector(
      onTap: () {
        if(otherSelected) return;
        context
            .read<SearchFlightCubit>()
            .addSeatToPerson(selectedPerson, seats, isDeparture);
      },
      child: CircleAvatar(
        backgroundColor: selected
            ? Colors.red
            : otherSelected
                ? Colors.grey
                : (seats.isSeatAvailable ?? false)
                    ? (mapColor ?? {})[seats.serviceId]
                    : Colors.grey,
        radius: 12,
        child: Visibility(
          visible: selected || otherSelected,
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
