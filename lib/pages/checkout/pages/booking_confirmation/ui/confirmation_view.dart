import 'dart:typed_data';

import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/confirmation_baggage.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/confirmation_meals.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/confirmation_promo.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/confirmation_seats.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/fares_and_bundles.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/passengers_widget.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/payment_info.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/summary_widget.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ConfirmationView extends StatefulWidget {
  const ConfirmationView({Key? key}) : super(key: key);

  @override
  State<ConfirmationView> createState() => _ConfirmationViewState();
}

class _ConfirmationViewState extends State<ConfirmationView> {
  Uint8List? _imageFile;
  ScreenshotController screenshotController = ScreenshotController();

  onShare() async {
    final directory = (await getApplicationDocumentsDirectory()).path; //from path_provide package
    String fileName = DateTime.now().microsecondsSinceEpoch.toString();
    await screenshotController.captureAndSave(directory, fileName: fileName);
    Share.shareFiles(['$directory/$fileName.jpg']);

  }

  @override
  Widget build(BuildContext context) {
    final confirmationDetail = context.watch<ConfirmationCubit>().state;
    return ListView(
      padding: kPagePadding,
      children: [
        kVerticalSpacerSmall,
        Text(
          "Your booking has been confirmed.\nA confirmation email has been sent to\n${confirmationDetail.confirmationModel?.value?.bookingContact?.email}",
          style:
              kMediumMedium.copyWith(color: Styles.kSubTextColor, height: 1.5),
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
            ],
          ),
        ),
        kVerticalSpacer,
        SummaryWidget(),
        kVerticalSpacer,
        AppCard(
          child: Column(
            children: [
              FaresAndBundles(),
              ConfirmationSeats(),
              ConfirmationMeals(),
              ConfirmationBaggage(),
              ConfirmationPromo(),
              kVerticalSpacerSmall,
              AppDividerWidget(),
              kVerticalSpacerSmall,
              Row(
                children: [
                  Text("Total", style: kGiantHeavy),
                  Spacer(),
                  MoneyWidget(
                    amount: (confirmationDetail.confirmationModel?.value
                                ?.superPNROrder?.totalBookingAmt ??
                            0) -
                        (confirmationDetail.confirmationModel?.value
                                ?.superPNROrder?.voucherDiscountAmt ??
                            0),
                    isDense: false,
                  ),
                ],
              ),
            ],
          ),
        ),
        kVerticalSpacer,
        kVerticalSpacerSmall,
        PaymentInfo(),
        kVerticalSpacer,
        OutlinedButton(onPressed: onShare, child: Text("Share")),
        kVerticalSpacerSmall,
        ElevatedButton(onPressed: () {}, child: Text("Back to Home")),
      ],
    );
  }
}
