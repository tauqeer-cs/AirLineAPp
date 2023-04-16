import 'package:app/models/country.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../../blocs/countries/countries_cubit.dart';
import '../../../data/requests/friend_family_add.dart';
import '../../../data/requests/update_friends_family.dart';
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
  final TextEditingController memberTextController = TextEditingController();

  String? selectedTitle;
  String? selectedCountry;

  //AppCountriesDropdown


  DateTime? initialDateTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(widget.isEditing) {
      setTitle();
    }
  }

  @override
  void initState() {
    super.initState();

    if(widget.isEditing) {
      firstNameTextController.text = widget.familyMember?.firstName ?? '';
      lastNameTextController.text = widget.familyMember?.lastName ?? '';

      selectedCountry = widget.familyMember?.nationality;
      var tmpDate = widget.familyMember?.dob;
      initialDateTime = DateTime.parse(tmpDate!);

      if(widget.familyMember?.memberID != null){

        memberTextController.text =  widget.familyMember!.memberID!.toString();

      }
    }

  }

  void setTitle() async {
     if(widget.familyMember?.title == 'Tan S') {
      selectedTitle = availableTitle.last;
      await Future.delayed(const Duration(seconds: 1));
      formKey.currentState!.fields['title']!
          .didChange(availableTitle.last);
    }
    else {
      selectedTitle = widget.familyMember?.title ?? '';
      await Future.delayed(const Duration(seconds: 1));

      formKey.currentState!.fields['title']!
          .didChange(selectedTitle);


    }
  }
  bool validateOnChange = false;

  bool isTwelveYearsAgo(DateTime dob) {

    var twelveYearsAgo = DateTime.now().subtract(const Duration(days: 365 * 12)).subtract(const Duration(days: 3));
    return dob.isBefore(twelveYearsAgo);
  }
  
  @override
  Widget build(BuildContext context) {

    var bloc = context.read<CountriesCubit>();

    Country? selectedCountryObject;


    return FormBuilder(
      onChanged: (){


        if(validateOnChange) {
          formKey.currentState!.validate();

        }



      },
      autoFocusOnValidationFailure: true,
      key: formKey,
      child: Column(
        children: [
          Text(
            widget.isEditing ? 'personalInfo.familyFriends'.tr() : 'familyDetail.newFamilyFriends'.tr(),
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
            hintText: 'familyDetail.fName'.tr(),
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
            hintText: 'familyDetail.lName'.tr(),
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
                    items: availableTitleAll,
                    //: availableTitleChild,
                    defaultValue: selectedTitle,
                    sheetTitle: 'familyDetail.title'.tr(),
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
                    hintText: 'country'.tr(),
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
            initialValue: initialDateTime,
            format: DateFormat("dd MMM yyyy"),
            initialEntryMode: DatePickerEntryMode.calendar,
            decoration:  InputDecoration(hintText: 'infoDetail.dob'.tr()),
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
            textEditingController: memberTextController,
            hintText: 'familyDetail.myRewardsMembershipID'.tr(),
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
                  child:  Text('familyDetail.cancel'.tr()),
                ),
              ),
              kHorizontalSpacerMini,
              Expanded(
                child: ElevatedButton(
                  onPressed: () {

                    if(validateOnChange == false) {
                      setState(() {
                        validateOnChange = true;
                      });
                    }


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

                      //personDob
                      if((personTitle == 'Mstr.' || personTitle == 'Miss')) {

                        bool check = isTwelveYearsAgo(personDob,);
                        if(check) {
                          //error here of form
                          formKey.currentState!.invalidateField(name: 'title' , errorText: 'Invalid title');
                          return;
                        }
                        else {



                        }
                      }
                      else {
                        bool check = isTwelveYearsAgo(personDob,);
                        if(!check) {
                          //error here of form
                          formKey.currentState!.invalidateField(name: 'title' , errorText: 'Invalid title');
                          return;
                        }

                      }
                      final rewardId = value[reward];
                      int? memberIdToSemd;
                      if(rewardId != '') {
                        memberIdToSemd = int.parse(rewardId);
                      }

                      var dobString =personDob.toString();
                      var indexOfSpace = dobString.indexOf(' ');
                      dobString = '${dobString.replaceAll(' ','T')}Z';


                    final dobToSend =
                          '${dobString.substring(0, indexOfSpace)}T02:10:32.977Z';

                    if(widget.isEditing) {
                      final friendsObject = UpdateFriendsFamily(
                        firstName: firstName,
                        lastName: lastName,
                        title: personTitle,
                        nationality: personNationality,
                        dob: dobToSend,
                        memberID: memberIdToSemd,
                        friendsAndFamilyID: widget.familyMember!.friendsAndFamilyID
                      );

                      Navigator.pop(context, friendsObject);


                    }
                    else {
                      final friendsObject = FriendsFamilyAdd(
                        firstName: firstName,
                        lastName: lastName,
                        title: personTitle,
                        nationality: personNationality,
                        dOB: dobToSend,
                        memberID: memberIdToSemd,
                      );

                      Navigator.pop(context, friendsObject);

                    }

                      //context.read<LoginCubit>().logInWithCredentials(email, password);
                    }
                  },
                  child:  Text('familyDetail.save'.tr()),
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
