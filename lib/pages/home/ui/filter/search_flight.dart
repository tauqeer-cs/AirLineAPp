import 'package:app/localizations/localizations_util.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/airport_widget.dart';
import 'package:app/pages/home/ui/filter/calendar_widget.dart';
import 'package:app/pages/home/ui/filter/passengers_widget.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/forms/app_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dropdown_transformer.dart';

class SearchFlight extends StatelessWidget {
  const SearchFlight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppDropDown<FlightType>(
          items: const [FlightType.round, FlightType.oneWay],
          defaultValue: FlightType.round,
          onChanged: (val) {
            context.read<FilterCubit>().updateTripType(val);
          },
          sheetTitle: "Trip Type",
          isEnabled: true,
          valueTransformer: (value){
            return DropdownTransformerWidget<FlightType>(
              value: value ?? FlightType.round,
              label: "Trip Type",
            );
          },
        ),
        kVerticalSpacer,
        PassengersWidget(),
        kVerticalSpacer,
        AirportWidget(isOrigin: true),
        kVerticalSpacer,
        AirportWidget(isOrigin: false),
        kVerticalSpacer,
        CalendarWidget(),
      ],
    );
  }
}

enum FlightType {
  round('Round', true),
  oneWay('One Way', false);

  const FlightType(this.message, this.value);
  final String message;
  final bool value;

  @override
  String toString(){
    return message;
  }
}
