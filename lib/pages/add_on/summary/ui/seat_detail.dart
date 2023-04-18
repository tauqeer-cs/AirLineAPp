import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/add_on/summary/ui/flight_detail.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/theme.dart';
import '../../ui/summary_list_item.dart';

class SeatSummaryDetail extends StatelessWidget {
  const SeatSummaryDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final bookingTotal = context.watch<BookingCubit>().state;
    final numberOfPerson = filter?.numberPerson;
    final persons = List<Person>.from(numberOfPerson?.persons ?? []);
    final totalPrice = ((filter?.numberPerson.getTotalSeatsPartial(true) ?? 0) +
        (filter?.numberPerson.getTotalSeatsPartial(false) ?? 0));
    persons.removeWhere((element) => element.peopleType == PeopleType.infant);
    final flightSeats = bookingTotal.verifyResponse?.flightSeat;
    final rowsDeparture = flightSeats
        ?.outbound
        ?.firstOrNull
        ?.retrieveFlightSeatMapResponse
        ?.physicalFlights
        ?.firstOrNull
        ?.physicalFlightSeatMap
        ?.seatConfiguration
        ?.rows;
    final rowsReturn = flightSeats
        ?.inbound
        ?.firstOrNull
        ?.retrieveFlightSeatMapResponse
        ?.physicalFlights
        ?.firstOrNull
        ?.physicalFlightSeatMap
        ?.seatConfiguration
        ?.rows;
    return Visibility(
      visible: totalPrice > 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChildRow(
            child1: const Text(
              "Seat",
              style: kLargeHeavy,
            ),
            child2: MoneyWidgetCustom(
              amountSize: 16,
              myrSize: 16,
              amount: totalPrice,
              textColor: Styles.kPrimaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          kVerticalSpacerSmall,
          const Text(
            "Depart",
            style: kMediumSemiBold,
          ),
          kVerticalSpacerMini,
          ...persons.map(
            (e) {
              final seats = e.departureSeats;
              final row = (rowsDeparture ?? [])
                  .firstWhereOrNull((element) => element.rowId == seats?.rowId);
              return Visibility(
                visible: e.getPartialPriceSeatPartial(true) > 0,
                child: ChildRow(
                  child1: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.generateText(numberOfPerson, separator: "& "),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Text(
                          "- ${seats?.seatColumn == null ? 'No seat selected' : '${seats?.seatColumn}${row?.rowNumber}'}",
                          style:
                              kMediumRegular.copyWith(color: Styles.kActiveGrey),
                        ),
                      ),
                    ],
                  ),
                  child2: MoneyWidgetCustom(
                    amount: e.getPartialPriceSeatPartial(true),
                  ),
                ),
              );
            },
          ).toList(),
          kVerticalSpacerSmall,
          Visibility(
            visible: filter?.flightType == FlightType.round,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Return",
                  style: kMediumSemiBold,
                ),
                kVerticalSpacerMini,
                ...persons.map(
                  (e) {
                    final seats = e.returnSeats;
                    final row = (rowsReturn ?? [])
                        .firstWhereOrNull((element) => element.rowId == seats?.rowId);
                    return Visibility(
                      visible: e.getPartialPriceSeatPartial(false) > 0,
                      child: ChildRow(
                        child1: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.generateText(numberOfPerson, separator: "& "),
                            ),
                            SummaryListItem(text: seats?.seatColumn == null ? 'No seat selected' : '${seats?.seatColumn}${row?.rowNumber}',),

                          ],
                        ),
                        child2: MoneyWidgetCustom(
                          amount: e.getPartialPriceSeatPartial(false),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ],
            ),
          ),
          kVerticalSpacer,
          AppDividerWidget(),
          kVerticalSpacer,
        ],
      ),
    );
  }
}
