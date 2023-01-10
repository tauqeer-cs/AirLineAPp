import 'package:app/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../../blocs/countries/countries_cubit.dart';
import '../../../data/requests/friend_family_add.dart';
import '../../../models/number_person.dart';
import '../../../models/profile.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../utils/form_utils.dart';
import '../../../widgets/app_countries_dropdown.dart';
import '../../../widgets/app_divider_widget.dart';
import '../../../widgets/forms/app_dropdown.dart';
import '../../../widgets/forms/app_input_text.dart';
import '../../checkout/pages/booking_details/ui/shadow_input.dart';

class AddFamilyFriendsView extends StatelessWidget {
  final bool isEditing;
  final FriendsFamily? familyMember;

  const AddFamilyFriendsView({Key? key,  this.isEditing = false, this.familyMember}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          12, 12, 12, MediaQuery.of(context).viewInsets.bottom + 20),
      child:  SingleChildScrollView(
        child: FriendsFamilyForm(isEditing: isEditing,familyMember: familyMember,),
      ),
    );
  }
}

class FriendsFamilyForm extends StatefulWidget {
  const FriendsFamilyForm({Key? key, this.isEditing = false, this.familyMember}) : super(key: key);
  final bool isEditing;
  final FriendsFamily? familyMember;

  @override
  State<FriendsFamilyForm> createState() => _FriendsFamilyFormState();
}

class _FriendsFamilyFormState extends State<FriendsFamilyForm> {
  final String fName = 'fName';
  final String lName = 'lName';
  final String title = 'title';
  final String nationality = 'nationality';
  final String dob = 'dob';
  final String reward = 'reward';

  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final titleController = TextEditingController();
  final nationalityController = TextEditingController();

  final TextEditingController firstNameTextController = TextEditingController();
  final TextEditingController lastNameTextController = TextEditingController();

  String? selectedTitle;
  String? selectedCountry;

  //AppCountriesDropdown

  @override
  void initState() {
    super.initState();

    print('');

    if(widget.isEditing) {
      firstNameTextController.text = widget.familyMember?.firstName ?? '';
      lastNameTextController.text = widget.familyMember?.lastName ?? '';
      selectedTitle = widget.familyMember?.title ?? '';
      selectedCountry = widget.familyMember?.nationality;
      print('');

    }

  }
  @override
  Widget build(BuildContext context) {

    var bloc = context.read<CountriesCubit>();

    Country? selectedCountryObject;

    //if(widget.isEditing && selectedCountry != null){

     // selectedCountryObject = bloc.state.countries.firstWhere((element) => element.countryCode2 == selectedCountry);
   // }

    return FormBuilder(
      autoFocusOnValidationFailure: true,
      key: formKey,
      child: Column(
        children: [
          const Text(
            "New Family and Friends",
            style: kHugeSemiBold,
          ),
          const SizedBox(
            height: 2,
          ),
          AppDividerWidget(
            color: Styles.kSubTextColor,
          ),
          AppInputText(
            isRequired: false,
            textInputType: TextInputType.emailAddress,
            name: fName,
            hintText: 'First Name / Given Name',
            textEditingController: firstNameTextController,
            validators: [
              FormBuilderValidators.required(),
            ],
          ),
          kVerticalSpacerMini,
          AppInputText(
            isRequired: false,
            textInputType: TextInputType.emailAddress,
            name: lName,
            textEditingController: lastNameTextController,
            hintText: 'Last Name / Surname',
            validators: [
              FormBuilderValidators.required(),
            ],
          ),
          kVerticalSpacerMini,
          Row(
            children: [
              Expanded(
                child: ShadowInput(
                  name: 'title',
                  validators: [FormBuilderValidators.required()],
                  textEditingController: titleController,
                  child: AppDropDown<String>(
                    items: availableTitle,
                    //: availableTitleChild,
                    defaultValue: selectedTitle,
                    sheetTitle: "Title",
                    onChanged: (value) {
                      titleController.text = value ?? "";
                    },
                  ),
                ),
              ),
              kHorizontalSpacerMini,
              Expanded(
                child: ShadowInput(
                  textEditingController: nationalityController,
                  name: 'nationality',
                  child: AppCountriesDropdown(
                    hintText: "Country",
                    isPhoneCode: false,
                    initialValue: selectedCountryObject,
                    onChanged: (value) {
                      nationalityController.text = value?.countryCode2 ?? "";
                    },
                  ),
                ),
              ),
            ],
          ),
          FormBuilderDateTimePicker(
            name: dob,
            firstDate: DateTime.now().add(const Duration(days: -365 * 100)),
            lastDate: DateTime.now(),
            initialValue: null,
            //

            format: DateFormat("dd MMM yyyy"),
            initialEntryMode: DatePickerEntryMode.calendar,
            decoration: const InputDecoration(hintText: "Date of Birth"),
            inputType: InputType.date,
            validator: FormBuilderValidators.required(),
            onChanged: (date) {
              if (date == null) return;

              /*
              setState(() {
                isUnder16 = AppDateUtils.isUnder16(
                  date,
                  filter.departDate ?? DateTime.now(),
                );
              });*/
            },
          ),
          AppInputText(
            name: reward,
            hintText: "MYReward Member ID (Optional)",
            inputFormatters: [AppFormUtils.onlyNumber()],
            textInputType: TextInputType.number,
          ),
          kVerticalSpacer,
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                      return Colors.transparent;
                    }),
                  ),
                  onPressed: () {
                    Navigator.pop(context,);

                  },
                  child: const Text("Cancel"),
                ),
              ),
              kHorizontalSpacerMini,
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.saveAndValidate()) {
                      final value = formKey.currentState!.value;
                      final firstName = value[fName];
                      final lastName = value[lName];
                      final personTitle = value[title];
                      var personNationality = nationalityController.text;
                      if(personNationality.isEmpty){
                        personNationality = 'Malaysia';
                      }
                      final personDob = value[dob];
                      final rewardId = value[reward];




                    final dobToSend =
                          '${personDob.toString().substring(0, personDob.toString().indexOf(' '))}T02:10:32.977Z';
                      final friendsObject = FriendsFamilyAdd(
                        firstName: firstName,
                        lastName: lastName,
                        title: personTitle,
                        nationality: personNationality,
                        dOB: dobToSend,
                        memberID: rewardId,
                      );

                      Navigator.pop(context, friendsObject);

                      //context.read<LoginCubit>().logInWithCredentials(email, password);
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
          kVerticalSpacer,
        ],
      ),
    );
  }
}
//            style: kHugeMedium.copyWith(color: Styles.kPrimaryColor),
