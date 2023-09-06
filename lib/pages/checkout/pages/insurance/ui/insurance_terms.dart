import 'package:app/pages/checkout/pages/insurance/bloc/insurance_cubit.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/ui_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InsuranceTerms extends StatelessWidget {
  final bool isInternational;

  const InsuranceTerms({Key? key,required this.isInternational}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final insuranceCubit = context.watch<InsuranceCubit>().state;
    final selected = insuranceCubit.insuranceType;
    if(selected == InsuranceType.none) {
      return Container();
    }
    return Visibility(
      visible: selected != null,
      child: Column(
        children: [
          kVerticalSpacer,
           Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Transform.translate(
                offset: Offset(0, -8),
                child: Checkbox(
                  value: true,
                  activeColor: Styles.kActiveGrey,
                  onChanged: (_) {},
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: kMediumMedium.copyWith(
                        color: Styles.kTextColor,
                        height: 20 / 14,
                        letterSpacing: -0.3),
                    children: <TextSpan>[
                       TextSpan(
                        text:
                       '${'yesIWantInsurance'.tr()}\n\n',
                      ),
                       TextSpan(
                        text:
                        'iAcknowledgeInsurancePolicy'.tr(),
                      ),

                      makeClickableTextSpan(context,
                          text: 'productDisclosure'.tr(),
                          pdfIsLink: false,
                          pdfName: 'product_disclosure',
                          webViewLink:
                          'https://booking.myairline.my/insurance/product_disclosure.pdf'),

                       TextSpan(
                        text: ', ${'understoodAgree'.tr()} ',
                      ),

                      makeClickableTextSpan(context,
                          text: 'termsAndConditions'.tr(),
                          webViewLink:
                          'https://booking.myairline.my/insurance/term_and_conditions.pdf',
                          pdfIsLink: false,
                          pdfName: 'interntional_terms'
                      ),


                      TextSpan(
                        text:
                        ' ${'insuranceLongText'.tr()} ',
                      ),
                      makeClickableTextSpan(context,
                          text: 'dataPrivacyNotice'.tr(),
                          webViewLink: 'https://www.zurich.com.my/pdpa'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


