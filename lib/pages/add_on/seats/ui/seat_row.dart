import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatRow extends StatefulWidget {
  final Seats seats;
  final VoidCallback? moveToTop;
  final VoidCallback? moveToBottom;

  const SeatRow({
    Key? key,
    required this.seats,
    this.moveToTop,
    this.moveToBottom,
  }) : super(key: key);

  @override
  State<SeatRow> createState() => _SeatRowState();
}

class _SeatRowState extends State<SeatRow> {
  bool isBlockChild(Person? person, NumberPerson? numberPerson) {
    if (person?.peopleType == PeopleType.child ||
        (person?.isWithInfant(numberPerson) ?? false)) {
      if ((widget.seats.blockChild ?? false) ||
          (widget.seats.blockInfant ?? false) ||
          (widget.seats.isEmergencyRow ?? false)) {
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
    final selected = seat == widget.seats;
    final otherSelected = otherSeats?.contains(widget.seats) ?? false;
    final mapColor = isDeparture
        ? bookingState.departureColorMapping
        : bookingState.returnColorMapping;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: InkWell(
        onTap: () async {
          if (!(widget.seats.isSeatAvailable ?? true)) return;
          if (isBlockChild(focusedPerson, persons)) return;
          if (otherSelected) return;
          var responseCheck = context
              .read<SearchFlightCubit>()
              .addSeatToPerson(selectedPerson, widget.seats, isDeparture);
          if (responseCheck) {
            var nextPerson = persons?.persons.indexOf(selectedPerson!);
            if ((nextPerson! + 1) < persons!.persons.length) {
              var nextItem = (persons.persons[nextPerson + 1]);
              if (nextItem.peopleType?.code == 'INF') {
                context
                    .read<SelectedPersonCubit>()
                    .selectPerson(persons.persons[0]);
                await Future.delayed(const Duration(milliseconds: 500));
                widget.moveToBottom?.call();
                return;
              }
              await Future.delayed(const Duration(seconds: 1));

              if (!mounted) return;
              context
                  .read<SelectedPersonCubit>()
                  .selectPerson(persons.persons[nextPerson + 1]);
              widget.moveToTop?.call();
            } else if ((nextPerson + 1) == persons.persons.length) {
              context
                  .read<SelectedPersonCubit>()
                  .selectPerson(persons.persons[0]);
              await Future.delayed(const Duration(milliseconds: 500));
              widget.moveToBottom?.call();
            }
          }
        },
        child: SizedBox(
          height: 40,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: selected
                  ? Colors.red
                  : otherSelected
                      ? Colors.grey
                      : (widget.seats.isSeatAvailable ?? false) &&
                              !isBlockChild(focusedPerson, persons)
                          ? (mapColor ?? {})[widget.seats.serviceId] ??
                  (mapColor ?? {})[0] ??
                              Colors.purpleAccent
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
