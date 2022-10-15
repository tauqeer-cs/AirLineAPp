import 'package:app/models/confirmation_model.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/fare_detail_widget.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/flight_detail.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentInfo extends StatelessWidget {
  const PaymentInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final payments = context
        .watch<ConfirmationCubit>()
        .state
        .confirmationModel
        ?.value
        ?.paymentOrders;
    return AppCard(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Payment",
              style: kHugeSemiBold,
            ),
          ),
          kVerticalSpacerSmall,
          ...(payments ?? [])
              .map((f) => PaymentDetail(paymentOrder: f))
              .toList(),

        ],
      ),
    );
  }
}

class PaymentDetail extends StatelessWidget {
  final PaymentOrder paymentOrder;
  const PaymentDetail({Key? key, required this.paymentOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kVerticalSpacer,
        AppDividerWidget(color: Styles.kTextColor),
        kVerticalSpacer,
        BorderedLeftContainer(
          title: "Payment:", content: '${paymentOrder.cardOption}',
        ),
        kVerticalSpacer,
        BorderedLeftContainer(
          title: "Status:", content: paymentOrder.paymentStatusCode ?? "",
        ),
        kVerticalSpacer,
        BorderedLeftContainer(
          title: "Payment Date:", content: '${AppDateUtils.formatDateWithoutLocale(paymentOrder.paymentDate)}',
        ),
        kVerticalSpacer,
        BorderedLeftContainer(
          title: "Payment Time:", content: '${AppDateUtils.formatTimeWithoutLocale(paymentOrder.paymentDate)}',
        ),
        kVerticalSpacer,
        BorderedLeftContainer(
          title: "Amount:", content: "${paymentOrder.currencyCode} ${NumberUtils.formatNum(paymentOrder.paymentAmount)}",
        ),
      ],
    );
  }
}
