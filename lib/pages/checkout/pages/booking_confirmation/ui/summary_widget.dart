import 'package:app/app.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/flight_detail_confirmation.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/flight_segment.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flights = context
            .watch<ConfirmationCubit>()
            .state
            .confirmationModel
            ?.value
            ?.flightSegments ??
        [];

    return Column(
      children: flights
          .map((e) => Column(
                children: [
                  ...(e.outbound ?? [])
                      .map(
                        (f) => AppCard(
                          child: FlightDetailConfirmation(
                            bound: f,
                            title: "Departing flight",
                            subtitle:
                                "${f.departureAirportLocationName} to ${f.arrivalAirportLocationName}",
                            dateTitle:
                                AppDateUtils.formatFullDate(f.departureDateTime),
                            isDeparture: true,
                          ),
                        ),
                      )
                      .toList(),
                  Visibility(
                    visible: e.inbound?.isNotEmpty ?? false,
                    child: Container(
                      margin: EdgeInsets.only(top: 18),
                      child: AppCard(
                        child: Column(
                          children: [
                            ...(e.inbound ?? [])
                                .map(
                                  (f) => FlightDetailConfirmation(
                                    bound: f,
                                    title: "Returning Flight flight",
                                    subtitle:
                                        "${f.departureAirportLocationName} - ${f.arrivalAirportLocationName}",
                                    dateTitle: AppDateUtils.formatFullDate(
                                        f.departureDateTime),
                                    isDeparture: true,
                                  ),
                                )
                                .toList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}
