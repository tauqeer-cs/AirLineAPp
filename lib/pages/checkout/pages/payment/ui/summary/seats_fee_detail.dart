import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/pages/checkout/ui/fee_and_taxes_detail.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class SeatsFeeDetailPayment extends StatelessWidget {
  final bool isDeparture;

  const SeatsFeeDetailPayment({Key? key, required this.isDeparture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final bookingState = context.watch<BookingCubit>().state;
    final flightSeats = bookingState.verifyResponse?.flightSeat;
    final inboundSeats =
        isDeparture ? flightSeats?.outbound : flightSeats?.inbound;
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
        AppDividerWidget(color: Styles.kDisabledButton),
        ...persons.map(
          (e) {
            final seats = isDeparture ? e.departureSeats : e.returnSeats;
            final row = (rows ?? [])
                .firstWhereOrNull((element) => element.rowId == seats?.rowId);
            return seats == null
                ? SizedBox.shrink()
                : PriceContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${e.toString()} : ${seats.serviceDescription ?? 'No seat selected'} - ${seats.seatColumn}${row?.rowNumber}",
                          style: kSmallRegular.copyWith(
                              color: Styles.kSubTextColor),
                        ),
                        MoneyWidgetSmall(
                          amount: seats.seatPriceOffers?.firstOrNull?.amount,
                          isDense: true,
                          currency:
                              seats.seatPriceOffers?.firstOrNull?.currency,
                        ),
                      ],
                    ),
                  );
          },
        ).toList(),
      ],
    );
  }
}
