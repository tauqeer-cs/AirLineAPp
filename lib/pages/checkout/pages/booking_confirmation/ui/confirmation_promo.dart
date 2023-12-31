import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:easy_localization/easy_localization.dart';
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
    var currency = context
        .watch<ConfirmationCubit>()
        .state
        .confirmationModel
        ?.value
        ?.fareAndBundleDetail
        ?.currencyToShow ??
        'MYR';
    return Visibility(
      visible: pnrOrder?.voucherDiscountAmt!=null && pnrOrder!.voucherDiscountAmt! >0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
               Text(
                "promoVoucher".tr(),
                style: kHugeSemiBold,
              ),
              const Spacer(),
              MoneyWidget(
                amount: pnrOrder?.voucherDiscountAmt,
                isDense: true,
                isNegative: true,
                currency: currency,
              ),
            ],
          ),
          kVerticalSpacerSmall,
           Text('paymentView.voucher'.tr()),
          Text("${pnrOrder?.voucherCode}"),
          kVerticalSpacerSmall,
        ],
      ),
    );
  }
}
