import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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

  const PaymentDetailsSecond({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ManageBookingCubit>();
    final state = bloc.state;

    final locale = context.locale.toString();

    if((state.manageBookingResponse?.result?.paymentOrders ?? [] ).isEmpty) {
      return Container();
    }
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
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Card(
              elevation: 2, // This property sets the z-coordinate elevation of the card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
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
                            payment?.cardHolderName ?? 'Contact name' ,
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
                              '${'creditCard'.tr()} - ${payment?.cardOption ?? ''}'  ,
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
