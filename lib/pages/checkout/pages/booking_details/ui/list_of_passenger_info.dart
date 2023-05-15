import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/passenger_company_info.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/passenger_contact.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/passenger_emergency_contact.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/pessenger_info.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/security_utils.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../auth/bloc/login/login_cubit.dart';

class ListOfPassengerInfo extends StatefulWidget {
  final VoidCallback onInsuranceChanged;

  const ListOfPassengerInfo({super.key, required this.onInsuranceChanged});

  @override
  State<ListOfPassengerInfo> createState() => ListOfPassengerInfoState();
}

class ListOfPassengerInfoState extends State<ListOfPassengerInfo> {

  GlobalKey<PassengerEmergencyContactState> keyPassE = GlobalKey<PassengerEmergencyContactState>();
  GlobalKey<PassengerContactState> keyPassC = GlobalKey<PassengerContactState>();

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<SearchFlightCubit>();
    final state = bloc.state;
    final persons = state.filterState?.numberPerson;




    return Column(
      children: [
        GreyCard(
          margin: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${"importantInformation".tr()}",
                style: kMediumHeavy.copyWith(color: Styles.kSubTextColor),
              ),
              kVerticalSpacerSmall,
              RowBulletNumbering(title: "idNameMatch".tr()),
              RowBulletNumbering(title: "nameBothFieldsRequired".tr()),
              RowBulletNumbering(title: "confirmationNoChanges".tr()),
              Visibility(
                visible: (persons?.numberOfInfant ?? 0) > 0 ||
                    (persons?.numberOfChildren ?? 0) > 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    kVerticalSpacer,
                    Text(
                      "commForm.travelKids".tr(),
                      style: kMediumHeavy.copyWith(color: Styles.kSubTextColor),
                    ),
                    kVerticalSpacerSmall,
                    Text(
                      "rowNoEmergency".tr(),
                      style:
                          kMediumMedium.copyWith(color: Styles.kSubTextColor),
                    ),
                    kVerticalSpacerSmall,
                  ],
                ),
              ),
            ],
          ),
        ),
        kVerticalSpacer,
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text:
                    'commForm.commFormFAQ'.tr(),
                style: kMediumMedium.copyWith(
                    color: Styles.kTextColor, height: 1.5),
              ),
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    SecurityUtils.tryLaunch(
                        'https://www.myairline.my/fares-fees');
                  },
                text: " ${'commForm.faq'.tr()}",
                style: kMediumHeavy.copyWith(
                    color: Colors.blue,
                    height: 1.5,
                    decoration: TextDecoration.underline),
              ),
            ],
          ),
          textAlign: TextAlign.left,
        ),
        kVerticalSpacer,
        if (persons != null) ...[
          for (int i = 0; i < persons.persons.length; i++) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: PassengerInfo(
                person: persons.persons[i],
                insuranceSelected: (bool flag, Bundle insurance) {
                  if (flag) {
                    bloc.addInsuranceToPerson(i, insurance);
                    widget.onInsuranceChanged.call();
                  } else {
                    bloc.removeInsuranceFromPerson(i);
                    widget.onInsuranceChanged.call();
                  }
                },
              ),
            ),
          ],
        ],
        Column(
          children:  [
            PassengerContact(key: keyPassC,),
            PassengerEmergencyContact(
              key: keyPassE,
            ),
            PassengerCompanyInfo(),
          ],
        ),
      ],
    );
  }

  void reload() {

    setState(() {

      keyPassC.currentState?.reloadDate();
      keyPassE.currentState?.reloadData();

    });
  }
}

class RowBulletNumbering extends StatelessWidget {
  final String title;

  const RowBulletNumbering({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "•",
            style: kMediumMedium.copyWith(color: Styles.kSubTextColor),
          ),
          kHorizontalSpacerMini,
          Expanded(
            child: Text(
              title,
              style: kMediumMedium.copyWith(color: Styles.kSubTextColor),
            ),
          ),
        ],
      ),
    );
  }
}
