import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatRemove extends StatelessWidget {
  const SeatRemove({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedPerson = context.watch<SelectedPersonCubit>().state;
    final state = context.watch<SearchFlightCubit>().state;
    final persons = state.filterState?.numberPerson;
    final focusedPerson = persons?.persons
        .firstWhereOrNull((element) => element == selectedPerson);
    final isDeparture = context.watch<IsDepartureCubit>().state;
    final seat = isDeparture
        ? focusedPerson?.departureSeats
        : focusedPerson?.returnSeats;
    return InkWell(
      onTap: () async {

        var check = context
            .read<SearchFlightCubit>()
            .addSeatToPerson(selectedPerson, null, isDeparture);

        if(check) {

          var nextPerson = persons?.persons.indexOf(selectedPerson!);


          print('');

          //          context.read<SelectedPersonCubit>().selectPerson(val);
        }
      },
      child: CheckboxListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        controlAffinity: ListTileControlAffinity.leading,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [

            Text("Pick my seats for me", style: kLargeSemiBold),
            Text("Let the system allocate a seat for you.", style: kLargeMedium),
          ],
        ),
        value: seat == null,
        onChanged: (value) {
          context
              .read<SearchFlightCubit>()
              .addSeatToPerson(selectedPerson, null, isDeparture);


        },
      ),
    );
  }
}
