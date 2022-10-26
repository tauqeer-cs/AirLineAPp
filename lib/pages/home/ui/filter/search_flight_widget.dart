import 'package:app/localizations/localizations_util.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/airport_widget.dart';
import 'package:app/pages/home/ui/filter/calendar_widget.dart';
import 'package:app/pages/home/ui/filter/passengers_widget.dart';
import 'package:app/pages/home/ui/filter/trip_selection.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/containers/glass_card.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_dropdown.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dropdown_transformer.dart';

class SearchFlightWidget extends StatelessWidget {
  const SearchFlightWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GreyCard(
      child: Column(
        children: [
          TripSelection(),
          AirportWidget(isOrigin: true),
          kVerticalSpacerMini,
          AirportWidget(isOrigin: false),
          kVerticalSpacerMini,
          PassengersWidget(),
          kVerticalSpacerMini,
          CalendarWidget(),
          kVerticalSpacerMini,
          // AppInputText(
          //   name: "promoFlight",
          //   onChanged: (value)=>context.read<FilterCubit>().updatePromoCode(value),
          //   hintText: "Promo Code",
          // ),
        ],
      ),
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
  String toString() {
    return message;
  }
}
