import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatRow extends StatelessWidget {
  final Seats seats;

  const SeatRow({
    Key? key,
    required this.seats,
  }) : super(key: key);

  bool isBlockChild(Person? person) {
    if (person?.peopleType == PeopleType.child ||
        person?.peopleType == PeopleType.infant) {
      if ((seats.blockChild ?? false) ||
          (seats.blockInfant ?? false) ||
          (seats.isEmergencyRow ?? false)) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final bookingState = context.watch<BookingCubit>().state;
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
    final mapColor = isDeparture
        ? bookingState.departureColorMapping
        : bookingState.returnColorMapping;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: InkWell(
        onTap: () {
          if (!(seats.isSeatAvailable ?? true)) return;
          if (isBlockChild(focusedPerson)) return;
          if (otherSelected) return;
          context
              .read<SearchFlightCubit>()
              .addSeatToPerson(selectedPerson, seats, isDeparture);
        },
        child: SizedBox(
          height: 40,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: selected
                  ? Colors.red
                  : otherSelected
                      ? Colors.grey
                      : (seats.isSeatAvailable ?? false)
                          ? (mapColor ?? {})[seats.serviceId]
                          : Colors.grey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Visibility(
              visible: selected || otherSelected,
              child: const Icon(Icons.check, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
