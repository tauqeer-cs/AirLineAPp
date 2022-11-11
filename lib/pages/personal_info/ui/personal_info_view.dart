import 'package:app/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../blocs/profile/profile_cubit.dart';
import '../../../localizations/localizations_util.dart';
import '../../../models/country.dart';
import '../../../theme/spacer.dart';
import '../../auth/pages/signup/signup_wrapper.dart';
import '../../auth/pages/signup/ui/name_input.dart';
import '../../auth/pages/signup/ui/personal_detail/address_input.dart';
import 'additional_info.dart';
import 'emergengy_info_view.dart';

class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView({Key? key}) : super(key: key);
  static final _fbKey = GlobalKey<FormBuilderState>();

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  String? nameTitle;
  Country? selectedCountry;
  Country? phoneCountry;
  Country? addressCountry;
  Country? ePhoneCountry;

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<ProfileCubit>();
    var profile = cubit.state.profile;
    return FormBuilder(
      autoFocusOnValidationFailure: true,
      key: PersonalInfoView._fbKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            NameInput(
              title: 'Full Name',
              subText:
                  'Make sure your name is the same as it appears on your driver’s license or other government-issued ID.',
              smallerSubText: true,
              greyMargin: 0,
              customGreyEdgeInsets: EdgeInsets.zero,
              firstNameInitValue: profile?.userProfile?.firstName,
              lastNameInitValue: profile?.userProfile?.lastName,
              onTitleChanged: (String? newTitle) {
                nameTitle = newTitle;
              },
            ),
            kVerticalSpacer,
            AdditionInfoView(
              countrySelected: profile?.userProfile?.nationality,
              myKadSelected: profile?.userProfile?.icNumber,
              emailSelected: profile?.userProfile?.email,
              dobSelected: profile?.userProfile?.dob,
              phoneCountryCodeSelected: profile?.userProfile?.phoneCode,
              phoneSelected: profile?.userProfile?.phoneNumber,
              onCountryChange: (newCountry) {
                selectedCountry = newCountry;
              },
              phoneCountryCode: (newPhoneCountry) {
                phoneCountry = newPhoneCountry;
              },
            ),
            kVerticalSpacer,
            AddressInput(
              title: 'Address',
              subText: '',
              hideSubText: true,
              greyMargin: 0,
              customGreyEdgeInsets: EdgeInsets.zero,
              withEmail: false,
              selectedAddress: profile?.userProfile?.address,
              selectedCity: profile?.userProfile?.country,
              selectedState: profile?.userProfile?.state,
              selectedCountry: profile?.userProfile?.country,
              selectedPosCode: profile?.userProfile?.postCode,
              onAddressCountryChange: (newCountry) {
                addressCountry = newCountry;
              },
            ),
            kVerticalSpacer,
            EmergencyInfoView(
              firstName: profile?.userProfile?.emergencyContact?.firstName,
              lastName: profile?.userProfile?.emergencyContact?.lastName,
              relationShip:
                  profile?.userProfile?.emergencyContact?.relationship,
              countryCode: profile?.userProfile?.emergencyContact?.phoneCode,
              phoneNo: profile?.userProfile?.emergencyContact?.phoneCode,
              onPhoneCodeChanged: (newCountry) {
                ePhoneCountry = newCountry;
              },
            ),
            kVerticalSpacer,
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            kVerticalSpacerSmall,
            ElevatedButton(
              onPressed: () async {
                if (PersonalInfoView._fbKey.currentState!.saveAndValidate()) {
                  final value = PersonalInfoView._fbKey.currentState!.value;
                  String? fName = value[formNameFirstName];
                  String? lName = value[formNameLastName];
                  String? myId = value[formNameMyKad];
                  String? email = value[formNameEmail];
                  DateTime? dob = value[formNameDob];
                  String? phoneNo = value[formNamePhone];
                  String? address = value[formNameAddress];
                  String? state = value[formNameState];
                  String? city = value[formNameCity];
                  String? posCode = value[formNamePostCode];
                  String? eFirstName = value[formNameFirstNameEmergency];
                  String? eLastName = value[formNameLastNameEmergency];
                  String? eRelationShip =
                      value[formNameRelationshipEmergency];
                  String? ePhoneNo = value[formNamePhoneNoRelationship];

                  final UserProfile userProfile = UserProfile(
                    icNumber: myId,
                    title: nameTitle ?? profile?.userProfile?.title,
                    firstName: fName,
                    lastName: lName,
                    nationality: selectedCountry?.countryCode2 ??
                        profile?.userProfile?.nationality,
                    email: email,
                    dob: dob,
                    phoneCode: phoneCountry?.phoneCode ??
                        profile?.userProfile?.phoneCode,
                    phoneNumber: phoneNo,
                    address: address,
                    country: addressCountry?.phoneCode ??
                        profile?.userProfile?.country,
                    state: state,
                    city: city,
                    postCode: posCode,
                    emergencyContact: EmergencyContact(
                      firstName: eFirstName,
                      lastName: eLastName,
                      phoneNumber: ePhoneNo,
                      phoneCode: ePhoneCountry?.phoneCode ?? profile?.userProfile?.emergencyContact?.phoneCode,
                      relationship: eRelationShip,
                    ),
                  );
                  context.read<ProfileCubit>().updateProfile(userProfile);
                }
              },
              child: const Text("Save"),
            ),
            kVerticalSpacer,
          ],
        ),
      ),
    );
  }
}
