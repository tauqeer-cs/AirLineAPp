import 'dart:developer';

import 'package:app/models/confirmation_model.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/fare_detail_widget.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../booking_details/ui/fee_expanded/fee_and_taxes_detail.dart';

class FaresAndBundles extends StatelessWidget {
  final bool isDeparture;

  final String? promo;
  final num? promoAmount;


  const FaresAndBundles({Key? key, required this.isDeparture, this.promo, this.promoAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final confirmationModel =
        context.watch<ConfirmationCubit>().state.confirmationModel;
    final summary = confirmationModel?.value?.fareSummaryInOut;
    final detail = isDeparture ? summary?.outboundBookingSummary : summary?.inboundBookingSummary;

    final fares = context
        .watch<ConfirmationCubit>()
        .state
        .confirmationModel
        ?.value
        ?.fareAndBundleDetail;


    var currency = fares?.currencyToShow ?? 'MYR';

    return Column(
      children: [
        Row(
          children: [
             Text(
              "priceSection.fareBundles".tr(),
              style: k18Heavy,
            ),
            const Spacer(),
            MoneyWidget(
              amount: detail?.fareAndTax?.totalAmount,
              isDense: true,
              isNormalMYR: true,
              currency: currency,
            ),
          ],
        ),
        kVerticalSpacerMini,
         FareDetailWidget(isDeparture: isDeparture, currency: currency,),

        if((fares?.totalAmount ?? 0.0 ) > 0.0) ... [

          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "feesTaxes".tr(),
              style: kLargeHeavy,
            ),
          ),

          FeeAndTaxesDetailDetailed(
            isDeparture: isDeparture,
            padding: 0,
            hideTicket: true,
            promoAmount: promoAmount,
            promoName: promo,
          ),
          kVerticalSpacerSmall,

        ],

      ],
    );
  }
}
