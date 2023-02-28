import 'package:app/app/app_router.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/confirmation_baggage.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/confirmation_meals.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/confirmation_promo.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/confirmation_seats.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/fares_and_bundles.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/passengers_widget.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/payment_info.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/summary_widget.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ConfirmationView extends StatefulWidget {
  const ConfirmationView({Key? key,required this.isChangeFlight}) : super(key: key);

  final bool isChangeFlight;

  @override
  State<ConfirmationView> createState() => _ConfirmationViewState();
}

class _ConfirmationViewState extends State<ConfirmationView> {
  ScreenshotController screenshotController = ScreenshotController();
  bool isLoading = false;

  onShare() async {
    setState(() {
      isLoading = true;
    });
    final directory = (await getApplicationDocumentsDirectory())
        .path; //from path_provide package
    String fileName = "${DateTime.now().microsecondsSinceEpoch.toString()}.jpg";
    await screenshotController.captureAndSave(directory, fileName: fileName);
    setState(() {
      isLoading = false;
    });
    Share.shareXFiles([XFile('$directory/$fileName')]);
  }

  @override
  Widget build(BuildContext context) {
    final confirmationDetail = context.watch<ConfirmationCubit>().state;
    return SingleChildScrollView(
      child: Screenshot(
        controller: screenshotController,
        child: Container(
          color: Colors.white,
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: kPagePadding,
            children: [
              kVerticalSpacerSmall,
              Text(
                "A confirmation email has been sent to",
                style: kMediumMedium.copyWith(
                    color: Styles.kSubTextColor, height: 1.5),
                textAlign: TextAlign.center,
              ),
              Text(
                "${confirmationDetail.confirmationModel?.value?.bookingContact?.email}",
                style: kMediumMedium.copyWith(
                    color: Styles.kTextColor, height: 1.5),
                textAlign: TextAlign.center,
              ),
              kVerticalSpacerSmall,
              Text(
                "Booking reference:  ${confirmationDetail.confirmationModel?.value?.flightBookings?.firstOrNull?.supplierBookingNo}",
                style: kHugeSemiBold.copyWith(color: Styles.kDartBlack),
                textAlign: TextAlign.center,
              ),
              kVerticalSpacer,
              AppCard(
                child: Column(
                  children: const [
                    PassengersWidget(),
                  ],
                ),
              ),

              kVerticalSpacer,
              const SummaryWidget(),
              kVerticalSpacer,

              AppCard(
                child: Column(
                  children: [
                    const FaresAndBundles(),
                    const ConfirmationSeats(),
                    const ConfirmationMeals(),
                    const ConfirmationBaggage(),
                    const ConfirmationBaggage(
                      boolIsSports: true,
                    ),
                    const ConfirmationBaggage(
                      isInsurance: true,
                    ),
                    //1 == 1 ? Container() :
                    const ConfirmationPromo(),
                    kVerticalSpacerSmall,
                    const AppDividerWidget(),
                    kVerticalSpacerSmall,
                    Row(
                      children: [
                        const Text("Total", style: kGiantHeavy),
                        const Spacer(),
                        MoneyWidget(
                          amount: (confirmationDetail.confirmationModel?.value
                                      ?.superPNROrder?.totalBookingAmt ??
                                  0) -
                              (confirmationDetail.confirmationModel?.value
                                      ?.superPNROrder?.voucherDiscountAmt ??
                                  0),
                          isDense: false,
                          isNormalMYR: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              kVerticalSpacer,
              kVerticalSpacerSmall,
              const PaymentInfo(),
              kVerticalSpacer,
              OutlinedButton(
                onPressed: isLoading ? null : onShare,
                child: isLoading
                    ? const AppLoading(
                        size: 20,
                      )
                    : const Text("Share"),
              ),
              kVerticalSpacerSmall,
              ElevatedButton(
                onPressed: () {
                  context.router.replaceAll([const NavigationRoute()]);
                },
                child: const Text("Back to Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
