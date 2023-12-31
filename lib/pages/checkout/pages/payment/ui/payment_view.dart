import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/blocs/voucher/voucher_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/bloc/summary_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/card_summary.dart';
import 'package:app/pages/checkout/pages/payment/bloc/payment_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/discount_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/passenger_card.dart';
import 'package:app/pages/checkout/pages/payment/ui/reward_and_discount.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

import '../../../../../app/app_router.dart';
import '../../../../../blocs/timer/timer_bloc.dart';
import '../../../../../data/requests/flight_summary_pnr_request.dart';
import '../../../../../theme/theme.dart';
import '../../../../../widgets/dialogs/app_confirmation_dialog.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({Key? key, required this.promoReady}) : super(key: key);
  final bool promoReady;

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final summaryResponse = context.watch<SummaryCubit>().state.summaryResponse;
    final voucherState = context.watch<VoucherCubit>().state;

    num? discount = voucherState.response?.addVoucherResult?.voucherDiscounts?.firstOrNull?.discountAmount;
    num? redeemAmount = context.watch<VoucherCubit>().state.selectedRedeemOption?.redemptionAmount;
    final bookinbBloc = context.read<BookingCubit>();

    final widgets = <Widget>[
      Padding(
        padding: kPageHorizontalPadding,
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kVerticalSpacer,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "summaryPayment".tr() ,
                style: kHugeHeavy,
              ),
            ),
            kVerticalSpacerSmall,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'paymentView.paymentDesc'.tr(),
                style: kMediumRegular,
              ),
            ),
            kVerticalSpacer,
            const PassengerCard(),
            kVerticalSpacer,
            const CardSummary(showFees: true),
          ],
        ),
      ),
      kVerticalSpacer,
      RewardAndDiscount(
        promoReady: widget.promoReady,
      ),
      kVerticalSpacer,
       DiscountSummary(princToShow: summaryResponse
           ?.flightSummaryPnrResult?.summaryAmount
           ?.toDouble() ?? 0.0,),
      SummaryContainer(
        overrideExpand: true,
        child: Padding(
          padding: kPageHorizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              kVerticalSpacer,
              BookingSummary(
                totalAmountToShow: (summaryResponse
                        ?.flightSummaryPnrResult?.summaryAmount
                        ?.toDouble() ??
                    0) - (discount?.toDouble() ?? 0) -  (redeemAmount?.toDouble() ?? 0),
              ),
              kVerticalSpacer,
              ElevatedButton(
                onPressed: () => onBook(context),
                child: Text("continue".tr()),
              ),
              kVerticalSpacer,
            ],
          ),
        ),
      ),
    ];
    return ListView.builder(
      key: const PageStorageKey<String>('controllerA'),
      itemBuilder: (context, index) => widgets[index],
      itemCount: widgets.length,
    );
  }

  onBook(BuildContext context) {
    final bookingState = context.read<BookingCubit>().state;
    final filterState = context.read<SearchFlightCubit>().state.filterState;
    final summaryResponse = context.read<SummaryCubit>().state.summaryResponse;

    final voucher = context.read<VoucherCubit>().state.appliedVoucher;
    final token = bookingState.verifyResponse?.token;
    final pnrRequest = bookingState.summaryRequest?.flightSummaryPNRRequest;

    /*
    for(Passenger currentItem in pnrRequest?.passengers ?? [] ) {

      if((currentItem.ssr?.outbound ?? []).isNotEmpty ) {

        var itemBoSelect = (currentItem.ssr?.outbound ?? []).where((e) => e.ssrCode == 'NOSELECT').toList();


        if(itemBoSelect.isNotEmpty) {
          (currentItem.ssr?.outbound ?? []).removeWhere((e) => e.ssrCode == 'NOSELECT');
        }
        //Bound(null, NOSELECT, BAGGAGE, 1, 0, no baggage)
        print('object');
      }

      if((currentItem.ssr?.inbound ?? []).isNotEmpty ) {
        print('object');
      }
    }*/



    String? redeemCodeToSend;

    if (context.read<VoucherCubit>().state.selectedRedeemOption != null) {
      redeemCodeToSend = context
          .read<VoucherCubit>()
          .state
          .selectedRedeemOption!
          .redemptionName!;
    }
    context.read<PaymentCubit>().payDo(
        flightSummaryPnrRequest: pnrRequest,
        token: token,
        total: summaryResponse?.flightSummaryPnrResult?.summaryAmount ?? 0,
        totalNeedPaid:
            summaryResponse?.flightSummaryPnrResult?.summaryAmount ?? 0,
        promoCode: voucher,
        redeemCodeToSend: redeemCodeToSend, errEction: (String error) {

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => true,
            child: AppConfirmationDialog(
              showCloseButton: false,
              title: error,
              subtitle: "",
              onConfirm: () {

                context.router.replaceAll([const NavigationRoute()]);
                context.read<TimerBloc>().add(const TimerReset());

              },
              confirmText: "okay".tr(),
            ),
          );
        },
      );


    },
    );
  }
}
