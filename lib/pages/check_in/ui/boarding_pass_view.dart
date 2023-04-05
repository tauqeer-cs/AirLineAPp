import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../select_change_flight/ui/booking_refrence_label.dart';
import '../bloc/check_in_cubit.dart';
import 'check_in_steps.dart';

class BoardingPassView extends StatelessWidget {
  const BoardingPassView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<CheckInCubit>();
    var state = bloc.state;

    return Padding(
      padding: kPageHorizontalPadding,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            BookingReferenceLabel(
              refText: state.pnrEntered,
            ),
            SizedBox(
              width: double.infinity,
              child: CheckInSteps(
                isLast: true,
                passedSteps: const [
                  CheckInStep.bookingDetails,
                ],
                onTopStepTaped: (i) {},
              ),
            ),
            kVerticalSpacer,
            kVerticalSpacerMini,
            Text(
              'Boarding Pass',
              style: kHugeSemiBold.copyWith(
                color: Styles.kTextColor,
              ),
              textAlign: TextAlign.left,
            ),
            kVerticalSpacerSmall,
            Text(
              '''Your check-in has been confirmed. A copy of the boarding pass has been automatically sent to the registered contact person. You may also print, email and download the boarding pass individually below:''',
              style: kMediumMedium.copyWith(
                color: Styles.kTextColor,
              ),
              textAlign: TextAlign.left,
            ),
            kVerticalSpacer,

          ],
        ),
      ),
    );
  }
}
