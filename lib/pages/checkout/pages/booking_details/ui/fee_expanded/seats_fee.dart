import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/ui/cubit/is_payment_page_cubit.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../theme/theme.dart';
import 'seats_fee_detail.dart';

class SeatsFee extends StatefulWidget {
  final bool isDeparture;

  const SeatsFee({Key? key, required this.isDeparture}) : super(key: key);

  @override
  State<SeatsFee> createState() => _SeatsFeeState();
}

class _SeatsFeeState extends State<SeatsFee> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final isPaymentPage = context.watch<IsPaymentPageCubit>().state;

    return Column(
      children: [
        kVerticalSpacer,
        Row(
          children: [
            Text(
              isPaymentPage ? "priceSection.seats".tr() : "- ${'priceSection.seats'.tr()}",
              style: kMediumHeavy,
            ),
            kHorizontalSpacerSmall,
            Spacer(),
            MoneyWidgetCustom(
              fontWeight: FontWeight.w700,
              amount:
                  filter?.numberPerson.getTotalSeatsPartial(widget.isDeparture),
            ),
          ],
        ),
        SeatsFeeDetail(isDeparture: widget.isDeparture),
      ],
    );
  }
}
