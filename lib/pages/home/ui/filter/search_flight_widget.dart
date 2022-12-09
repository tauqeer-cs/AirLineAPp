import 'package:app/pages/home/ui/filter/airport_widget.dart';
import 'package:app/pages/home/ui/filter/calendar_widget.dart';
import 'package:app/pages/home/ui/filter/passengers_widget.dart';
import 'package:app/pages/home/ui/filter/submit_search.dart';
import 'package:app/pages/home/ui/filter/trip_selection.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';


class SearchFlightWidget extends StatelessWidget {
  final bool isHome;
  const SearchFlightWidget({Key? key, required this.isHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TripSelection(),
        const AirportWidget(isOrigin: true),
        kVerticalSpacerSmall,
        const AirportWidget(isOrigin: false),
        kVerticalSpacerSmall,
        const PassengersWidget(),
        kVerticalSpacerSmall,
        const CalendarWidget(),
        kVerticalSpacer,
        kVerticalSpacer,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SubmitSearch(isHomePage: isHome),
        ),

        // AppInputText(
        //   name: "promoFlight",
        //   onChanged: (value)=>context.read<FilterCubit>().updatePromoCode(value),
        //   hintText: "Promo Code",
        // ),
      ],
    );
  }
}

enum FlightType {
  round('Round Trip', true),
  oneWay('One Way', false);

  const FlightType(this.message, this.value);

  final String message;
  final bool value;

  @override
  String toString() {
    return message;
  }
}
