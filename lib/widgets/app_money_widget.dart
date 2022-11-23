import 'package:app/theme/theme.dart';
import 'package:app/utils/number_utils.dart';
import 'package:flutter/material.dart';

class MoneyWidget extends StatelessWidget {
  final num? amount;
  final bool isDense, isNormalMYR;
  final String? currency;
  final bool isNegative;

  const MoneyWidget({
    Key? key,
    this.amount,
    this.isDense = true,
    this.currency,
    this.isNegative = false,
    this.isNormalMYR = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          isDense ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Text(
          "${isNegative ? "- " : ""}${currency ?? 'MYR'} ",
          style: kMediumHeavy.copyWith(
            height: isNormalMYR ? null : 1.5,
            fontSize: isDense
                ? isNormalMYR
                    ? 20
                    : 10
                : isNormalMYR
                    ? 28
                    : 14,
          ),
        ),
        SizedBox(width: isNormalMYR ? 0 : 5),
        Flexible(
          child: Text(
            NumberUtils.formatNumber(amount?.toDouble()),
            style: kHeaderHeavy.copyWith(fontSize: isDense ? 20 : 28),
            textAlign: TextAlign.end,
          ),
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
    this.currency,
    this.isNegative = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          isDense ? MainAxisAlignment.end : MainAxisAlignment.end,
      children: [
        Text(
          "${isNegative ? "- " : ""}${currency ?? 'MYR'} ",
          style: kMediumRegular.copyWith(
            fontSize: isDense ? 12 : 14,
          ),
        ),
        kHorizontalSpacerMini,
        Text(
          NumberUtils.formatNumber(amount?.toDouble()),
          style: kMediumRegular.copyWith(
            fontSize: isDense ? 12 : 14,
          ),
        ),
      ],
    );
  }
}
