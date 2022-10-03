import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BundleCard extends StatelessWidget {
  final InboundBundle? inboundBundle;
  final bool isDeparture;
  const BundleCard({Key? key, required this.inboundBundle, required this.isDeparture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedPerson = context.watch<SelectedPersonCubit>().state;
    final persons = context.watch<SearchFlightCubit>().state.filterState?.numberPerson;
    final focusedPerson = persons?.persons.firstWhereOrNull((element) => element == selectedPerson);
    final bundle = isDeparture ? focusedPerson?.departureBundle : focusedPerson?.returnBundle;
    final isSelected = inboundBundle == bundle;
    return Container();
  }
}
