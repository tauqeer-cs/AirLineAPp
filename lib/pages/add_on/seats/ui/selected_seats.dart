import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/models/number_person.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedSeats extends StatelessWidget {
  final bool isDeparture;

  const SelectedSeats({Key? key, required this.isDeparture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SearchFlightCubit>().state;
    final filter = state.filterState;
    final numberPersons = state.filterState?.numberPerson;
    final persons =
        List<Person>.from(state.filterState?.numberPerson.persons ?? []);
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
    persons.removeWhere((element) => element.peopleType == PeopleType.infant);
    return Padding(
      padding: kPageHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Selected Seats",
            style: kLargeSemiBold,
          ),
          kVerticalSpacerMini,
          Text(
            isDeparture ? "Departing Flight" : "Returning Flight",
            style: kSmallSemiBold,
          ),
          kVerticalSpacerMini,
          Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              ...(persons ?? []).map(
                (e) {
                  final seats = isDeparture ? e.departureSeats : e.returnSeats;
                  final row = (rows ?? []).firstWhereOrNull(
                      (element) => element.rowId == seats?.rowId);
                  return SizedBox(
                    width: 0.4.sw,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Styles.kPrimaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            "${numberPersons?.getPersonIndex(e)}",
                            style:
                                kMediumSemiBold.copyWith(color: Colors.white),
                          ),
                        ),
                        kHorizontalSpacerMini,
                        Flexible(
                          child: Text(
                            "${e.generateText(filter?.numberPerson)} : ${seats?.seatColumn == null ? 'No seat selected' : '${seats?.seatColumn}${row?.rowNumber}'}",
                            style: kSmallRegular.copyWith(
                                color: Styles.kSubTextColor),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ).toList(),
            ],
          ),
        ],
      ),
    );
  }
}
