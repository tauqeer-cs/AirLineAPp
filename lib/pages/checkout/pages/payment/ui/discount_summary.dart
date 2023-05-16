import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/blocs/voucher/voucher_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class DiscountSummary extends StatelessWidget {

   final double princToShow;

  const DiscountSummary({Key? key, required this.princToShow}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final booking = context.watch<BookingCubit>().state;
    final filterState = context.watch<SearchFlightCubit>().state.filterState;
    final voucherState = context.watch<VoucherCubit>().state;
    final discount = voucherState.response?.addVoucherResult?.voucherDiscounts?.firstOrNull?.discountAmount ?? 0;
    int? redeemAmount = context.watch<VoucherCubit>().state.selectedRedeemOption?.redemptionAmount;
    final currency = context.watch<SearchFlightCubit>().state.flights?.flightResult?.requestedCurrencyOfFareQuote ?? 'MYR';

    if(redeemAmount == 0) {
      redeemAmount = null;
    }
    return Visibility(
      visible: discount!=0 || redeemAmount != null,

      child: Transform.translate(
        offset: const Offset(0,20),
        child: Container(
          color: Styles.kDividerColor,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 10,bottom: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text("subtotal".tr(), style: kMediumRegular.copyWith(color: Styles.kSubTextColor),),
                  const Spacer(),
                  MoneyWidgetSmall(
                    isDense: false,
                    amount: princToShow,
                  ),
                ],
              ),
              kVerticalSpacerSmall,
              if(discount!=0) ... [
                Row(
                  children: [
                    Text("paymentView.voucher".tr(), style: kMediumRegular.copyWith(color: Styles.kSubTextColor),),
                    const Spacer(),
                    MoneyWidgetSmall(
                      currency: currency,
                      isDense: false,
                      amount: discount,
                      isNegative: true,
                    ),
                  ],
                ),
                kVerticalSpacerSmall,
              ],
              if(redeemAmount != null) ... [
                Row(
                  children: [
                    Text("paymentView.myreward".tr(), style: kMediumRegular.copyWith(color: Styles.kSubTextColor),),
                    const Spacer(),
                    MoneyWidgetSmall(
                      isDense: false,
                      currency: currency,
                      amount: redeemAmount,
                      isNegative: true,
                    ),
                  ],
                ),
                kVerticalSpacerSmall,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
