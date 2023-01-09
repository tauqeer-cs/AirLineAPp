import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/confirmation_model.dart';

class ConfirmationBaggage extends StatelessWidget {

  final bool boolIsSports;

  final bool isInsurance;

   const ConfirmationBaggage({Key? key,this.boolIsSports = false, this.isInsurance = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baggage = context
        .watch<ConfirmationCubit>()
        .state
        .confirmationModel
        ?.value
        ?.baggageDetail;

    SportsEquipmentDetail ? sportsEquipmentDetail;

    InsuranceDetails ? insuranceDetails;

    bool hideView = false;

    if(boolIsSports) {
      sportsEquipmentDetail = context
          .watch<ConfirmationCubit>()
          .state
          .confirmationModel
          ?.value
          ?.sportEquipmentDetail;


      if(sportsEquipmentDetail!.totalAmount!.toInt() == 0){
        hideView = true;
      }

      print('');

    }
    else if(isInsurance){



      insuranceDetails = context
          .watch<ConfirmationCubit>()
          .state
          .confirmationModel
          ?.value
          ?.insuranceSSRDetail;
      if(insuranceDetails!.totalAmount!.toInt() == 0){
        hideView = true;
      }


    }
    return hideView ? Container() : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
             Text(
               titleText(),
              style: kHugeSemiBold,
            ),
            const Spacer(),
            MoneyWidget(
              amount: amount(sportsEquipmentDetail, baggage,insuranceDetails),
              isDense: true, isNormalMYR: true,
            ),
          ],
        ),
        if(isInsurance) ... [
          kVerticalSpacerSmall,
          ...(insuranceDetails?.insuranceSSRs ?? [])
              .map((e) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${e.title} ${e.givenName} ${e.surName}"),
               Text(e.insuranceSSRName ?? 'Insurance'),
              kVerticalSpacerSmall,
            ],
          ))
              .toList(),
        ]
        else if(boolIsSports) ... [
          kVerticalSpacerSmall,
          ...(sportsEquipmentDetail?.sportEquipments ?? [])
              .map((e) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${e.title} ${e.givenName} ${e.surName}"),
              Text("${e.sportEquipmentName}"),
              kVerticalSpacerSmall,
            ],
          ))
              .toList(),

        ] else  ... [
          kVerticalSpacerSmall,
          ...(baggage?.baggages ?? [])
              .map((e) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${e.title} ${e.givenName} ${e.surName}"),
              Text("${e.baggageName}"),
              kVerticalSpacerSmall,
            ],
          ))
              .toList(),

        ],
        kVerticalSpacerSmall,
      ],
    );
  }

  num? amount(SportsEquipmentDetail? sportsEquipmentDetail, BaggageDetail? baggage,InsuranceDetails? insuranceDetails) {

    if(boolIsSports){

      return sportsEquipmentDetail?.totalAmount;

    }else if(isInsurance){
      return insuranceDetails?.totalAmount;
    }

    return baggage?.totalAmount;
  }

  String titleText()  {
    if(boolIsSports) {
      return 'Sport Equipment';
    }
    else if(isInsurance) {

      return 'Insurance';
    }
    return "Baggage";
  }
}
