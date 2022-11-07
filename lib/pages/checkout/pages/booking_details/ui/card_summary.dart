import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/flight_segment.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/widgets/animations/booking_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CardSummary extends StatelessWidget {
  final bool showFees;

  const CardSummary({Key? key, required this.showFees}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SearchFlightCubit>().state;
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, bookState) {
        return blocBuilderWrapper(
          blocState: bookState.blocState,
          finishedBuilder: buildFlights(state, bookState),
          initialBuilder: buildFlights(state, bookState),
          loadingBuilder: const BookingLoader(),
        );
      },
    );
  }

  Column buildFlights(SearchFlightState state, BookingState bookState) {
    return Column(
      children: [
        FlightSegment(
          title: "DEP",
          subtitle: state.filterState?.beautifyShort ?? "",
          dateTitle: AppDateUtils.formatFullDate(state.filterState?.departDate),
          segments: bookState.isVerify
              ? [bookState.selectedDeparture!]
              : state.flights?.flightResult?.outboundSegment ?? [],
          isDeparture: true,
          showFees: showFees,
        ),
        Visibility(
          visible: state.filterState?.flightType == FlightType.round,
          child: FlightSegment(
            title: "RET",
            subtitle: state.filterState?.beautifyReverseShort ?? "",
            dateTitle:
                AppDateUtils.formatFullDate(state.filterState?.returnDate),
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
