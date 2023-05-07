import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:easy_localization/easy_localization.dart';
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
    final amount = isDeparture
        ? seats?.totalDeparture()
        : seats?.totalReturn();
    var currency = context
        .watch<ConfirmationCubit>()
        .state
        .confirmationModel
        ?.value
        ?.fareAndBundleDetail
        ?.currencyToShow ??
        'MYR';


    return (seats?.seats ?? []).isEmpty || amount==0
        ? Container()
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "priceSection.seats".tr(),
              style: kHugeSemiBold,
            ),
            const Spacer(),
            MoneyWidget(
              amount: amount,
              isDense: true,
              isNormalMYR: true,
              currency: currency,
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
