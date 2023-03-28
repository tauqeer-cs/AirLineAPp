import 'package:app/pages/checkout/pages/insurance/bloc/insurance_cubit.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InsuranceTerms extends StatelessWidget {
  const InsuranceTerms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final insuranceCubit = context.watch<InsuranceCubit>().state;
    final selected = insuranceCubit.insuranceType;
    return Visibility(
      visible: selected != null && selected != InsuranceType.none,
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
                    letterSpacing: -0.3
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'Yes, I would like to add MYAirline Travel Insurance to protect my trip.\n\n',
                    ),
                    TextSpan(
                      text:
                          'I acknowledge and agree that the Policy issued is non-cancellable and premium paid is non-refundable, and the Policy does not cover persons who are on any sanction lists and in such event, the Policy will be void and premium is non-refundable. I confirm that I have read the',
                    ),
                    TextSpan(
                      text: ' Product Disclosure Sheet',
                      style: kMediumHeavy.copyWith(
                          color: Styles.kBlueColor,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: ', understood and agree to the, ',
                    ),
                    TextSpan(
                      text: 'Terms and Conditions ',
                      style: kMediumHeavy.copyWith(
                          color: Styles.kBlueColor,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text:
                          'of MYAirline Travel Insurance and agree to the processing of my Personal Data in accordance with the ',
                    ),
                    TextSpan(
                      text: 'Data Privacy Notice',
                      style: kMediumHeavy.copyWith(
                          color: Styles.kBlueColor,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }
}
