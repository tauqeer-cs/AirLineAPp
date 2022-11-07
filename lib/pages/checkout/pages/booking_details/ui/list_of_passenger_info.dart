import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/passenger_company_info.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/passenger_contact.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/passenger_emergency_contact.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/pessenger_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ListOfPassengerInfo extends StatelessWidget {
  const ListOfPassengerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SearchFlightCubit>().state;
    final persons = state.filterState?.numberPerson;
    return Column(
      children: [
        ...(persons?.persons ?? [])
            .map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: PassengerInfo(person: e),
                ))
            .toList(),
        Column(
          children: const [
            PassengerContact(),
            PassengerEmergencyContact(),
            PassengerCompanyInfo(),
          ],
        ),
      ],
    );
  }
}


