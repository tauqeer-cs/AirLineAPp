import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/blocs/voucher/voucher_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/card_summary.dart';
import 'package:app/pages/checkout/pages/payment/bloc/payment_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/discount_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/passenger_card.dart';
import 'package:app/pages/checkout/pages/payment/ui/payment_header.dart';
import 'package:app/pages/checkout/pages/payment/ui/reward_and_discount.dart';
import 'package:app/pages/checkout/ui/booking_details_header.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/widgets/app_booking_header.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../theme/theme.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[
      Padding(
        padding: kPageHorizontalPadding,
        child: Column(
          children: [
            kVerticalSpacer,
            PassengerCard(),
            kVerticalSpacer,
            CardSummary(showFees: true),
          ],
        ),
      ),
      kVerticalSpacer,
      RewardAndDiscount(),
      kVerticalSpacer,
      DiscountSummary(),
      SummaryContainer(
        child: Padding(
          padding: kPageHorizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              kVerticalSpacer,
              BookingSummary(),
              kVerticalSpacer,
              ElevatedButton(
                onPressed: () => onBook(context),
                child: Text("Continue"),
              ),
              kVerticalSpacer,
            ],
          ),
        ),
      ),
    ];
    return ListView.builder(
      itemBuilder: (context, index) => widgets[index],
      itemCount: widgets.length,
    );
  }

  onBook(BuildContext context) {
    final bookingState = context.read<BookingCubit>().state;
    final filterState = context.read<SearchFlightCubit>().state.filterState;
    final voucher = context.read<VoucherCubit>().state.appliedVoucher;
    final token = bookingState.verifyResponse?.token;
    final pnrRequest = bookingState.summaryRequest?.flightSummaryPNRRequest;
    context.read<PaymentCubit>().pay(
          flightSummaryPnrRequest: pnrRequest,
          token: token,
          total: bookingState.getFinalPrice +
              (filterState?.numberPerson.getTotal() ?? 0),
          totalNeedPaid: bookingState.getFinalPrice +
              (filterState?.numberPerson.getTotal() ?? 0),
          promoCode: voucher,
        );
  }
}
