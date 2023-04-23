import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/ui/cubit/is_payment_page_cubit.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../theme/theme.dart';
import 'baggage_fee_detail.dart';

class BaggageFee extends StatefulWidget {
  final bool isDeparture;

  final bool isSports;

  final bool isInsurance;

  const BaggageFee(
      {Key? key,
      required this.isDeparture,
      this.isSports = false,
      this.isInsurance = false})
      : super(key: key);

  @override
  State<BaggageFee> createState() => _BaggageFeeState();
}

class _BaggageFeeState extends State<BaggageFee> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final isPaymentPage = context.watch<IsPaymentPageCubit>().state;

    return Column(
      children: [
        kVerticalSpacer,
        InkWell(
          onTap: () {
            setState(() {
              isExpand = !isExpand;
            });
          },
          child: Row(
            children: [
              Text(
                setText(isPaymentPage),
                style: kMediumHeavy,
              ),
              const Spacer(),
              MoneyWidgetCustom(
                fontWeight: FontWeight.w700,
                amount: widget.isSports
                    ? filter?.numberPerson
                        .getTotalSportsPartial(widget.isDeparture)
                    : widget.isInsurance
                        ? filter?.numberPerson.getTotalInsurance()
                        : filter?.numberPerson
                            .getTotalBaggagePartial(widget.isDeparture),
              ),
            ],
          ),
        ),
        ExpandedSection(
          expand: isExpand,
          child: BaggageFeeDetail(
            isDeparture: widget.isDeparture,
            isSports: widget.isSports,
            isInsurance: widget.isInsurance,
          ),
        ),
      ],
    );
  }

  String setText(bool isPaymentPage) {
    if (widget.isSports) {
      return 'Sports Equipment';
    } else if (widget.isInsurance) {
      return 'insurance'.tr();
    }
    // return widget.isSports ? (isPaymentPage ? "Sports Equipment" : "- Sports Equipment") : (isPaymentPage ? "Baggage" : "- Baggage");
    return "baggage".tr();
  }
}
