import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../models/confirmation_model.dart';

class ConfirmationBaggage extends StatelessWidget {
  final bool boolIsSports;

  final bool isInsurance;
  final bool isDeparture;

  const ConfirmationBaggage(
      {Key? key,
      this.boolIsSports = false,
      this.isInsurance = false,
      required this.isDeparture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final baggage = context
        .watch<ConfirmationCubit>()
        .state
        .confirmationModel
        ?.value
        ?.baggageDetail;

    SportsEquipmentDetail? sportsEquipmentDetail;

    InsuranceDetails? insuranceDetails;

    bool hideView = false;
    var currency = context
        .watch<ConfirmationCubit>()
        .state
        .confirmationModel
        ?.value
        ?.fareAndBundleDetail
        ?.currencyToShow ??
        'MYR';
    if (boolIsSports) {
      sportsEquipmentDetail = context
          .watch<ConfirmationCubit>()
          .state
          .confirmationModel
          ?.value
          ?.sportEquipmentDetail;

      if (sportsEquipmentDetail!.totalAmount!.toInt() == 0) {
        hideView = true;
      }
    } else if (isInsurance) {
      insuranceDetails = context
          .watch<ConfirmationCubit>()
          .state
          .confirmationModel
          ?.value
          ?.insuranceSSRDetail;
      if (insuranceDetails!.totalAmount!.toInt() == 0) {
        hideView = true;
      }
    } else {
      hideView = (baggage?.baggages ?? []).isEmpty;
    }
    final amountNumber = amount(
      sportsEquipmentDetail,
      baggage,
      insuranceDetails,
    );
    return hideView || ((amountNumber??0)==0)
        ? Container()
        : Column(
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
                    amount: amount(
                      sportsEquipmentDetail,
                      baggage,
                      insuranceDetails,
                    ),
                    isDense: true,
                    isNormalMYR: true,
                    currency: currency,
                  ),
                ],
              ),
              if (isInsurance) ...[
                kVerticalSpacerSmall,
                ...(isDeparture
                        ? (insuranceDetails?.departureBaggages ?? [])
                        : (insuranceDetails?.returnBaggages ?? []))
                    .map((e) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${e.titleToShow} ${e.givenName} ${e.surName}"),
                            Text(e.insuranceSSRName ?? 'priceSection.insuranceTitle'.tr()),
                            kVerticalSpacerSmall,
                          ],
                        ))
                    .toList(),
              ] else if (boolIsSports) ...[
                kVerticalSpacerSmall,
                ...(isDeparture
                        ? (sportsEquipmentDetail?.departureBaggages ?? [])
                        : (sportsEquipmentDetail?.returnBaggages ?? []))
                    .map((e) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${e.titleToShow} ${e.givenName} ${e.surName}"),
                            Text("${e.sportEquipmentName}"),
                            kVerticalSpacerSmall,
                          ],
                        ))
                    .toList(),
              ] else ...[
                kVerticalSpacerSmall,
                ...(isDeparture
                        ? (baggage?.departureBaggages ?? [])
                        : (baggage?.returnBaggages ?? []))
                    .map((e) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${e.titleToShow} ${e.givenName} ${e.surName}"),
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

  num? amount(SportsEquipmentDetail? sportsEquipmentDetail,
      BaggageDetail? baggage, InsuranceDetails? insuranceDetails) {
    if (boolIsSports) {
      return isDeparture
          ? sportsEquipmentDetail?.totalDeparture()
          : sportsEquipmentDetail?.totalReturn();
    } else if (isInsurance) {
      return isDeparture
          ? insuranceDetails?.totalDeparture()
          : insuranceDetails?.totalReturn();
    }
    return isDeparture ? baggage?.totalDeparture() : baggage?.totalReturn();
  }

  String titleText() {
    if (boolIsSports) {
      return 'priceSection.sportsEquipmentTitle'.tr();
    } else if (isInsurance) {
      return 'insurance'.tr();
    }
    return "baggage".tr();
  }
}
