import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:screenshot/screenshot.dart';

import '../../../app/app_router.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../utils/security_utils.dart';
import '../../../widgets/app_loading_screen.dart';
import '../bloc/check_in_cubit.dart';
import '../check_in_error_page.dart';

class DgnInfoView extends StatefulWidget {
  final Function(bool) valueChanged;

  const DgnInfoView({Key? key, required this.valueChanged}) : super(key: key);

  @override
  State<DgnInfoView> createState() => _DgnInfoViewState();
}

class _DgnInfoViewState extends State<DgnInfoView> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Styles.kTextColor;
    }
    return Styles.kPrimaryColor;
  }

  bool checked = false;

  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<CheckInCubit>();

    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'importantInformation'.tr(),
            textAlign: TextAlign.center,
            style: kGiantHeavy.copyWith(color: Styles.kTextColor),
          ),
          Expanded(
            child: Container(),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.close),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                'checkInfoOne'.tr(),
                style: kSmallRegular.copyWith(color: Styles.kTextColor),
              ),
            ),
            kVerticalSpacerSmall,
            kVerticalSpacerMini,
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: buildRow(
                  'iconBoarding', 'boarding'.tr(), 'checkInBoardingInfo'.tr()),
            ),
            kVerticalSpacer,
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: buildRow(
                  'iconCovid', 'covid19'.tr(), 'checkInCovid19Info'.tr()),
            ),
            kVerticalSpacer,
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: buildRow('iconCheckIn', 'check_in_caps'.tr(),
                  'checkInCheckInInfo'.tr()),
            ),
            kVerticalSpacer,
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: buildRow('iconDocuments', 'travelDocuments'.tr(),
                  'checkInTravelDocumentsInfo'.tr()),
            ),
            kVerticalSpacer,
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: buildRow('iconBaggage', 'baggage'.tr(),
                  'checkInBaggageInfo'.tr()),
            ),
            kVerticalSpacer,
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: buildRow('iconProhibited', 'prohibitedItems'.tr(),
                  'checkInProhibitedItemsInfo'.tr()),
            ),
            kVerticalSpacer,
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: buildRow(
                  'iconInfoSystem', 'apisTitle'.tr(), 'checkInApisInfo'.tr()),
            ),
            kVerticalSpacer,
            buildDoubleRow('iconFlamable', 'shareObjWeapons'.tr(), 'iconBlunt',
                'explosives'.tr()),
            kVerticalSpacer,
            buildDoubleRow('iconKnife', 'flammableSubstances'.tr(), 'iconKnife',
                'bluntObjects'.tr()),
            kVerticalSpacer,
            buildDoubleRow('iconMeals', 'selfHeating'.tr(), 'iconBioHazard',
                'biohazards'.tr()),
            kVerticalSpacer,
            buildDoubleRow('iconCorrosive', 'chemicals'.tr(), 'iconGas',
                'compressed'.tr()),
            kVerticalSpacer,
            buildDoubleRow('iconBattery', 'batteries'.tr(), 'iconFirearm',
                'firearms'.tr()),
            kVerticalSpacer,
            buildDoubleRow('iconFirearm', 'livePlants'.tr(),
                'iconDisablingDevice', 'disablingDevices'.tr()),
            kVerticalSpacer,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.resolveWith(getColor),
                  value: checked,
                  onChanged: (bool? value) {
                    setState(() {
                      checked = value ?? false;
                    });
                    },
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'checkInTerms'.tr(),
                          style:
                              kMediumRegular.copyWith(color: Styles.kTextColor),
                        ),

                        //
                        TextSpan(
                          text: 'checkInTermsFAQ'.tr(),
                          style: kMediumSemiBold.copyWith(
                            color: Styles.kLinkColor,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // add your navigation or on tap logic here
                              SecurityUtils.tryLaunch(
                                  'https://www.myairline.my/faq');

                              /*

                              * */
                            },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            kVerticalSpacer,
            if (bloc.state.checkingInFlight == true) ...[
              const AppLoading(),
            ] else ...[
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        }, //isLoading ? null :
                        child: Text(
                          'back'.tr(),
                        ),
                      ),
                    ),
                    kHorizontalSpacerSmall,
                    Expanded(
                      child: ElevatedButton(
                        onPressed: checked == false
                            ? null
                            : () async {
                                if (checked) {
                                  var check = await bloc.checkInFlight();
                                  if (check == true) {
                                    context.router.replaceAll([
                                      const NavigationRoute(),
                                      const CheckInBoardingPassRoute(),
                                    ]);
                                  } else {
                                    if (bloc.showPassport) {
                                      context.router.replaceAll([
                                        const NavigationRoute(),
                                        const CheckInErrorRoute(),
                                      ]);
                                    }
                                  }
                                }
                              },
                        child:  Text('continue'.tr()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Row buildDoubleRow(
      String imageOne, String textOne, String imageTwo, String textTwo) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Image.asset(
                "assets/images/icons/$imageOne.png",
                width: 44,
                height: 44,
              ),
              kHorizontalSpacerSmall,
              Text(
                textOne,
                style: kSmallMedium.copyWith(color: Styles.kSubTextColor),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Image.asset(
                "assets/images/icons/$imageTwo.png",
                width: 44,
                height: 44,
              ),
              kHorizontalSpacerSmall,
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  textTwo,
                  style: kSmallMedium.copyWith(color: Styles.kSubTextColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row buildRow(String iconName, String title, String detail) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          "assets/images/icons/$iconName.png",
          width: 40,
          height: 40,
        ),
        kHorizontalSpacerSmall,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: kMediumHeavy.copyWith(color: Styles.kTextColor),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                detail,
                style: kSmallRegular.copyWith(color: Styles.kTextColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
