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
import 'double_line_text.dart';

class AddOnsCardItem extends StatelessWidget {
  final AddonType currentOption;

  final String imageName;

  final String name;

  final bool isActive;

  const AddOnsCardItem(
      {Key? key,
        required this.isActive,
        required this.name,
        required this.imageName,
        required this.currentOption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ManageBookingCubit>();

    return GestureDetector(
      onTap: () {
        if (isActive == false) {
          bloc.changeSelectedAddOnOption(currentOption);
        } else {
          bloc.changeSelectedAddOnOption(currentOption, toNull: true);
        }
      },
      child: Container(
        constraints: const BoxConstraints(minWidth: 160),
        margin: const EdgeInsets.only(right: 8),
        child: Card(
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: isActive ? Styles.kActiveColor : Colors.white,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        isActive
                            ? "assets/images/icons/${imageName}Selected.png"
                            : "assets/images/icons/$imageName.png",
                        width: 32,
                        height: 32,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        name,
                        style: kMediumSemiBold.copyWith(
                            color: isActive ? Colors.white : null),
                      ),
                    ],
                  ),
                  kVerticalSpacerMini,
                  Text(
                    isActive ? 'selecting'.tr() : 'noSeatSelected'.tr(),
                    style: kSmallMedium.copyWith(
                        color: isActive ? Colors.white : null),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}