import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationSeats extends StatelessWidget {
  final bool isDeparture;

  const ConfirmationSeats({Key? key, required this.isDeparture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final seats = context
        .watch<ConfirmationCubit>()
        .state
        .confirmationModel
        ?.value
        ?.seatDetail;
    return (seats?.seats ?? []).isEmpty
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Seats",
                    style: kHugeSemiBold,
                  ),
                  const Spacer(),
                  MoneyWidget(
                    amount: isDeparture
                        ? seats?.totalDeparture()
                        : seats?.totalReturn(),
                    isDense: true,
                    isNormalMYR: true,
                  ),
                ],
              ),
              kVerticalSpacerSmall,
              ...(isDeparture ? seats!.departureSeat : seats!.returnSeat)
                  .map((e) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${e.titleToShow} ${e.givenName} ${e.surName}"),
                          Text("${e.seatPosition}"),
                          kVerticalSpacerSmall,
                        ],
                      ))
                  .toList(),
              kVerticalSpacerSmall,
            ],
          );
  }
}
