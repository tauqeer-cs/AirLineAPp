import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/price_row.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class SeatsFeeDetailPayment extends StatelessWidget {
  final bool isDeparture;

  const SeatsFeeDetailPayment({Key? key, required this.isDeparture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final bookingState = context.watch<BookingCubit>().state;
    final flightSeats = bookingState.verifyResponse?.flightSeat;
    final inboundSeats =
        isDeparture ? flightSeats?.outbound : flightSeats?.inbound;
    final pnrRequest = bookingState.summaryRequest?.flightSummaryPNRRequest;
    final passengers = pnrRequest?.passengers ?? [];
    final rows = inboundSeats
        ?.firstOrNull
        ?.retrieveFlightSeatMapResponse
        ?.physicalFlights
        ?.firstOrNull
        ?.physicalFlightSeatMap
        ?.seatConfiguration
        ?.rows;
    final persons = filter?.numberPerson.persons ?? [];
    return Column(
      children: [
        kVerticalSpacerSmall,
        ...persons.map(
          (e) {
            final passengersTypes = passengers
                .where((element) => element.paxType == e.peopleType?.code)
                .toList();
            if (passengersTypes.isEmpty || e.numberOrder == null) {
              return const SizedBox();
            }
            final passenger = passengersTypes.length > (e.numberOrder!.toInt())
                ? passengersTypes[e.numberOrder!.toInt()]
                : passengersTypes[0];
            final seats = isDeparture ? e.departureSeats : e.returnSeats;
            final row = (rows ?? [])
                .firstWhereOrNull((element) => element.rowId == seats?.rowId);
            return seats == null
                ? const SizedBox.shrink()
                : PriceRow(
                    child1: Text(
                      "${passenger.title} ${passenger.firstName},\n${seats.seatColumn == null ? 'No seat selected' : '${seats.seatColumn}${row?.rowNumber}'}",
                      style: kMediumRegular,
                    ),
                    child2: MoneyWidgetSmall(
                      amount: seats.seatPriceOffers?.firstOrNull?.amount,
                      isDense: true,
                      currency: seats.seatPriceOffers?.firstOrNull?.currency,
                    ),
                  );
          },
        ).toList(),
      ],
    );
  }
}
