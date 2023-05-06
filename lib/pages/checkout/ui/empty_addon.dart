import 'package:app/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class EmptyAddon extends StatelessWidget {
  const EmptyAddon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 100),
        child: Text(
          'addOnNotAvailable'.tr(),
          style: k18Heavy,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
