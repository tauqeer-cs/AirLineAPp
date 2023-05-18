import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../data/responses/manage_booking_response.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../widgets/containers/app_expanded_section.dart';
import '../../../widgets/forms/app_input_text.dart';
import 'double_line_text.dart';

class SelectedPassengerInfo extends StatelessWidget {

  final PassengersWithSSR? passengers;

  const SelectedPassengerInfo(this.passengers, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc  = context.watch<ManageBookingCubit>();

    var state  = context.watch<ManageBookingCubit>().state;
    int i = state.manageBookingResponse?.result?.passengersWithSSR?.indexOf(passengers!) ?? 1;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            passengers?.passengers?.fullName ?? '',
            style: kLargeMedium.copyWith(color: Styles.kTextColor),
          ),
        ),
        kVerticalSpacerSmall,

        DoubleLineTextTable( label: 'familyDetail.fName'.tr(), value: passengers?.passengers?.givenName ?? '',),

        kVerticalSpacerSmall,

        DoubleLineTextTable( label: 'familyDetail.lName'.tr(), value: passengers?.passengers?.surname ?? '',),

        kVerticalSpacerSmall,
        DoubleLineTextTable( label: 'passengerDetail.nationality'.tr(), value: passengers?.passengers?.nationality ?? '',),


        kVerticalSpacerSmall,

        if( (passengers?.passengers?.myRewardMemberId ?? '').isNotEmpty ) ... [
          AppInputText(
            hintText: "firstNameMember".tr(),
            readOnly: true,
            initialValue: passengers?.passengers?.myRewardMemberId ?? '',
            name: passengers?.passengers?.myRewardMemberId ?? '',
            fillDisabledColor: true,
          ),
          kVerticalSpacerSmall,
        ] ,

        if(passengers?.haveInfant == true) ... [

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {
                bloc.changeInfantSelected(i);

              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'paymentView.infant'.tr(),
                      style: kHugeHeavy.copyWith(color: Styles.kDartBlack),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      (state.manageBookingResponse?.result
                          ?.passengersWithSSR?[i].infantExpanded ?? true)
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
            expand: state.manageBookingResponse?.result
                ?.passengersWithSSR?[i].infantExpanded ?? false,
            child: Column(
              children: [
                DoubleLineTextTable( label: 'familyDetail.fName'.tr(), value: passengers?.infantGivenName ?? '',),

                kVerticalSpacerSmall,
                DoubleLineTextTable( label: 'familyDetail.lName'.tr(), value: passengers?.infantSurname ?? '',),
                kVerticalSpacerSmall,
                DoubleLineTextTable( label: 'passengerDetail.nationality'.tr(), value: passengers?.infantNationality ?? '',),
                kVerticalSpacer,


              ],
            ),

          ),
        ],

      ],
    );
  }
}
