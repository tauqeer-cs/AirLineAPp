import 'package:app/theme/theme.dart';
import 'package:app/theme/typography.dart';
import 'package:app/utils/number_utils.dart';
import 'package:flutter/material.dart';

class MoneyWidget extends StatelessWidget {
  final num? amount;
  final bool isDense;
  const MoneyWidget({
    Key? key,
    this.amount,
    this.isDense = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "MYR ${NumberUtils.formatNumber(amount?.toDouble())}",
      style: isDense ? kSmallSemiBold:kLargeSemiBold.copyWith(
        color: Styles.kPrimaryColor,
      ),
    );
  }
}
