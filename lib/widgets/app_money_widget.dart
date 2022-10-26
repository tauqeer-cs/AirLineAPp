import 'package:app/theme/theme.dart';
import 'package:app/theme/typography.dart';
import 'package:app/utils/number_utils.dart';
import 'package:flutter/material.dart';

class MoneyWidget extends StatelessWidget {
  final num? amount;
  final bool isDense;
  final String? currency;

  const MoneyWidget({
    Key? key,
    this.amount,
    this.isDense = true,
    this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isDense ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Text(
          "${currency ?? 'MYR'} ",
          style: kMediumHeavy.copyWith(
            height: 1.5,
            fontSize: isDense ? 10 : 14
          ),
        ),
        kHorizontalSpacerMini,
        Text(
          "${NumberUtils.formatNumber(amount?.toDouble())}",
          style:kHeaderHeavy.copyWith(fontSize: isDense ? 20 : 28),
        ),
      ],
    );
  }
}
