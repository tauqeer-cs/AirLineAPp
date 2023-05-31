import 'package:app/models/confirmation_model.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../widgets/containers/app_expanded_section.dart';

class PaymentInfo extends StatefulWidget {
  final bool isChange;
  final bool showPending;

  final List<PaymentOrder>? paymentOrders;

  const PaymentInfo(
      {Key? key,
      this.isChange = false,
      this.paymentOrders,
      this.showPending = false})
      : super(key: key);

  @override
  State<PaymentInfo> createState() => _PaymentInfoState();
}

class _PaymentInfoState extends State<PaymentInfo> {
  bool isExpand = true;

  ConfirmationCubit? confirmationBloc;


  @override
  Widget build(BuildContext context) {
    List<PaymentOrder>? payments = [];

    String paymentState = '';
    if (widget.isChange) {
      payments = widget.paymentOrders;
    } else {
      payments = context
          .watch<ConfirmationCubit>()
          .state
          .confirmationModel
          ?.value
          ?.paymentOrders;

      confirmationBloc = context
          .watch<ConfirmationCubit>();

      paymentState = context.watch<ConfirmationCubit>().state.bookingStatus;
      print('');
    }


    return AppCard(
      child: Column(
        children: [
          if ((payments?.isEmpty ?? false) &&
              (paymentState == 'PPB' || paymentState == 'BIP')) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "paymentView.paymentTitle".tr(),
                style: kHugeSemiBold,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 120, horizontal: 60),
              child: OutlinedButton(
                onPressed: () {

                  if(widget.isChange) {

                  }
                  else {
                    confirmationBloc?.refreshData();

                  }
                },
                child: const Text('Refresh'),
              ),
            ),
          ] else ...[
            InkWell(
              onTap: () {
                setState(() {
                  isExpand = !isExpand;
                });
              },
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "paymentView.paymentTitle".tr(),
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
                      .map((f) => PaymentDetail(
                            paymentOrder: f,
                            changeFlight: widget.isChange,
                          ))
                      .toList(),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class PaymentDetail extends StatelessWidget {
  final PaymentOrder paymentOrder;
  final bool changeFlight;

  final bool showPending;

  const PaymentDetail(
      {Key? key,
      required this.paymentOrder,
      required this.changeFlight,
      this.showPending = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.toString();

    var currency = 'MYR';

    if (changeFlight) {
      print('');
    } else {
      currency = context
              .watch<ConfirmationCubit>()
              .state
              .confirmationModel
              ?.value
              ?.fareAndBundleDetail
              ?.currencyToShow ??
          'MYR';
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kVerticalSpacer,
          BorderedLeftContainerNoTitle(
            content: '${paymentOrder.cardOption}',
            makeBoldAll: true,

          ),
          kVerticalSpacer,
          BorderedLeftContainerNoTitle(
            content: paymentOrder.cardNumber ?? "",
            makeBoldAll: true,

          ),
          kVerticalSpacer,
          BorderedLeftContainerNoTitle(
            content: paymentOrder.paymentStatusCode ?? "",
            makeBoldAll: true,

          ),
          kVerticalSpacer,
          BorderedLeftContainerNoTitle(
            content: paymentOrder.cardHolderName ?? "",
            makeBoldAll: true,

          ),
          kVerticalSpacer,
          BorderedLeftContainerNoTitle(
            content:
                '${AppDateUtils.formatTimeWithoutLocale(paymentOrder.paymentDate, locale: locale)} ${'localTime'.tr()}',
          ),
          kVerticalSpacer,
          BorderedLeftContainerNoTitle(
            content: AppDateUtils.formatHalfDate(paymentOrder.paymentDate,locale: locale),
          ),
          kVerticalSpacer,
          Row(
            children: [
              BorderedLeftContainerNoTitle(
                content: "flightCharge.total".tr(),
                makeBoldAll: true,
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                '${paymentOrder.currencyCode ?? currency} ${NumberUtils.formatNum(paymentOrder.paymentAmount)}',
                style: kLargeHeavy.copyWith(color: Styles.kTextColor),
              ),
              Expanded(
                flex: 2,
                child: Container(),
              ),
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
          if (makeBoldAll) ...[
            Text(content,
                style: kLargeHeavy.copyWith(color: Styles.kTextColor)),
          ] else ...[
            Text(content,
                style: kLargeRegular.copyWith(color: Styles.kTextColor)),
          ]
        ],
      ),
    );
  }
}
