import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../blocs/profile/profile_cubit.dart';
import '../../../theme/spacer.dart';
import '../../auth/pages/signup/signup_wrapper.dart';
import '../../auth/pages/signup/ui/name_input.dart';
import '../../auth/pages/signup/ui/personal_detail/address_input.dart';
import 'additional_info.dart';
import 'emergengy_info_view.dart';

class PersonalInfoView extends StatelessWidget {
  const PersonalInfoView({Key? key}) : super(key: key);

  static final _fbKey = GlobalKey<FormBuilderState>();

  //iconLogout
  //
  onSave(BuildContext context) {
    // var profileObject = context.watch<ProfileCubit>().state.profile;
    var cubut = context.watch<ProfileCubit>().state;

    if (_fbKey.currentState!.saveAndValidate()) {
      final value = _fbKey.currentState!.value;

      /*
      final signupRequest = SignupRequest(
        firstName: value[formNameFirstName],
        lastName: value[formNameLastName],
        email: value[formNameEmail],
        phoneNumber: value[formNamePhone],
        password: value[formNamePassword],
        confirmPassword: value[formNameConfirmPassword],
      );*/

      // context.read<SignupCubit>().addAccountDetail(signupRequest);
      //AutoRouter.of(context).push(SignupAddressRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.watch<ProfileCubit>();

    var profile = context.watch<ProfileCubit>().state.profile;

    return FormBuilder(
      autoFocusOnValidationFailure: true,
      key: _fbKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
              ),
              kVerticalSpacer,
              AdditionInfoView(
                countrySelected: profile?.userProfile?.country,
                myKadSelected: profile?.userProfile?.icNumber,
                emailSelected: profile?.userProfile?.email,
                dobSelected: profile?.userProfile?.dob,
                phoneCountryCodeSelected: profile?.userProfile?.phoneCode,
                phoneSelected: profile?.userProfile?.phoneCode,
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
              ),
              kVerticalSpacer,
              EmergencyInfoView(
                firstName: profile?.userProfile?.emergencyContact?.firstName,
                lastName: profile?.userProfile?.emergencyContact?.lastName,
                relationShip:
                    profile?.userProfile?.emergencyContact?.relationship,
                countryCode: profile?.userProfile?.emergencyContact?.phoneCode,
                phoneNo: profile?.userProfile?.emergencyContact?.phoneCode,
              ),
              kVerticalSpacer,
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              kVerticalSpacerSmall,
              ElevatedButton(
                onPressed: () async {
//                  var profile = cubut;

                  if (_fbKey.currentState!.saveAndValidate()) {
                    final value = _fbKey.currentState!.value;

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

                    cubit.updateProfile(
                        icNumber: myId,
                        newTitle: null,
                        newFirstName: fName,
                        lastName: lName,
                        newCountry: null,
                        newEmail: email,
                        newDob: dob,
                        newPhoneCountryCode: null,
                        newPhNo: phoneNo,
                        newAddress: address,
                        newAddressCountry: null,
                        newAddressState: state,
                        newAddressCity: city,
                        newAddresZipCode: posCode,
                        emergencyFirstName: eFirstName,
                        emergencyLastName: eLastName,
                        emergencyRelationShip: eRelationShip,
                        emergencyPhCode: null,
                        emergencyPhNo: ePhoneNo);
                  }

                  print('');
                },
                child: const Text("Save"),
              ),
              kVerticalSpacer,
            ],
          ),
        ),
      ),
    );
  }
}
