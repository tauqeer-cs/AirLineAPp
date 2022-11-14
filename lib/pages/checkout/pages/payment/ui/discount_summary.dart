import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/blocs/voucher/voucher_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class DiscountSummary extends StatelessWidget {
  const DiscountSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingCubit>().state;
    final filterState = context.watch<SearchFlightCubit>().state.filterState;
    final voucherState = context.watch<VoucherCubit>().state;
    final discount = voucherState.response?.addVoucherResult?.voucherDiscounts?.firstOrNull?.discountAmount ?? 0;

    return Visibility(
      visible: discount!=0,
      child: Transform.translate(
        offset: const Offset(0,20),
        child: Container(
          color: Styles.kDividerColor,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.only(top: 10,bottom: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Subtotal", style: kMediumRegular.copyWith(color: Styles.kSubTextColor),),
                  const Spacer(),
                  MoneyWidgetSmall(
                    isDense: false,
                    amount: booking.getFinalPriceDisplay +
                        (filterState?.numberPerson.getTotal() ?? 0),
                  ),
                ],
              ),
              kVerticalSpacerSmall,
              Row(
                children: [
                  Text("Voucher", style: kMediumRegular.copyWith(color: Styles.kSubTextColor),),
                  const Spacer(),
                  MoneyWidgetSmall(
                    isDense: false,
                    amount: discount,
                    isNegative: true,
                  ),
                ],
              ),
              kVerticalSpacerSmall,
            ],
          ),
        ),
      ),
    );
  }
}
