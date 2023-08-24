import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../models/confirmation_model.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../widgets/containers/app_expanded_section.dart';
import '../../checkout/pages/booking_details/ui/passenger_contact.dart';
import 'double_line_text.dart';

class ContactsSection extends StatelessWidget {
  const ContactsSection({Key? key}) : super(key: key);

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
              bloc.changeContactsExpanded();
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'contact'.tr(),
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

        Divider(
          height: 1,
          color: Styles.kDisabledButton,
        ),


        true ? ExpandedSection(
            expand: state.contactsSectionExpanded,
            child:  PassengerContact(
              manageBooking: true,
              bookingContact: bloc.state.manageBookingResponse?.result?.bookingContact,
            ),) :

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

