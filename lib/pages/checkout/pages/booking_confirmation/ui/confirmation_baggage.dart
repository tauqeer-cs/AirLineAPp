import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/confirmation_model.dart';

class ConfirmationBaggage extends StatelessWidget {

  final bool boolIsSports;

   ConfirmationBaggage({Key? key,this.boolIsSports = false}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final baggage = context
        .watch<ConfirmationCubit>()
        .state
        .confirmationModel
        ?.value
        ?.baggageDetail;

    SportsEquipmentDetail ? sportsEquipmentDetail;

    if(boolIsSports) {
      sportsEquipmentDetail = context
          .watch<ConfirmationCubit>()
          .state
          .confirmationModel
          ?.value
          ?.sportEquipmentDetail;

    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
             Text(
               boolIsSports ? 'Sport Equipment' : "Baggage",
              style: kHugeSemiBold,
            ),
            const Spacer(),
            MoneyWidget(
              amount: boolIsSports ? sportsEquipmentDetail?.totalAmount : baggage?.totalAmount,
              isDense: true,
            ),
          ],
        ),
        if(boolIsSports) ... [
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
}
