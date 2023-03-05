import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PleaseSelectPlace extends StatelessWidget {
  const PleaseSelectPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterCubit = context.watch<FilterCubit>();
    final isRoundTrip = filterCubit.state.flightType == FlightType.round;
    return SizedBox(
      height: 350,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AppCardCalendar(
              child: Row(
                children: [
                  const Expanded(
                    child: Center(
                      child: AutoSizeText(
                        "Departure Date",
                        style: kMediumSemiBold,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isRoundTrip,
                    child: const Icon(Icons.chevron_right),
                  ),
                  Visibility(
                    visible: isRoundTrip,
                    child: const Expanded(
                      child: Center(
                        child: AutoSizeText(
                            maxLines: 1,
                            "RreturnDate",
                            style: kMediumSemiBold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            kVerticalSpacerSmall,
            const AppDividerWidget(),
            kVerticalSpacerSmall,
            const Text("Please select the departure airport and destination airport first."),
            kVerticalSpacerSmall,
            const AppDividerWidget(),
          ],
        ),
      ),
    );
  }
}
