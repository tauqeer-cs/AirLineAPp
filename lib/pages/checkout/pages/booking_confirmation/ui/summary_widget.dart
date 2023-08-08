import 'package:app/models/fare_summary_in_out.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/flight_detail_confirmation.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.toString();
    final confirmationModel =
        context.watch<ConfirmationCubit>().state.confirmationModel?.value;
    final flights = confirmationModel?.flightSegments ?? [];
    final bookingInOut = confirmationModel?.fareSummaryInOut;
    return Column(
      children: flights
          .map((e) => Column(
        children: [
          ...(e.outbound ?? [])
              .map(
                (f) => AppCard(
              edgeInsets: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: 12),
              child: FlightDetailConfirmation(
                bound: f,
                bookingSummary:
                bookingInOut?.outboundBookingSummary ??
                    BoundBookingSummary(),
                title: "departFlight".tr(),
                subtitle:
                "${f.departureAirportLocationName} ${'to'.tr()} ${f.arrivalAirportLocationName}",
                dateTitle: AppDateUtils.formatHalfDate(
                    f.departureDateTime,locale: locale),
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
                edgeInsets:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                child: Column(
                  children: [
                    ...(e.inbound ?? [])
                        .map(
                          (f) => FlightDetailConfirmation(
                        bookingSummary:
                        bookingInOut?.inboundBookingSummary ??
                            BoundBookingSummary(),
                        bound: f,
                        title: "returningFlight".tr(),
                        subtitle:
                        "${f.departureAirportLocationName} - ${f.arrivalAirportLocationName}",
                        dateTitle: AppDateUtils.formatHalfDate(
                            f.departureDateTime,locale: locale),
                        isDeparture: false,
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
