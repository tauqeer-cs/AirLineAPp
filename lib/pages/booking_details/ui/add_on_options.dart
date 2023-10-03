import 'package:app/pages/checkout/pages/insurance/bloc/insurance_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../data/responses/manage_booking_response.dart';
import '../../../models/number_person.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../widgets/containers/app_expanded_section.dart';
import '../../../widgets/forms/app_input_text.dart';
import 'add_ons_card_items.dart';
import 'double_line_text.dart';

class AddOnOptions extends StatelessWidget {
  const AddOnOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ManageBookingCubit>();

    bloc.state.selectedPax?.personObject?.departureSeats;
    final selectedPax = context.watch<ManageBookingCubit>().state.selectedPax;

    var seatNoSelected = 0;
    if (selectedPax?.personObject?.departureSeats != null) {
      seatNoSelected++;
    }
    if (selectedPax?.personObject?.returnSeats != null) {
      seatNoSelected++;
    }

    var mealsSelected = 0;

    if ((selectedPax?.personObject?.departureMeal ?? []).isNotEmpty) {
      mealsSelected = (selectedPax?.personObject?.departureMeal ?? []).length;
    }

    if ((selectedPax?.personObject?.returnMeal ?? []).isNotEmpty) {
      mealsSelected = (selectedPax?.personObject?.returnMeal ?? []).length;
    }

    var baggageSelected = 0;
    if (selectedPax?.personObject?.departureBaggage != null) {
      baggageSelected++;
    }
    if (selectedPax?.personObject?.returnBaggage != null) {
      baggageSelected++;
    }

    var wheelChairSelected = 0;
    if (selectedPax?.personObject?.departureWheelChair != null) {
      wheelChairSelected++;
    }
    if (selectedPax?.personObject?.returnWheelChair != null) {
      wheelChairSelected++;
    }

    int insuranceSelected = 0;

    if (selectedPax?.insuranceSSRDetail != null) {
      if ((selectedPax?.insuranceSSRDetail?.totalAmount ?? 0.0) > 0) {
        insuranceSelected++;

      }
    }
    if(insuranceSelected == 0){
      if(bloc.state.confirmedInsuranceType == InsuranceType.all) {
        if(bloc.state.manageBookingResponse?.confirmedInsuranceBundleSelected != null) {
          insuranceSelected++;
        }
      }
      else if(bloc.state.confirmedInsuranceType == InsuranceType.selected) {

        if(selectedPax?.confirmedInsuranceBundleSelected != null) {
          insuranceSelected++;
        }
      }
    }


    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "flightSummary.addons".tr(),
            style: k18Heavy.copyWith(color: Styles.kTextColor),
          ),
        ),
        kVerticalSpacerSmall,
        Container(
          constraints: const BoxConstraints(
            minHeight: 50,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              AddOnsCardItem(
                isActive: bloc.state.addOnOptionSelected == AddonType.seat,
                name: 'seat'.tr(),
                imageName: 'icoAddseats',
                currentOption: AddonType.seat,
                noSelectedText: seatNoSelected == 0
                    ? 'noSeatSelected'.tr()
                    : ('$seatNoSelected ${'selected'.tr()}'),
              ),

              const SizedBox(
                width: 8,
              ),

              AddOnsCardItem(
                isActive: bloc.state.addOnOptionSelected == AddonType.meal,
                name: 'meal'.tr(),
                imageName: 'icoAddmeals',
                currentOption: AddonType.meal,
                noSelectedText: mealsSelected == 0
                    ? 'noSeatSelected'.tr()
                    : ('$mealsSelected ${'selected'.tr()}'),
              ),

              const SizedBox(
                width: 8,
              ),

              //baggageSelected
              AddOnsCardItem(
                isActive: bloc.state.addOnOptionSelected == AddonType.baggage,
                name: 'baggage'.tr(),
                imageName: 'icoAddbaggage',
                currentOption: AddonType.baggage,
                noSelectedText: baggageSelected == 0
                    ? 'noSeatSelected'.tr()
                    : ('$baggageSelected ${'selected'.tr()}'),
              ),

              const SizedBox(
                width: 8,
              ),

              //
              AddOnsCardItem(
                isActive: bloc.state.addOnOptionSelected == AddonType.special,
                name: 'specialAddOn'.tr(),
                imageName: 'icoGeneric',
                currentOption: AddonType.special,
                noSelectedText: wheelChairSelected == 0
                    ? 'noSeatSelected'.tr()
                    : ('$wheelChairSelected ${'selected'.tr()}'),
              ),

              const SizedBox(
                width: 8,
              ),



              /*


              AddOnsCardItem(
                isActive: bloc.state.addOnOptionSelected == AddonType.insurance,
                name: 'insurance'.tr(),
                imageName: 'icoInsurance',
                currentOption: AddonType.insurance,
                noSelectedText: insuranceSelected == 0 ? 'noSeatSelected'.tr() : ('$insuranceSelected ${'selected'.tr()}'),
              ),



               */




              const SizedBox(
                width: 8,
              ),

              //.png
            ]),
          ),
        )
      ],
    );
  }
}
