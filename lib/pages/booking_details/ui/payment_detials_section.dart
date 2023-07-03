import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../data/responses/manage_booking_response.dart';
import '../../../models/confirmation_model.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../utils/date_utils.dart';
import '../../../widgets/containers/app_expanded_section.dart';
import 'double_line_text.dart';

class PaymentDetailsSecond extends StatelessWidget {
  const PaymentDetailsSecond({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ManageBookingCubit>();
    final state = bloc.state;

    final locale = context.locale.toString();

    PaymentOrder? payment =
        state.manageBookingResponse?.result?.paymentOrders?.last;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: InkWell(
            onTap: () {
              bloc.changeContactsExpanded(isPayment: true);
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'paymentDetails'.tr(),
                    style: kHugeHeavy.copyWith(color: Styles.kDartBlack),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    (state.companyTaxInvoiceExpanded)
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
        ),
        ExpandedSection(
          expand: state.paymentDetailsExpanded,
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      AppDateUtils.formatHalfDateHalfMonth(payment?.paymentDate ?? DateTime.now(),
                          locale: locale),
                      style: kMediumSemiBold.copyWith(color: Styles.kTextColor),
                    ),
                    kVerticalSpacerSmall,

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            payment?.cardHolderName ?? 'Contanct name' ,
                            style: kMediumRegular.copyWith(color: Styles.kTextColor),
                          ),
                        ),

                        //FPX

                        if(payment?.cardOption == 'FPX' ) ... [
                          Expanded(
                            child: Text(
                              '${'paymentDetails'.tr()} - ${payment?.cardOption ?? ''}'  ,
                              style: kMediumRegular.copyWith(color: Styles.kTextColor),
                            ),
                          ),
                        ] else
                        if(payment?.cardNumber != null) ... [
                          Expanded(
                            child: Text(
                              'creditCard'.tr() +  ' - '  + (payment?.cardOption ?? '')  ,
                              style: kMediumRegular.copyWith(color: Styles.kTextColor),
                            ),
                          ),
                        ] else ... [

                        ],


                      ],
                    ),
                    kVerticalSpacerSmall,
                    Text(
                      '${payment?.currencyCode ?? 'MYR'} ${payment?.paymentAmount ?? 0.0}' ,
                      style: kMediumRegular.copyWith(color: Styles.kTextColor),
                    ),

                    kVerticalSpacerSmall,


                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}