import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/fares_and_bundles.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/passengers_widget.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/payment_info.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/summary_widget.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationView extends StatelessWidget {
  const ConfirmationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final confirmationDetail = context.watch<ConfirmationCubit>().state;
    return ListView(
      padding: kPagePadding,
      children: [
        Text(
          "Your booking has been confirmed. A confirmation email has been sent to ${confirmationDetail.confirmationModel?.value?.bookingContact?.email}",
          style: kLargeMedium,
          textAlign: TextAlign.center,
        ),
        kVerticalSpacerSmall,
        Text(
          "Booking reference:  ${confirmationDetail.confirmationModel?.value?.superPNR?.superPNRNo}",
          style: kHugeSemiBold.copyWith(color: Styles.kPrimaryColor),
          textAlign: TextAlign.center,
        ),
        kVerticalSpacer,
        AppCard(
          child: Column(
            children: [
              PassengersWidget(),
              SummaryWidget(),
            ],
          ),
        ),
        kVerticalSpacer,
        FaresAndBundles(),
        kVerticalSpacer,
        PaymentInfo(),
      ],
    );
  }
}
