import 'package:app/theme/theme.dart';
import 'package:app/widgets/forms/app_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SortButton extends StatelessWidget {
  const SortButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.filter_alt_rounded, color: Styles.kBorderColor, size: 25),
        Text(
          "sortBy".tr(),
          style: kSmallRegular.copyWith(color: Styles.kBorderColor),
        ),
        const AppDropDown(items: [])
      ],
    );
  }
}
