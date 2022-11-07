import 'package:app/theme/theme.dart';
import 'package:app/utils/number_utils.dart';
import 'package:flutter/material.dart';

class MoneyWidget extends StatelessWidget {
  final num? amount;
  final bool isDense;
  final String? currency;
  final bool isNegative;

  const MoneyWidget({
    Key? key,
    this.amount,
    this.isDense = true,
    this.currency,  this.isNegative = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          isDense ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Text(
          "${isNegative ? "- " :""}${currency ?? 'MYR'} ",
          style:
              kMediumHeavy.copyWith(height: 1.5, fontSize: isDense ? 10 : 14),
        ),
        kHorizontalSpacerMini,
        Text(
          NumberUtils.formatNumber(amount?.toDouble()),
          style: kHeaderHeavy.copyWith(fontSize: isDense ? 20 : 28),
        ),
      ],
    );
  }
}

class MoneyWidgetSmall extends StatelessWidget {
  final num? amount;
  final bool isDense;
  final String? currency;
  final bool isNegative;

  const MoneyWidgetSmall({
    Key? key,
    this.amount,
    this.isDense = true,
    this.currency,  this.isNegative = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          isDense ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Text(
          "${isNegative ? "- " :""}${currency ?? 'MYR'} ",
          style: kMediumRegular.copyWith(
            fontSize: isDense ? 12 : 14,
            color: Styles.kSubTextColor,
          ),
        ),
        kHorizontalSpacerMini,
        Text(
          NumberUtils.formatNumber(amount?.toDouble()),
          style: kMediumRegular.copyWith(
            fontSize: isDense ? 12 : 14,
            color: Styles.kSubTextColor,
          ),
        ),
      ],
    );
  }
}
