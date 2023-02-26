import 'package:flutter/material.dart';

import '../../../blocs/booking/booking_cubit.dart';
import '../../../blocs/search_flight/search_flight_cubit.dart';
import '../../../theme/spacer.dart';
import '../../../theme/typography.dart';

class SelectChangeFlightView extends StatelessWidget {
  const SelectChangeFlightView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPageHorizontalPadding,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  'From  -> here',//  String get beautify=>"${origin?.name?.camelCase()} To ${destination?.name?.camelCase()}";
                  style: kHugeHeavy,
                  textAlign: TextAlign.left,
                ),
              ),
              kHorizontalSpacerMini,
              Visibility(
                visible: !state.isVerify,
                child: Expanded(
                  flex: 2,
                  child: OutlinedButton(
                    child:
                    const FittedBox(child: Text("Change Search")),
                    onPressed: () {

                    },
                  ),
                ),
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
                finishedBuilder: buildFlights(state, bookState),
                initialBuilder: buildFlights(state, bookState),
                loadingBuilder: const BookingLoader(),
              );
            },
          ),
          kVerticalSpacer,
          Visibility(
            visible: false,
            replacement: Text(
              "All fares are calculated based on a one-way flight for a single adult passenger. You may make changes to your booking for a nominal fee. All fares are non-refundable, for more information please read our Fare Rules.",
              style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
            ),
            child: Text(
              "Prices are based on an ${filter?.numberPerson.toBeautify()}. Fares are non-refundable, limited changes are permitted, and charges may apply. ",
              style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
            ),
          ),
        ],
      ),
    );
  }

  Column buildFlights(SearchFlightState state, BookingState bookState) {
    return Column(
      children: [
        ChooseFlightSegment(
          title: "Depart",
          subtitle: state.filterState?.beautifyShort ?? "",
          dateTitle: AppDateUtils.formatFullDate(state.filterState?.departDate),
          segments: bookState.selectedDeparture != null
              ? [bookState.selectedDeparture!]
              : state.flights?.flightResult?.outboundSegment ?? [],
          isDeparture: true,
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
          ),
        ),
      ],
    );
  }

}
