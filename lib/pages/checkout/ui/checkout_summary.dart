import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/pages/checkout/ui/cubit/is_payment_page_cubit.dart';
import 'package:app/pages/checkout/ui/fee_and_taxes.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutSummary extends StatefulWidget {
  const CheckoutSummary({Key? key}) : super(key: key);

  @override
  State<CheckoutSummary> createState() => _CheckoutSummaryState();
}

class _CheckoutSummaryState extends State<CheckoutSummary> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingCubit>().state;

    return Visibility(
      visible: booking.isVerify,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isExpand = !isExpand;
                });
              },
              child: Padding(
                padding: kPageHorizontalPadding,
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Flights and bundles summary",
                        style: k18Heavy,
                        maxLines: 2,
                      ),
                    ),
                    Icon(
                      isExpand
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                  ],
                ),
              ),
            ),
            kVerticalSpacer,
            ExpandedSection(
              expand: isExpand,
              child: Container(
                padding: kPageHorizontalPadding,
                color: Styles.kDividerColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kVerticalSpacer,
                    BlocProvider(
                      create: (context) => IsPaymentPageCubit(false),
                      child: const FeeAndTaxes(isDeparture: true),
                    ),
                    Visibility(
                      visible: booking.selectedReturn != null,
                      child: BlocProvider(
                        create: (context) => IsPaymentPageCubit(false),
                        child: const FeeAndTaxes(isDeparture: false),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            kVerticalSpacer,
            Padding(
              padding: kPageHorizontalPadding,
              child: Text(
                "Fares are not guaranteed until payment is made in full and MYAirline confirms your booking.\n\nAircraft subject to change. ",
                style: kMediumRegular.copyWith(
                  color: Styles.kSubTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
