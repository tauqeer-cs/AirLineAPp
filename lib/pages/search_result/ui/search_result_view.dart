import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/home/ui/filter/submit_search.dart';
import 'package:app/pages/search_result/ui/flight_result_widget.dart';
import 'package:app/theme/spacer.dart';
import 'package:flutter/material.dart';

class SearchResultView extends StatelessWidget {
  const SearchResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        kVerticalSpacer,
        Padding(
          padding: kPageHorizontalPadding,
          child: SearchFlightWidget(),
        ),
        kVerticalSpacer,
        Padding(
          padding: kPageHorizontalPadding,
          child: SubmitSearch(isHomePage: false),
        ),
        kVerticalSpacerBig,
        FlightResultWidget(),
      ],
    );
  }
}
