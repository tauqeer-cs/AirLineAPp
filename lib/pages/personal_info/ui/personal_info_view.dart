import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../theme/spacer.dart';
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
    return FormBuilder(
      autoFocusOnValidationFailure: true,
      key: _fbKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const NameInput(
                title: 'Full Name',
                subText:
                    'Make sure your name is the same as it appears on your driver’s license or other government-issued ID.',
                smallerSubText: true,
                greyMargin: 0,
                customGreyEdgeInsets: EdgeInsets.zero,
              ),
              kVerticalSpacer,
              const AdditionInfoView(),
              kVerticalSpacer,
              const AddressInput(
                title: 'Address',
                subText: '',
                hideSubText: true,
                greyMargin: 0,
                customGreyEdgeInsets: EdgeInsets.zero,
                withEmail: true,
              ),
              kVerticalSpacer,
              const EmergencyInfoView(),
              kVerticalSpacer,

              OutlinedButton(
                onPressed: (){

                },
                child: const Text("Cancel"),
              ),
              kVerticalSpacerSmall,
              ElevatedButton(
                onPressed: () {

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
