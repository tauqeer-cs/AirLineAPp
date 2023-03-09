import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/passenger_company_info.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/passenger_contact.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/passenger_emergency_contact.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/pessenger_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOfPassengerInfo extends StatelessWidget {

  final VoidCallback onInsuranceChanged;

  const  ListOfPassengerInfo({super.key,required this.onInsuranceChanged});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<SearchFlightCubit>();
    final state = bloc.state;
    final persons = state.filterState?.numberPerson;
    return Column(
      children: [
        if (persons != null) ...[
          for (int i = 0; i < persons.persons.length; i++) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child:  PassengerInfo(
                person: persons.persons[i],
                insuranceSelected: (bool flag, Bundle insurance) {
                  if (flag) {

                    bloc.addInsuranceToPerson(i,insurance);

                    onInsuranceChanged.call();


                  } else {

                    bloc.removeInsuranceFromPerson(i);
                    onInsuranceChanged.call();

                  }
                },
              ),
            ),
          ],
        ],

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
