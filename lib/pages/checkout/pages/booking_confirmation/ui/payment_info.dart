import 'package:app/models/confirmation_model.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/widgets/app_card.dart';
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
          const Align(
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
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kVerticalSpacer,
          BorderedLeftContainerNoTitle(
            content: '${paymentOrder.paymentMethodCode}    ${paymentOrder.cardOption}',
          ),
          kVerticalSpacer,
          BorderedLeftContainerNoTitle(
            content: paymentOrder.paymentStatusCode ?? "",
          ),

          kVerticalSpacer,
          BorderedLeftContainerNoTitle(
            content:
            '${AppDateUtils.formatTimeWithoutLocale(paymentOrder.paymentDate)} Local Time',
          ),
          kVerticalSpacer,
          BorderedLeftContainerNoTitle(
            content:
                AppDateUtils.formatHalfDate(paymentOrder.paymentDate),
          ),
          kVerticalSpacer,
          BorderedLeftContainerNoTitle(
            content:
                "Total ${paymentOrder.currencyCode} ${NumberUtils.formatNum(paymentOrder.paymentAmount)}",
          ),
        ],
      ),
    );
  }
}

class BorderedLeftContainerNoTitle extends StatelessWidget {
  final String content;

  const BorderedLeftContainerNoTitle({Key? key, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Styles.kPrimaryColor, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(content, style: kLargeRegular),
        ],
      ),
    );
  }
}
