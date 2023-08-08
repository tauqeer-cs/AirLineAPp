import 'package:flutter/material.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';

class DoubleLineTextTable extends StatelessWidget {
  final String label;
  final String value;

  const DoubleLineTextTable({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Styles.kBorderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: kTinyRegular.copyWith(
              color: Styles.kTextColor,
            ),
          ),
          const SizedBox(height: 2,),
          Text(
            value,
            style: kMediumMedium.copyWith(
              color: Styles.kTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
