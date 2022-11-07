import 'package:app/pages/home/ui/filter/airport_widget.dart';
import 'package:app/pages/home/ui/filter/calendar_widget.dart';
import 'package:app/pages/home/ui/filter/passengers_widget.dart';
import 'package:app/pages/home/ui/filter/submit_search.dart';
import 'package:app/pages/home/ui/filter/trip_selection.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:flutter/material.dart';


class SearchFlightWidget extends StatelessWidget {
  const SearchFlightWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GreyCard(
      child: Column(
        children: [
          kVerticalSpacerSmall,
          const TripSelection(),
          const AirportWidget(isOrigin: true),
          kVerticalSpacerMini,
          const AirportWidget(isOrigin: false),
          kVerticalSpacerMini,
          const PassengersWidget(),
          kVerticalSpacerMini,
          const CalendarWidget(),
          kVerticalSpacer,
          const Padding(
            padding: kPageHorizontalPadding,
            child: SubmitSearch(isHomePage: true),
          ),
          kVerticalSpacerSmall,

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
