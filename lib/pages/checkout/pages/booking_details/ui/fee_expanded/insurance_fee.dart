import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/money_widget_summary.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/price_row.dart';
import 'package:app/pages/checkout/ui/cubit/is_payment_page_cubit.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../theme/theme.dart';
import 'fee_and_taxes_detail.dart';

class InsuranceFee extends StatefulWidget {
  const InsuranceFee({Key? key}) : super(key: key);

  @override
  State<InsuranceFee> createState() => _InsuranceFeeState();
}

class _InsuranceFeeState extends State<InsuranceFee> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final isPaymentPage = context.watch<IsPaymentPageCubit>().state;

    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isExpand = !isExpand;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  setText(isPaymentPage),
                  style: kMediumRegular,
                ),
                kHorizontalSpacerSmall,
                Icon(
                  isExpand
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
                const Spacer(),
                MoneyWidgetSmall(
                  amount: filter?.numberPerson.getTotalInsurance(),
                ),
              ],
            ),
          ),
        ),
        ExpandedSection(
          expand: isExpand,
          child: const InsuranceFeeDetail(),
        ),
      ],
    );
  }

  String setText(bool isPaymentPage) {
    return '- ${'insurance'.tr()}';
  }
}

class InsuranceFeeDetail extends StatelessWidget {
  const InsuranceFeeDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final persons = filter?.numberPerson.persons ?? [];
    return Column(
      children: [
        kVerticalSpacerSmall,
        AppDividerWidget(color: Styles.kDisabledButton),
        ...persons.map(
          (e) {
            final bundle = e.insuranceGroup;

            return bundle?.amount == null
                ? const SizedBox.shrink()
                : PriceContainer(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "${e.generateText(filter?.numberPerson)} :\n${bundle?.description ?? 'noBundle'.tr()}",
                                style: kSmallRegular.copyWith(
                                    color: Styles.kSubTextColor),
                              ),
                            ),
                            kHorizontalSpacerSmall,
                            MoneyWidgetSmall(
                                amount: bundle?.amount,
                                isDense: true,
                                currency: bundle?.currencyCode),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                bundle?.applicableTaxes?.first.taxDescription ??
                                    'taxes'.tr(),
                                style: kSmallRegular.copyWith(
                                    color: Styles.kSubTextColor),
                              ),
                            ),
                            kHorizontalSpacerSmall,
                            MoneyWidgetSmall(
                                amount:
                                    bundle?.applicableTaxes?.first.taxAmount ??
                                        0.0,
                                isDense: true,
                                currency: bundle?.currencyCode),
                          ],
                        ),
                      ],
                    ),
                  );
          },
        ).toList(),
      ],
    );
  }
}

class InsuranceFeeSummary extends StatelessWidget {
  const InsuranceFeeSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;

    return Column(
      children: [
        kVerticalSpacer,
        PriceRow(
          child1: Text("insurance".tr(), style: k18Heavy),
          child2: MoneyWidgetSummary(
            isDense: false,
            amount: filter?.numberPerson.getTotalInsurance(),
          ),
        ),
        const InsuranceFeeDtailsSummary(),
      ],
    );
  }
}

class InsuranceFeeDtailsSummary extends StatelessWidget {
  const InsuranceFeeDtailsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final persons = filter?.numberPerson.persons ?? [];
    final bookingState = context.watch<BookingCubit>().state;
    final pnrRequest = bookingState.summaryRequest?.flightSummaryPNRRequest;
    final passengers = pnrRequest?.passengers ?? [];
    return Column(
      children: [
        kVerticalSpacerSmall,
        ...persons.map(
          (e) {
            final passengersTypes = passengers
                .where((element) => element.paxType == e.peopleType?.code)
                .toList();
            if (passengersTypes.isEmpty || e.numberOrder == null) {
              return const SizedBox();
            }
            final passenger = passengersTypes.length > (e.numberOrder!.toInt())
                ? passengersTypes[e.numberOrder!.toInt()]
                : passengersTypes[0];
            final insurance = e.insuranceGroup;

            /*
            insurance?.isEmpty
                ? const SizedBox.shrink()
                :
            * */
            return insurance == null
                ? Container()
                : PriceRow(
                    child1: Text(
                      "${passenger.title} ${passenger.firstName}",
                      style: kMediumRegular,
                    ),
                    child2: MoneyWidgetSummary(
                      amount: insurance.finalAmount,
                      isDense: true,
                      currency: insurance.currencyCode,
                    ),
                  );
          },
        ).toList(),
      ],
    );
  }
}
