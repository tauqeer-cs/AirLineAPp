import 'package:app/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class EmptyAddon extends StatelessWidget {

  final String? icon;
  final String? customText;

  final double? verticalSpace;

  const EmptyAddon({Key? key, this.icon, this.customText, this.verticalSpace}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child:
      icon != null ? Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.0, vertical: verticalSpace ?? 60),
        child: Column(
          children: [

            if(verticalSpace != null) ... [
            ] else ... [
              SizedBox(height: MediaQuery.of(context).size.height/8,),
            ],


            Image.asset("assets/images/icons/icoNoInsurance.png",width: 60,height: 60,),
            kVerticalSpacerSmall,
            Text(
                customText ?? 'addOnNotAvailable'.tr(),
              style: kHugeHeavy,
              textAlign: TextAlign.center,
            ),
            if(verticalSpace != null) ... [
              SizedBox(height: 24,),
            ] else ... [

            ],

          ],
        ),
      ) :
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 100),
        child: Text(
          customText ?? 'addOnNotAvailable'.tr(),
          style: k18Heavy,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
