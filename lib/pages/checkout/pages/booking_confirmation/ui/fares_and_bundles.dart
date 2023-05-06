import 'dart:developer';

import 'package:app/models/confirmation_model.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/fare_detail_widget.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaresAndBundles extends StatelessWidget {
  final bool isDeparture;

  const FaresAndBundles({Key? key, required this.isDeparture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final confirmationModel =
        context.watch<ConfirmationCubit>().state.confirmationModel;
    final summary = confirmationModel?.value?.fareSummaryInOut;
    final detail = isDeparture ? summary?.outboundBookingSummary : summary?.inboundBookingSummary;
    return Column(
      children: [
        Row(
          children: [
             Text(
              "feesTaxes".tr(),
              style: k18Heavy,
            ),
            const Spacer(),
            MoneyWidget(
              amount: detail?.fareAndTax?.totalAmount,
              isDense: true,
              isNormalMYR: true,
            ),
          ],
        ),
        kVerticalSpacerMini,
        const FareDetailWidget(),
        kVerticalSpacerSmall,
      ],
    );
  }
}
