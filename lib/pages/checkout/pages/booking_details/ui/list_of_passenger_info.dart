import 'package:app/blocs/local_user/local_user_bloc.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/models/country.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/booking_details_view.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/passenger_company_info.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/passenger_contact.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/passenger_emergency_contact.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/pessenger_info.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../theme/theme.dart';

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


