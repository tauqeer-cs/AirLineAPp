import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/ui/cubit/is_payment_page_cubit.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../theme/theme.dart';
import 'wheelchair_fee_detail.dart';

class WheelChairFee extends StatefulWidget {
  final bool isDeparture;

  const WheelChairFee({
    Key? key,
    required this.isDeparture,
  }) : super(key: key);

  @override
  State<WheelChairFee> createState() => _WheelChairFeeState();
}

class _WheelChairFeeState extends State<WheelChairFee> {
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
              "wheelChairLabel".tr(),
              style: kMediumHeavy,
            ),
            kHorizontalSpacerSmall,
            const Spacer(),
            MoneyWidgetCustom(
              fontWeight: FontWeight.w700,
              amount:filter?.numberPerson
                  .getTotalWheelChairPartial(widget.isDeparture),
            ),
          ],
        ),
        ExpandedSection(
          expand: isExpand,
          child: WheelChairFeeDetail(
            isDeparture: widget.isDeparture,
          ),
        ),
      ],
    );
  }

}
