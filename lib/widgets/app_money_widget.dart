import 'package:app/theme/theme.dart';
import 'package:app/utils/number_utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MoneyWidget extends StatelessWidget {
  final num? amount;
  final bool isDense, isNormalMYR;
  final String? currency;
  final bool isNegative;

  final bool showPlus;

  const MoneyWidget({
    Key? key,
    this.amount,
    this.isDense = true,
    this.currency,
    this.showPlus = false,
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
          "${isNegative ? "- " : ""}${showPlus ? "+ " : ""}${currency ?? 'MYR'} ",
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
          child: AutoSizeText(
            NumberUtils.formatNumber(amount?.toDouble()),
            style: kHeaderHeavy.copyWith(fontSize: isDense ? 20 : 28),
            textAlign: TextAlign.end,
            maxLines: 1,
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
        AutoSizeText(
          NumberUtils.formatNumber(amount?.toDouble()),
          style: kMediumRegular.copyWith(
            fontSize: isDense ? 12 : 14,
          ),
          maxLines: 1,
        ),
      ],
    );
  }
}

class MoneyWidgetCustom extends StatelessWidget {
  final num? amount;
  final String? currency;
  final bool isNegative;
  final double? myrSize, amountSize;
  final Color? textColor;
  final MainAxisAlignment? mainAxisAlignment;
  final FontWeight? fontWeight;
  const MoneyWidgetCustom({
    Key? key,
    this.amount,
    this.currency,
    this.isNegative = false, this.myrSize, this.amountSize, this.textColor, this.fontWeight, this.mainAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${isNegative ? "- " : ""}${currency ?? 'MYR'} ",
          style: kMediumRegular.copyWith(
            fontSize: myrSize ?? 14,
            color: textColor,
              fontWeight: fontWeight
          ),
        ),
        kHorizontalSpacerMini,
        AutoSizeText(
          NumberUtils.formatNumber(amount?.toDouble()),
          style: kMediumRegular.copyWith(
            fontSize: myrSize ?? 14,
            color: textColor,
            fontWeight: fontWeight
          ),
          maxLines: 1,
        ),
      ],
    );
  }
}