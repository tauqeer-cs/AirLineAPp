import 'package:app/theme/styles.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/forms/app_dropdown.dart';
import 'package:flutter/material.dart';

class SortButton extends StatelessWidget {
  const SortButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.filter_alt_rounded, color: Styles.kBorderColor, size: 25),
        Text(
          "Sort by",
          style: kSmallRegular.copyWith(color: Styles.kBorderColor),
        ),
        AppDropDown(items: [])
      ],
    );
  }
}
