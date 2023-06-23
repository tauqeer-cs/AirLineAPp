
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
              ),

              const SizedBox(
                width: 8,
              ),

              AddOnsCardItem(
                isActive: bloc.state.addOnOptionSelected == AddonType.meal,
                name: 'meal'.tr(),
                imageName: 'icoAddmeals',
                currentOption: AddonType.meal,
              ),

              const SizedBox(
                width: 8,
              ),

              AddOnsCardItem(
                isActive: bloc.state.addOnOptionSelected == AddonType.baggage,
                name: 'baggage'.tr(),
                imageName: 'icoAddbaggage',
                currentOption: AddonType.baggage,
              ),

              const SizedBox(
                width: 8,
              ),

              AddOnsCardItem(
                isActive: bloc.state.addOnOptionSelected == AddonType.special,
                name: 'specialAddOn'.tr(),
                imageName: 'icoGeneric',
                currentOption: AddonType.special,
              ),

              const SizedBox(
                width: 8,
              ),

              AddOnsCardItem(
                isActive: bloc.state.addOnOptionSelected == AddonType.insurance,
                name: 'insurance'.tr(),
                imageName: 'icoInsurance',
                currentOption: AddonType.insurance,
              ),

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