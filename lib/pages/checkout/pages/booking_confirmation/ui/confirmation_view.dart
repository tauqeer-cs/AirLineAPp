import 'package:app/app/app_router.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/confirmation_promo.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/passengers_widget.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/payment_info.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/summary_widget.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ConfirmationView extends StatefulWidget {
  final bool isMMb;
  final String pnr;
  final String status;
  final Widget? summaryToShow;

  const ConfirmationView({
    Key? key,
    required this.pnr,
    required this.status,
    this.isMMb = false,
    this.summaryToShow,
  }) : super(key: key);

  @override
  State<ConfirmationView> createState() => _ConfirmationViewState();
}

class _ConfirmationViewState extends State<ConfirmationView> {
  ScreenshotController screenshotController = ScreenshotController();
  ScrollController _controllerSroll = ScrollController();

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

  bool isPendingStatus() {
    if(widget.status == 'PPB' ||
        widget.status == 'BIP' ||
        widget.status == 'PPA' ||
        widget.status == 'PEN'){
      return true;
    }

    return false;

  }
  @override
  Widget build(BuildContext context) {
    final confirmationDetail = context.watch<ConfirmationCubit>().state;
    final currencyToShow = context
            .watch<ConfirmationCubit>()
            .state
            .confirmationModel
            ?.value
            ?.fareAndBundleDetail
            ?.currencyToShow ??
        'MYR';

    return  SingleChildScrollView(
      controller: _controllerSroll,
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
              if (widget.status == 'PPB' ||
                  widget.status == 'BIP' ||
                  widget.status == 'PPA' ||
                  widget.status == 'PEN') ...[
                Text(
                  "confirmationView.bookingPayment".tr(),
                  style: kMediumRegular.copyWith(
                      color: Styles.kSubTextColor, height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ] else if (widget.status == 'EXP') ...[
                Text(
                  "confirmationView.statusExpired".tr(),
                  style: kMediumRegular.copyWith(
                      color: Styles.kSubTextColor, height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ] else if (widget.status == 'CON') ...[
                Text(
                  "confirmationView.bookingConfirm".tr(),
                  style: kMediumRegular.copyWith(
                      color: Styles.kSubTextColor, height: 1.5),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "${confirmationDetail.confirmationModel?.value?.bookingContact?.email}",
                  style: kMediumMedium.copyWith(
                      color: Styles.kTextColor, height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ] else ...[

                if(this.widget.isMMb) ... [
                  Text(
                    "A problem occured with your manage booking. Please contact our customer service to continue.".tr(),
                    style: kMediumRegular.copyWith(
                        color: Styles.kSubTextColor, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ] else ... [
                  Text(
                    "confirmationView.statusDefault".tr(),
                    style: kMediumRegular.copyWith(
                        color: Styles.kSubTextColor, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ],

              ],
              kVerticalSpacerSmall,

              if(widget.isMMb == true) ... [
                Text(
                  "${'confirmationView.bookingReference'.tr()}  ${widget.pnr}",
                  style: kHugeSemiBold.copyWith(color: Styles.kPrimaryColor),
                  textAlign: TextAlign.center,
                ),
              ] else ... [

                if(confirmationDetail.confirmationModel?.value?.flightBookings?.firstOrNull?.supplierBookingNo == null) ... [
                  Text(
                    "${'confirmationView.bookingReference'.tr()} :  ${widget.pnr}",
                    style: kHugeSemiBold.copyWith(color: Styles.kPrimaryColor),
                    textAlign: TextAlign.center,
                  ),

                ] else ... [
                  Text(
                    "${'confirmationView.bookingReference'.tr()} :  ${confirmationDetail.confirmationModel?.value?.flightBookings?.firstOrNull?.supplierBookingNo}",
                    style: kHugeSemiBold.copyWith(color: Styles.kPrimaryColor),
                    textAlign: TextAlign.center,
                  ),
                ],


              ],

              kVerticalSpacer,
              if(widget.isMMb == true) ... [
                if(isPendingStatus() == true) ... [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: PaymentInfo(showPending: true,isMMB: true,forcePending: true,),
                  ),
                ],
              ],
              if (widget.isMMb == true) ...[
                if(isPendingStatus())  ... [
                  widget.summaryToShow!,
                  kVerticalSpacer,
                ] else ... [

                  SizedBox(height: MediaQuery.of(context).size.height/1.7,),
                ],


                ElevatedButton(
                  onPressed: () {
                    context.router.replaceAll([const NavigationRoute()]);
                  },
                  child: Text("backToMmb".tr()),
                ),
              ] else ...[
                AppCard(
                  child: Column(
                    children: const [
                      //const PaymentInfo(),
                      PassengersWidget(),
                    ],
                  ),
                ),
              ],
              kVerticalSpacer,
              const SummaryWidget(),
              kVerticalSpacer,

              if(widget.isMMb == true) ... [

              ] else ... [
                AppCard(
                  child: Column(
                    children: [
                      //1 == 1 ? Container() :
                      const ConfirmationPromo(),
                      // kVerticalSpacerSmall,
                      // const AppDividerWidget(),
                      // kVerticalSpacerSmall,
                      Row(
                        children: [
                          Text("flightCharge.total".tr(), style: kGiantHeavy),
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
                            currency: currencyToShow,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                kVerticalSpacer,
                kVerticalSpacerSmall,
                const PaymentInfo(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: FloatingActionButton(
                      onPressed: () {
                        _controllerSroll.animateTo(
                          _controllerSroll.position.minScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      backgroundColor: Styles.kPrimaryColor,
                      child: const Icon(Icons.keyboard_arrow_up),
                    ),
                  ),
                ),
                kVerticalSpacer,
                OutlinedButton(
                  onPressed: isLoading ? null : onShare,
                  child: isLoading
                      ? const AppLoading(
                    size: 20,
                  )
                      : Text("flightChange.share".tr()),
                ),
                kVerticalSpacerSmall,
                ElevatedButton(
                  onPressed: () {
                    context.router.replaceAll([const NavigationRoute()]);
                  },
                  child: Text("backHome".tr()),
                ),
              ],


            ],
          ),
        ),
      ),
    );
  }
}
