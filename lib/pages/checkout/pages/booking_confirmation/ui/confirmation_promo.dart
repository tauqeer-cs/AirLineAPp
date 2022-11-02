import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/fare_detail_widget.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationPromo extends StatelessWidget {
  const ConfirmationPromo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pnrOrder = context
        .watch<ConfirmationCubit>()
        .state
        .confirmationModel
        ?.value
        ?.superPNROrder;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Promo/Voucher",
              style: kHugeSemiBold,
            ),
            Spacer(),
            MoneyWidget(
              amount: pnrOrder?.voucherDiscountAmt,
              isDense: true,
              isNegative: true,
            ),
          ],
        ),
        kVerticalSpacerSmall,
        Text("Voucher"),
        Text("${pnrOrder?.voucherCode}"),
        kVerticalSpacerSmall,
      ],
    );
  }
}