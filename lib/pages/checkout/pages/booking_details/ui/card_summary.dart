import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/flight_segment.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/widgets/animations/booking_loader.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardSummary extends StatelessWidget {
  final bool showFees;

  const CardSummary({Key? key, required this.showFees}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.toString();
    var currency = context.watch<SearchFlightCubit>().state.flights?.flightResult?.requestedCurrencyOfFareQuote ?? 'MYR';

    final state = context.watch<SearchFlightCubit>().state;
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, bookState) {
        return blocBuilderWrapper(
          blocState: bookState.blocState,
          finishedBuilder: buildFlights(state, bookState,locale,currency),
          initialBuilder: buildFlights(state, bookState,locale,currency),
          loadingBuilder: const BookingLoader(),
        );
      },
    );
  }

  Column buildFlights(SearchFlightState state, BookingState bookState,String local,String? currency) {
    return Column(
      children: [
        FlightSegment(
          currency: currency,
          title: "departure".tr(),
          subtitle: state.filterState?.beautifyShort ?? "",
          dateTitle: AppDateUtils.formatHalfDate(state.filterState?.departDate,locale: local),
          segments: bookState.isVerify
              ? [bookState.selectedDeparture!]
              : state.flights?.flightResult?.outboundSegment ?? [],
          isDeparture: true,
          showFees: showFees,
        ),
        Visibility(
          visible: state.filterState?.flightType == FlightType.round,
          child: FlightSegment(
            currency: currency,
            title: "return".tr(),
            subtitle: state.filterState?.beautifyReverseShort ?? "",
            dateTitle:
                AppDateUtils.formatHalfDate(state.filterState?.returnDate,locale: local),
            segments: bookState.isVerify
                ? bookState.selectedReturn != null
                    ? [bookState.selectedReturn!]
                    : []
                : state.flights?.flightResult?.inboundSegment ?? [],
            isDeparture: false,
            showFees: showFees,
          ),
        ),
      ],
    );
  }
}
