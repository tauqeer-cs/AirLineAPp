import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/flight_detail_confirmation.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:easy_localization/easy_localization.dart';
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
                            title: "departFlight".tr(),
                            subtitle:
                                "${f.departureAirportLocationName} to ${f.arrivalAirportLocationName}",
                            dateTitle: AppDateUtils.formatFullDate(
                                f.departureDateTime),
                            isDeparture: true,
                          ),
                        ),
                      )
                      .toList(),
                  Visibility(
                    visible: e.inbound?.isNotEmpty ?? false,
                    child: Container(
                      margin: const EdgeInsets.only(top: 18),
                      child: AppCard(
                        child: Column(
                          children: [
                            ...(e.inbound ?? [])
                                .map(
                                  (f) => FlightDetailConfirmation(
                                    bound: f,
                                    title: "returningFlight".tr(),
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
