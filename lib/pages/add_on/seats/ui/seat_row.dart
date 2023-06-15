import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/add_on/seats/ui/seat_legend_simple.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/theme.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/manage_booking/manage_booking_cubit.dart';

class SeatRow extends StatefulWidget {
  final Seats seats;
  final VoidCallback? moveToTop;
  final VoidCallback? moveToBottom;
  final bool isManageBooking;

  const SeatRow({
    Key? key,
    required this.seats,
    this.moveToTop,
    this.moveToBottom,
    required this.isManageBooking,
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
    Person? selectedPerson;

    int indexToShow = 0;
    ManageBookingCubit? manageCubit;

    if (widget.isManageBooking) {
      manageCubit = context.watch<ManageBookingCubit>();

      var state = context.watch<ManageBookingCubit>().state;
      selectedPerson = state.selectedPax?.personObject;
      print('');
    } else {
      selectedPerson = context.watch<SelectedPersonCubit>().state;
    }
    NumberPerson? persons;
    Person? focusedPerson;
    List<Seats?>? otherSeats;

    bool isDeparture = true;

    Map<num?, Color>? mapColor;

    if (widget.isManageBooking) {
      var no = context
              .watch<ManageBookingCubit>()
              .state
              .manageBookingResponse
              ?.result
              ?.allPersonObject ??
          [];

      persons = NumberPerson(persons: no);

      focusedPerson =
          context.watch<ManageBookingCubit>().state.selectedPax?.personObject;
      isDeparture = true;

      otherSeats = persons.selectedSeats(isDeparture);

      mapColor = isDeparture
          ? context.watch<ManageBookingCubit>().state.departureColorMapping
          : context.watch<ManageBookingCubit>().state.returnColorMapping;
    } else {
      final state = context.watch<SearchFlightCubit>().state;
      persons = state.filterState?.numberPerson;
      focusedPerson = persons?.persons
          .firstWhereOrNull((element) => element == selectedPerson);
      isDeparture = context.watch<IsDepartureCubit>().state;
      otherSeats = persons?.selectedSeats(isDeparture);
      mapColor = isDeparture
          ? bookingState.departureColorMapping
          : bookingState.returnColorMapping;
    }

    final seat = isDeparture
        ? focusedPerson?.departureSeats
        : focusedPerson?.returnSeats;
    final selected = seat == widget.seats;
    final otherSelected = otherSeats?.contains(widget.seats) ?? false;

    if (seat != null) {
      print('');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: InkWell(
        onTap: () async {
          if (!(widget.seats.isSeatAvailable ?? true)) return;
          if (isBlockChild(focusedPerson, persons)) return;
          if(widget.isManageBooking) {
            //if(selected){

              manageCubit?.addSeatToPerson(selectedPerson, widget.seats, isDeparture);
           // }
            return;

          }
          if (selected) {
            print("is selected $selected");
            context
                .read<SearchFlightCubit>()
                .addSeatToPerson(selectedPerson, null, isDeparture);
          }
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
                print("go to bottom");
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
              color: (widget.seats.isSeatAvailable ?? false) &&
                      !isBlockChild(focusedPerson, persons)
                  ? widget.seats.toColor
                  : SeatAvailableLegend.unavailable.color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Visibility(
              visible: selected || otherSelected,
              child: Container(
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Styles.kPrimaryColor),
                child: Center(
                  child: (widget.isManageBooking)
                      ? (selected
                          ? buildPersonTextFocused(focusedPerson, manageCubit)
                          : seatTextPerson(
                              widget.seats.seatId?.toInt() ?? 0, manageCubit))
                      : Text(
                          selected
                              ? "${persons?.getPersonIndex(focusedPerson)}"
                              : "${persons?.getPersonIndexBySeat(widget.seats, isDeparture)}",
                          style: kLargeHeavy.copyWith(color: Colors.white),
                        ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text buildPersonTextFocused(Person? focusedPerson, ManageBookingCubit? bloc) {
    var respone = bloc?.state.manageBookingResponse?.result?.passengersWithSSR
        ?.where((e) => e.personObject == focusedPerson)
        .toList();

    if ((respone ?? []).isNotEmpty) {
      int? index = bloc?.state.manageBookingResponse?.result?.passengersWithSSR
          ?.indexOf((respone ?? []).first);

      if (index != null) {
        return Text((index + 1).toString(),style: kLargeHeavy.copyWith(color: Colors.white),);
      }
    }
    return Text('0');
  }

  Text seatTextPerson(int seatId, ManageBookingCubit? bloc) {
    var respone = bloc?.state.manageBookingResponse?.result?.passengersWithSSR
        ?.where((e) => e.personObject?.departureSeats?.seatId == seatId)
        .toList();
    if ((respone ?? []).isNotEmpty) {
      int? index = bloc?.state.manageBookingResponse?.result?.passengersWithSSR
          ?.indexOf((respone ?? []).first);

      if (index != null) {
        return Text(
          (index + 1).toString(),
          style: kLargeHeavy.copyWith(color: Colors.white),
        );
      }
    }

    return Text('2');
  }
}
