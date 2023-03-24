import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/blocs/voucher/voucher_cubit.dart';
import 'package:app/pages/search_result/bloc/summary_container_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class BookingSummary extends StatelessWidget {
  final String? labelToShow;

  final bool isChangeFlight;

  final double? totalAmountToShow;

  const BookingSummary(
      {Key? key,
      this.labelToShow,
      this.totalAmountToShow,
      this.isChangeFlight = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currency = context.watch<SearchFlightCubit>().state.flights?.flightResult?.requestedCurrencyOfFareQuote ?? 'MYR';

    final filterState = context.watch<SearchFlightCubit>().state.filterState;
    final booking = context.watch<BookingCubit>().state;
    final voucherState = context.watch<VoucherCubit>().state;
    final discount = voucherState.response?.addVoucherResult?.voucherDiscounts
            ?.firstOrNull?.discountAmount ??
        0;

    int? redeemAmount = context
            .watch<VoucherCubit>()
            .state
            .selectedRedeemOption
            ?.redemptionAmount ??
        0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          labelToShow ?? "Your total booking",
          style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
        ),
        MoneyWidget(
          isDense: false,
          currency: currency,
          amount: totalAmountToShow ??
              booking.getFinalPriceDisplay +
                  (filterState?.numberPerson.getTotal() ?? 0) -
                  discount -
                  redeemAmount,
        ),
        kVerticalSpacer,
      ],
    );
  }
}

class SummaryContainer extends StatelessWidget {
  final Widget child;
  final bool? overrideExpand;

  const SummaryContainer({Key? key, required this.child, this.overrideExpand})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isExpand = context.watch<SummaryContainerCubit>().state;
    return ExpandedSection(
      expand: overrideExpand ?? isExpand,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, -2),
              blurRadius: 6,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
