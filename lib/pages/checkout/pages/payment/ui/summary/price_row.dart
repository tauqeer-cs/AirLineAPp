import 'package:flutter/material.dart';

class PriceRow extends StatelessWidget {
  final Widget child1, child2;

  const PriceRow({Key? key, required this.child1, required this.child2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: child1,
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(
            width: 10,
          ),
        ),
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.centerRight,
            child: child2,
          ),
        ),
      ],
    );
  }
}
