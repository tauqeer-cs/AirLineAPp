import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/blocs/voucher/voucher_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/card_summary.dart';
import 'package:app/pages/checkout/pages/payment/bloc/payment_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/discount_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/passenger_card.dart';
import 'package:app/pages/checkout/pages/payment/ui/reward_and_discount.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../theme/theme.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({Key? key}) : super(key: key);

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

    final widgets = <Widget>[
      Padding(
        padding: kPageHorizontalPadding,
        child: Column(
          children: [
            kVerticalSpacer,
            const PassengerCard(),
            kVerticalSpacer,
            const CardSummary(showFees: true),
          ],
        ),
      ),
      kVerticalSpacer,
      RewardAndDiscount(

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
              const BookingSummary(),
              kVerticalSpacer,
              ElevatedButton(
                onPressed: () => onBook(context),
                child: const Text("Continue"),
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
