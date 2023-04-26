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
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../theme/theme.dart';

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
                "Summary & Payment",
                style: kHugeHeavy,
              ),
            ),
            kVerticalSpacerSmall,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Fill in all passengers’ names as per passport. Your entry may be denied if your passport’s expiry date is within several months of your travel period - please check your passport’s expiry date.",
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
      const DiscountSummary(),
      SummaryContainer(
        overrideExpand: true,
        child: Padding(
          padding: kPageHorizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              kVerticalSpacer,
              BookingSummary(
                totalAmountToShow: summaryResponse
                        ?.flightSummaryPnrResult?.summaryAmount
                        ?.toDouble() ??
                    0,
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

    String? redeemCodeToSend;

    if (context.read<VoucherCubit>().state.selectedRedeemOption != null) {
      redeemCodeToSend = context
          .read<VoucherCubit>()
          .state
          .selectedRedeemOption!
          .redemptionName!;
    }
    context.read<PaymentCubit>().pay(
        flightSummaryPnrRequest: pnrRequest,
        token: token,
        total: summaryResponse?.flightSummaryPnrResult?.summaryAmount ?? 0,
        totalNeedPaid:
            summaryResponse?.flightSummaryPnrResult?.summaryAmount ?? 0,
        promoCode: voucher,
        redeemCodeToSend: redeemCodeToSend);
  }
}
