import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/search_result/ui/choose_flight_segment.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/widgets/animations/booking_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightResultWidget extends StatelessWidget {
  const FlightResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    return BlocBuilder<SearchFlightCubit, SearchFlightState>(
      builder: (context, state) {
        return blocBuilderWrapper(
          blocState: state.blocState,
          finishedBuilder: Padding(
            padding: kPageHorizontalPadding,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        state.filterState?.beautify ?? "",
                        style: kHugeHeavy,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    kHorizontalSpacerMini,
                    BlocBuilder<BookingCubit, BookingState>(
                      builder: (context, state) {
                        return Visibility(
                          //visible: !state.isVerify,
                          child: Expanded(
                            flex: 2,
                            child: OutlinedButton(
                              child: const FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("Edit flight"),
                              ),
                              onPressed: () {

                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                kVerticalSpacerSmall,
                Text(
                  "Your starter fares include 7kg of carry-on baggage. Next, you can purchase additional baggage, select your seat of choice and meal.",
                  textAlign: TextAlign.left,
                  style: kMediumRegular.copyWith(
                    color: Styles.kSubTextColor,
                    height: 1.5,
                  ),
                ),
                BlocBuilder<BookingCubit, BookingState>(
                  builder: (context, bookState) {
                    return blocBuilderWrapper(
                      blocState: bookState.blocState,
                      finishedBuilder: buildFlights(state, bookState,),
                      initialBuilder: buildFlights(state, bookState,),
                      loadingBuilder: const BookingLoader(),
                    );
                  },
                ),
                kVerticalSpacer,
                Visibility(
                  visible: false,
                  replacement: Text(
                    "All fares are calculated based on a one-way flight for ${filter?.numberPerson.toBeautify()}. You may make changes to your booking for a nominal fee. All fares are non-refundable, for more information please read our Fare Rules.",
                    style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
                  ),
                  child: Text(
                    "Prices are based on an ${filter?.numberPerson.toBeautify()}. Fares are non-refundable, limited changes are permitted, and charges may apply. ",
                    style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Column buildFlights(SearchFlightState state, BookingState bookState) {
    return Column(
      children: [
        ChooseFlightSegment(
          title: "Departure",
          subtitle: state.filterState?.beautifyShort ?? "",
          dateTitle: AppDateUtils.formatFullDate(state.filterState?.departDate),
          segments: bookState.selectedDeparture != null
              ? [bookState.selectedDeparture!]
              : state.flights?.flightResult?.outboundSegment ?? [],
          isDeparture: true,
          visaPromo: state.isVisaPromo ?? false,
        ),
        kVerticalSpacer,
        Visibility(
          visible: state.filterState?.flightType == FlightType.round,
          child: ChooseFlightSegment(
            title: "Return",
            subtitle: state.filterState?.beautifyReverseShort ?? "",
            dateTitle:
                AppDateUtils.formatFullDate(state.filterState?.returnDate),
            segments: bookState.selectedReturn != null
                ? [bookState.selectedReturn!]
                : state.flights?.flightResult?.inboundSegment ?? [],
            isDeparture: false,
            visaPromo: state.isVisaPromo ?? false,
          ),
        ),
      ],
    );
  }
}
