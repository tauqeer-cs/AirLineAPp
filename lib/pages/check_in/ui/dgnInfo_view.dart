import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
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

  EdgeInsets get paddingForTop {
    return const EdgeInsets.only(left: 28, right: 16);
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<CheckInCubit>();

    double width = MediaQuery.of(context).size.width / 19;

    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      contentPadding: EdgeInsets.zero,
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
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'checkInfoOne'.tr(),
                style: kSmallRegular.copyWith(color: Styles.kTextColor),
              ),
            ),
            kVerticalSpacerSmall,
            kVerticalSpacerMini,
            Padding(
              padding: paddingForTop,
              child: buildRow(
                  'iconBoarding', 'boarding'.tr(), 'checkInBoardingInfo'.tr()),
            ),
            kVerticalSpacer,
            Padding(
              padding: paddingForTop,
              child: buildRow(
                  'iconCovid', 'covid19'.tr(), 'checkInCovid19Info'.tr()),
            ),
            kVerticalSpacer,
            Padding(
              padding: paddingForTop,
              child: buildRow('iconCheckIn', 'check_in_caps'.tr(),
                  'checkInCheckInInfo'.tr()),
            ),
            kVerticalSpacer,
            Padding(
              padding: paddingForTop,
              child: buildRow('iconDocuments', 'travelDocuments'.tr(),
                  'checkInTravelDocumentsInfo'.tr()),
            ),
            kVerticalSpacer,
            Padding(
              padding: paddingForTop,
              child: buildRow(
                  'iconBaggage', 'baggageCap'.tr(), 'checkInBaggageInfo'.tr()),
            ),
            kVerticalSpacer,
            Padding(
              padding: paddingForTop,
              child: buildRow('iconProhibited', 'prohibitedItems'.tr(),
                  'checkInProhibitedItemsInfo'.tr()),
            ),
            kVerticalSpacer,
            Padding(
              padding: paddingForTop,
              child: buildRow(
                  'iconInfoSystem', 'apisTitle'.tr(), 'checkInApisInfo'.tr()),
            ),
            kVerticalSpacer,
            if (true) ...[
              Container(
                color: Styles.greyLineColor,
                width: double.infinity,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      style:  TextStyle(
                        color: Colors.white,
                        fontSize: width ,
                        fontWeight: FontWeight.w900,
                      ),
                      children: [
                        TextSpan(
                          text: 'dangerourGoodAre'.tr(),
                        ),
                        TextSpan(
                          text: 'not'.tr(),
                          style: TextStyle(
                            backgroundColor: Styles.kPrimaryColor,
                          ),
                        ),
                        TextSpan(
                          text: 'takenIntoCabin'.tr(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              kVerticalSpacer,
              buildDoubleRow('iconKnife', 'shareObjWeapons'.tr(),
                  'iconExplosives', 'explosives'.tr()),
              kVerticalSpacer,
              buildDoubleRow('iconFlamable', 'flammableSubstances'.tr(),
                  'iconBlunt', 'bluntObjects'.tr()),
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
              buildDoubleRow('iconPlants', 'livePlants'.tr(),
                  'iconDisablingDevice', 'disablingDevices'.tr()),
              kVerticalSpacer,
            ],
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: checked,
                    onChanged: (bool? value) {
                      setState(() {
                        checked = value ?? false;
                      });
                    },
                  ),
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
                ),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
            kVerticalSpacer,
            if (bloc.state.checkingInFlight == true) ...[
              const AppLoading(),
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
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
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Styles.kActiveColor.withOpacity(0.5);
                                } else if (states
                                    .contains(MaterialState.disabled)) {
                                  return Color.fromRGBO(
                                      169, 169, 169, 1.0); //rgb(37, 150, 190)

                                }
                                return Styles
                                    .kPrimaryColor; // Use the component's default./ Use the component's default.
                              },
                            ),
                          ),
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
                          child: Text('continue'.tr()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDoubleRow(
      String imageOne, String textOne, String imageTwo, String textTwo) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 12),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Image.asset(
                  "assets/images/icons/$imageOne.png",
                  width: 56,
                  height: 56,
                ),
                kHorizontalSpacerSmall,
                Text(
                  textOne,
                  style: kTinySemiBold.copyWith(color: Styles.kSubTextColor),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Image.asset(
                  "assets/images/icons/$imageTwo.png",
                  width: 56,
                  height: 56,
                ),
                kHorizontalSpacerSmall,
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    textTwo,
                    style: kTinySemiBold.copyWith(color: Styles.kSubTextColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
