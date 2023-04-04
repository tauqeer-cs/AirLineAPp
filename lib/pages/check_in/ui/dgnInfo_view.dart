import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../../../app/app_router.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../utils/security_utils.dart';

class DgnInfoView extends StatelessWidget {
  const DgnInfoView({Key? key}) : super(key: key);
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

  @override
  Widget build(BuildContext context) {
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
            'Important Information',
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
                '''Please read the following key information and do your due diligence to ensure that you will be eligible to board the aircraft. Failure to comply with the requirements will lead to denial of boarding.''',
                style: kSmallRegular.copyWith(color: Styles.kTextColor),
              ),
            ),
            kVerticalSpacerSmall,
            kVerticalSpacerMini,
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: buildRow('iconBoarding', 'BOARDING',
                  '''Please be advised that the boarding gate closes 20 minutes prior to the scheduled departure.'''),
            ),
            kVerticalSpacer,
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: buildRow('iconCovid', 'COVID-19',
                  '''Please take note of the entry and health requirements to/from your intended destination.'''),
            ),
            kVerticalSpacer,
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: buildRow('iconCheckIn', 'CHECK-IN',
                  '''You may perform online check-in between 3 days to 1 hour before departure.'''),
            ),
            kVerticalSpacer,
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: buildRow('iconDocuments', 'TRAVEL DOCUMENTS',
                  '''Do ensure that your passport is valid and that you have all the relevant documents including visas, entry permits, and so on for the destination you are flying to, or you may be denied boarding, detained or deported by the respective authorities.'''),
            ),
            kVerticalSpacer,
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: buildRow('iconBaggage', 'BAGGAGE',
                  '''Cabin baggage – you are allowed to carry 2 pieces of cabin baggage with a total weight of 7kg. The dimensions are limited to 56 cm x 36cm x 23cm including handles, wheels and side pockets. The bag must be able to fit into the overhead cabin of the aircraft. The second item should be 40cm x 30cm x 10cm so that it can be stored under your seat.'''),
            ),
            kVerticalSpacer,
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: buildRow('iconProhibited', 'PROHIBITED ITEMS',
                  '''Please take note of items that shall not be carried onboard the aircraft, as well as the restriction on liquids, aerosols and gels, limited to 100ml per container and a combined total of 1000ml.'''),
            ),
            kVerticalSpacer,
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: buildRow(
                  'iconInfoSystem',
                  'APIS – ADVANCE PASSENGER INFORMATION SYSTEM',
                  '''As part of the security requirements of Malaysia, you are required to enter your travel document personal details during the check-in process. Please ensure that the personal data you entered is updated and accurate.'''),
            ),
            kVerticalSpacer,
            buildDoubleRow('iconKnife', 'Sharp Objects\n& Weapons', 'iconKnife',
                'Explosives'),
            kVerticalSpacer,
            buildDoubleRow('iconKnife', 'Flammable\nSubstances', 'iconKnife',
                'Blunt Objects\n& Instruments'),
            kVerticalSpacer,
            buildDoubleRow(
                'iconKnife',
                'Self-Heating\nMeals &\nReady-To-Eat\nMeals',
                'iconKnife',
                'Biohazards\n& Poisons'),
            kVerticalSpacer,
            buildDoubleRow('iconKnife', 'Chemicals\n& Corrosive\nMaterials',
                'iconKnife', 'Compressed\nGases'),
            kVerticalSpacer,
            buildDoubleRow('iconKnife', 'Batteries (more than\n160WH)',
                'iconKnife', 'Firearms: Guns,\nStun Guns,\nReplica Guns'),
            kVerticalSpacer,
            buildDoubleRow('iconKnife', 'Live Plants\nand Flowers', 'iconKnife',
                'Disabling Devices:\nTasers, Mace,\nPepper Spray'),
            kVerticalSpacer,

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor:
                  MaterialStateProperty.resolveWith(getColor),
                  value: true,
                  onChanged: (bool? value) {
                   // bloc?.setCheckDeparture(value ?? false);
                  },
                ),
                Expanded(
                  child: RichText(
                    text:  TextSpan(
                      children: [
                        TextSpan(
                          text: 'By clicking "Continue", I acknowledge and agree to the information above. For more information about Dangerous Goods, please read our ',
                          style:  kMediumRegular.copyWith(color: Styles.kTextColor),
                        ),

                        //
                        TextSpan(
                          text: 'FAQ',
                          style:  kMediumSemiBold.copyWith(color: Styles.kLinkColor,
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

            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      }, //isLoading ? null :
                      child: const Text('Back'),
                    ),
                  ),
                  kHorizontalSpacerSmall,
                  Expanded(
                    child: ElevatedButton(
                      child: const Text('Continue'),
                      onPressed: () async {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ),
                ],
              ),
            ),
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
