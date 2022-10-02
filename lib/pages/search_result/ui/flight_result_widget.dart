import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/search_result/ui/choose_flight_segment.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightResultWidget extends StatelessWidget {
  const FlightResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchFlightCubit, SearchFlightState>(
      builder: (context, state) {
        return blocBuilderWrapper(
          blocState: state.blocState,
          finishedBuilder: Padding(
            padding: kPageHorizontalPadding,
            child: Column(
              children: [
                Text(
                  "Your trip starts here",
                  style: kHugeSemiBold.copyWith(color: Styles.kPrimaryColor),
                ),
                kVerticalSpacer,
                Text(
                  state.filterState?.beautify ?? "",
                  style: kMediumSemiBold.copyWith(
                      color: Styles.kPrimaryColor, letterSpacing: 1),
                  textAlign: TextAlign.center,
                ),
                kVerticalSpacer,
                Text(
                  " Your starter fares include 7kg of carry-on baggage. Next, you can purchase additional baggage weight and select your choice of seat. ",
                  textAlign: TextAlign.center,
                ),
                kVerticalSpacer,
                ChooseFlightSegment(
                  title: "Departing flight",
                  subtitle: state.filterState?.beautify ?? "",
                  dateTitle: AppDateUtils.formatFullDate(state.filterState?.departDate),
                  segments: state.flights?.flightResult?.outboundSegment ?? [],
                  isDeparture: true,
                ),
                kVerticalSpacer,
                Visibility(
                  visible: state.filterState?.flightType == FlightType.round,
                  child: ChooseFlightSegment(
                    title: "Returning flight",
                    subtitle: state.filterState?.beautifyReverse ?? "",
                    dateTitle: AppDateUtils.formatFullDate(state.filterState?.returnDate),
                    segments: state.flights?.flightResult?.inboundSegment ?? [],
                    isDeparture: false,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
