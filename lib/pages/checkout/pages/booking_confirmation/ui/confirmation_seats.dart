import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationSeats extends StatelessWidget {
  const ConfirmationSeats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final seats = context
        .watch<ConfirmationCubit>()
        .state
        .confirmationModel
        ?.value
        ?.seatDetail;
    return Column(
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
              amount: seats?.totalAmount,
              isDense: true,
            ),
          ],
        ),
        kVerticalSpacerSmall,
        ...(seats?.seats ?? [])
            .map((e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${e.title} ${e.givenName} ${e.surName}"),
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
