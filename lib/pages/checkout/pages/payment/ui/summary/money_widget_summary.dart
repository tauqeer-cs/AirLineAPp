import 'package:app/theme/theme.dart';
import 'package:app/utils/number_utils.dart';
import 'package:flutter/material.dart';

class MoneyWidgetSummary extends StatelessWidget {
  final num? amount;
  final String? currency;
  final bool isNegative, isDense;
  final bool isSports;

  const MoneyWidgetSummary({
    Key? key,
    this.amount,
    this.currency,
    this.isNegative = false,
    this.isDense = false,  this.isSports = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:MainAxisAlignment.end,
      children: [
        Text(
          "${isNegative ? "- " : ""}${currency ?? 'MYR'} ",
          style: isDense ? kMediumRegular : k18Heavy,
        ),
        const SizedBox(width: 2),
        Flexible(
          child: Text(
            NumberUtils.formatNumber(amount?.toDouble()),
            style: isDense ? kMediumRegular : k18Heavy,
          ),
        ),
      ],
    );
  }
}

