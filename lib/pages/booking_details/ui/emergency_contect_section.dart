import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../models/confirmation_model.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../widgets/containers/app_expanded_section.dart';
import 'double_line_text.dart';

class EmergencyContactsSection extends StatelessWidget {
  const EmergencyContactsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ManageBookingCubit>();
    final state = bloc.state;

    BookingContact? bookingContact = state.manageBookingResponse?.result?.bookingContact;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: InkWell(
            onTap: () {
              bloc.changeContactsExpanded(isEmergency: true);
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'infoDetail.emergencyContact'.tr(),
                    style: kHugeHeavy.copyWith(color: Styles.kDartBlack),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    (state.contactsSectionExpanded)
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
          expand: state.emergencySectionExpanded,
          child: Column(
            children: [
              kVerticalSpacerSmall,
              DoubleLineTextTable( label: 'familyDetail.fName'.tr(), value: bookingContact?.emergencyGivenName ?? '',),
              kVerticalSpacer,
              DoubleLineTextTable( label: 'familyDetail.lName'.tr(), value: bookingContact?.emergencySurname ?? '',),
              kVerticalSpacer,
              DoubleLineTextTable( label: 'relationship'.tr(), value: bookingContact?.emergencyRelationship ?? '',),
              kVerticalSpacer,
              //kVerticalSpacer,
              //DoubleLineTextTable( label: 'passengerDetail.nationality'.tr(), value: bookingContact?.nationality ?? '',),
              kVerticalSpacer,
              DoubleLineTextTable( label: 'phoneNumber'.tr(), value: bookingContact?.emergencyPhone ?? '',),
              kVerticalSpacer,


            ],
          ),

        ),

        Divider(
          height: 1,
          color: Styles.kDisabledButton,
        ),
        kVerticalSpacer,

        //kDisabledButton
      ],
    );
  }
}
