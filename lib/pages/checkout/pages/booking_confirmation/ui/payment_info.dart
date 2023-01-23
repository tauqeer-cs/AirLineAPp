import 'package:app/models/confirmation_model.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../widgets/containers/app_expanded_section.dart';

class PaymentInfo extends StatefulWidget {
  const PaymentInfo({Key? key}) : super(key: key);

  @override
  State<PaymentInfo> createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  bool isExpand = true;

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
          InkWell(
            onTap: () {
              setState(() {
                isExpand = !isExpand;
              });
            },
            child: Row(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Payment",
                    style: kHugeSemiBold,
                  ),
                ),
                Icon(
                  isExpand
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 24,
                ),
              ],
            ),
          ),
          ExpandedSection(
            expand: isExpand,
            child: Column(
              children: [
                kVerticalSpacerSmall,
                ...(payments ?? [])
                    .map((f) => PaymentDetail(paymentOrder: f))
                    .toList(),
              ],
            ),
          ),
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
            content:
                '${paymentOrder.paymentMethodCode}    ${paymentOrder.cardOption}',
            makeBoldAll: true,

          ),
          kVerticalSpacer,
          BorderedLeftContainerNoTitle(
            content: paymentOrder.paymentStatusCode ?? "",
            makeBoldAll: true,

          ),
          kVerticalSpacer,
          BorderedLeftContainerNoTitle(
            content:
                '${AppDateUtils.formatTimeWithoutLocale(paymentOrder.paymentDate)} Local Time',
          ),
          kVerticalSpacer,
          BorderedLeftContainerNoTitle(
            content: AppDateUtils.formatHalfDate(paymentOrder.paymentDate),
          ),
          kVerticalSpacer,
          Row(
            children: [
              const BorderedLeftContainerNoTitle(
                content:
                    "Total ",
                makeBoldAll: true,
              ),

              Expanded(child: Container(),),

              Text(paymentOrder.currencyCode! + NumberUtils.formatNum(paymentOrder.paymentAmount), style: kLargeHeavy.copyWith(color: Styles.kTextColor)),


              Expanded(
                flex: 2,
                child: Container(),),
            ],
          ),
        ],
      ),
    );
  }
}

class BorderedLeftContainerNoTitle extends StatelessWidget {
  final String content;

  final bool makeBoldAll;

  const BorderedLeftContainerNoTitle(
      {Key? key, required this.content, this.makeBoldAll = false})
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
          if(makeBoldAll) ... [
            Text(content, style: kLargeHeavy.copyWith(color: Styles.kTextColor)),
          ] else ... [
            Text(content, style: kLargeRegular.copyWith(color: Styles.kTextColor)),

          ]
        ],
      ),
    );
  }
}
