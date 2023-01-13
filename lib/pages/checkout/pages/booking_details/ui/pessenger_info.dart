import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/localizations/localizations_util.dart';
import 'package:app/models/number_person.dart';
import 'package:app/models/switch_setting.dart';
import 'package:app/pages/checkout/pages/booking_details/bloc/info/info_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/booking_details_view.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/shadow_input.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/theme/html_style.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/form_utils.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_dropdown.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:app/widgets/settings_wrapper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../../../../blocs/booking/booking_cubit.dart';
import '../../../../../blocs/profile/profile_cubit.dart';
import '../../../../../blocs/search_flight/search_flight_cubit.dart';
import '../../../../../models/profile.dart';
import '../../../../../utils/constant_utils.dart';
import '../../../../../utils/ui_utils.dart';
import '../../../../../widgets/app_divider_widget.dart';
import '../../../../../widgets/pdf_viewer.dart';

class PassengerInfo extends StatefulWidget {
  final Person person;

  final Function(bool e, Bundle currentInsuranceBundlde) insuranceSelected;

  const PassengerInfo(
      {Key? key, required this.person, required this.insuranceSelected})
      : super(key: key);

  @override
  State<PassengerInfo> createState() => _PassengerInfoState();
}

class _PassengerInfoState extends State<PassengerInfo> {
  late String nationality;

  final titleController = TextEditingController();
  final nationalityController = TextEditingController();
  final infantAdultName = TextEditingController();
  final dobController = TextEditingController();

  String get firstNameKey {
    return "${widget.person.toString()}$formNameFirstName";
  }

  String get lastNameKey {
    return "${widget.person.toString()}$formNameLastName";
  }

  String get dobKey {
    return "${widget.person.toString()}$formNameDob";
  }

  String get countryKey {
    return "${widget.person.toString()}$formNameNationality";
  }

  String get titleKey {
    return "${widget.person.toString()}$formNameTitle";
  }

  String get rewardKey {
    return "${widget.person.toString()}$formNameMYRewardId";
  }

  bool isUnder16 = false;
  bool isWheelChairChecked = false;

  bool insuranceSelected = false;

  Bundle? currentInsuranceBundlde;

  @override
  void initState() {
    super.initState();
    nationality = widget.person.passenger?.nationality ?? "MY";
    nationalityController.text = nationality;

    if (widget.person.insuranceGroup != null) {
      insuranceSelected = true;
    }
    if (widget.person.passenger?.firstName == 'EXTRA') {
      isNameExtra = true;
    }
  }

  GlobalKey dateKey = GlobalKey();

  String? defaultTitle;

  bool isNameExtra = false;

  @override
  Widget build(BuildContext context) {
    var profileBloc = context.read<ProfileCubit>();

    final passengerInfo = widget.person.passenger;
    final notice = context.watch<CmsSsrCubit>().state.notice;
    final filter = context.watch<FilterCubit>().state;
    final bookingState = context
        .watch<BookingCubit>()
        .state
        .verifyResponse
        ?.flightSSR
        ?.insuranceGroup;
    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                widget.person.toString(),
                style: kHugeSemiBold,
              ),
              Expanded(
                child: Container(),
              ),
              if (profileBloc.hasAnyFriends && ConstantUtils.showFamily) ...[
                InkWell(
                  onTap: () async {
                    FriendsFamily? selectFamily = await showBottomDialog(
                      context,
                      FriendsAndFamilySelectorPopUp(
                        friendsAndFamily: profileBloc.friendFamily,
                      ),
                    );

                    if (selectFamily != null) {
                      // BookingDetailsView.fbKey.currentState?.patchValue('age': '50');
                      //passengerInfo?.dob = DateTime.now();

                      if(selectFamily.memberID == -121 && selectFamily.firstName == 'My'){



                        BookingDetailsView
                            .fbKey.currentState!.fields[firstNameKey]!
                            .didChange(profileBloc.state.profile?.userProfile?.firstName ?? '');

                        BookingDetailsView
                            .fbKey.currentState!.fields[lastNameKey]!
                            .didChange(profileBloc.state.profile?.userProfile?.lastName ?? '');

                        if (profileBloc.state.profile?.userProfile?.dob != null) {
                          BookingDetailsView.fbKey.currentState!.fields[dobKey]!
                              .didChange(profileBloc.state.profile?.userProfile?.dob);
                        }

                        BookingDetailsView.fbKey.currentState!.fields[titleKey]!
                            .didChange(profileBloc.state.profile?.userProfile?.title  ?? '');
                        if (profileBloc.state.profile?.userProfile?.memberID != null) {
                          BookingDetailsView
                              .fbKey.currentState!.fields[rewardKey]!
                              .didChange(profileBloc.state.profile?.userProfile?.memberID.toString());
                        }
                      }
                      else {
                        //                            Navigator.pop(context, const FriendsFamily(memberID: -121,firstName: 'My'));
                        BookingDetailsView
                            .fbKey.currentState!.fields[firstNameKey]!
                            .didChange(selectFamily.firstName ?? '');

                        BookingDetailsView
                            .fbKey.currentState!.fields[lastNameKey]!
                            .didChange(selectFamily.lastName ?? '');

                        if (selectFamily.dobDate != null) {
                          BookingDetailsView.fbKey.currentState!.fields[dobKey]!
                              .didChange(selectFamily.dobDate);
                        }

                        BookingDetailsView.fbKey.currentState!.fields[titleKey]!
                            .didChange(selectFamily.title ?? '');
                        if (selectFamily.memberID != null) {
                          if(selectFamily.memberID == 0) {

                          }
                          else {
                            BookingDetailsView
                                .fbKey.currentState!.fields[rewardKey]!
                                .didChange(selectFamily.memberID!);
                          }

                        }
                        else {


                        }
                      }


                    }
                  },
                  child: Row(
                    children: [
                      Text(
                        "Friends & Family",
                        style: kLargeMedium.copyWith(
                          color: Styles.kOrangeColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Styles.kOrangeColor,
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
        kVerticalSpacerSmall,
        AutofillGroup(
          child: GreyCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppInputText(
                  name: firstNameKey,
                  hintText: "First Name/Given Name",
                  initialValue: passengerInfo?.firstName,
                  validators: [FormBuilderValidators.required()],
                  onChanged: (value) {
                    context
                        .read<InfoCubit>()
                        .updateMap(widget.person.toString(), value ?? "");

                    if (insuranceSelected && value == 'EXTRA') {
                      widget.insuranceSelected(false, currentInsuranceBundlde!);
                      insuranceSelected = false;
                      setState(() {
                        isNameExtra = true;
                      });
                    } else if (value == 'EXTRA') {
                      setState(() {
                        isNameExtra = true;
                      });
                    } else {
                      setState(() {
                        isNameExtra = false;
                      });
                    }
                  },
                ),
                kVerticalSpacerMini,
                AppInputText(
                  name: lastNameKey,
                  hintText: "Last Name / Surname",
                  initialValue: passengerInfo?.lastName,
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                ),
                ShadowInput(
                  name: "${widget.person.toString()}$formNameTitle",
                  validators: [FormBuilderValidators.required()],
                  textEditingController: titleController,
                  child: AppDropDown<String>(
                    items: widget.person.peopleType == PeopleType.adult
                        ? availableTitle
                        : availableTitleChild,
                    defaultValue: defaultTitle,
                    sheetTitle: "Title",
                    onChanged: (value) {
                      titleController.text = value ?? "";
                    },
                  ),
                ),
                kVerticalSpacerMini,
                ShadowInput(
                  textEditingController: nationalityController,
                  name: countryKey,
                  child: AppCountriesDropdown(
                    hintText: "Country",
                    isPhoneCode: false,
                    onChanged: (value) {
                      nationalityController.text = value?.countryCode2 ?? "";
                    },
                  ),
                ),
                FormBuilderDateTimePicker(
                  key: dateKey,
                  name: dobKey,
                  firstDate: widget.person.dateLimitStart(filter.departDate),
                  lastDate: widget.person.peopleType == PeopleType.infant
                      ? DateTime.now().add(const Duration(days: -8))
                      : widget.person.dateLimitEnd(filter.departDate),
                  initialValue: passengerInfo?.dob,
                  format: DateFormat("dd MMM yyyy"),
                  initialDate: widget.person.peopleType == PeopleType.infant
                      ? DateTime.now().add(const Duration(days: -8))
                      : widget.person.dateLimitEnd(filter.departDate),
                  initialEntryMode: DatePickerEntryMode.calendar,
                  decoration: const InputDecoration(hintText: "Date of Birth"),
                  inputType: InputType.date,
                  validator: FormBuilderValidators.required(),
                  onChanged: (date) {
                    if (date == null) return;
                    setState(() {
                      isUnder16 = AppDateUtils.isUnder16(
                        date,
                        filter.departDate ?? DateTime.now(),
                      );
                    });
                  },
                ),
                kVerticalSpacerMini,
                AppInputText(
                  name: rewardKey,
                  hintText: "MYReward Member ID (Optional)",
                  inputFormatters: [AppFormUtils.onlyNumber()],
                  textInputType: TextInputType.number,
                ),
                kVerticalSpacerMini,
                Visibility(
                  visible: (notice?.content?.isNotEmpty ?? false) &&
                      isUnder16 &&
                      (widget.person.peopleType == PeopleType.adult) &&
                      (filter.numberPerson.numberOfAdult == 1),
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                    width: 500.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFFECBBC0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: true,
                          onChanged: (_) {},
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                        Expanded(
                          child: Html(
                            data: notice?.content ?? "",
                            style: HtmlStyle.htmlStyle(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: visible(),
                  child: FormBuilderCheckbox(
                    name: "${widget.person.toString()}$formNameWheelChair",
                    contentPadding: EdgeInsets.zero,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                    title: const Text("I need wheelchair assistance."),
                    onChanged: (value) {
                      setState(() {
                        isWheelChairChecked = value ?? false;
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: isWheelChairChecked,
                  child: AppInputText(
                    name: "${widget.person.toString()}$formNameOkIdNumber",
                    hintText: "Disabled ID Card No (Optional)",
                  ),
                ),
                Visibility(
                  visible: widget.person.peopleType == PeopleType.infant,
                  child: BlocBuilder<InfoCubit, Map<String, String>>(
                    builder: (context, state) {
                      final adultName =
                          state["Adult ${widget.person.numberOrder}"];
                      final string =
                          adultName ?? "Adult ${widget.person.numberOrder}";
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                color: Styles.kBorderColor.withOpacity(0.3)),
                          ),
                        ),
                        child: Text(
                          "Travel With $string",
                          style: kSmallSemiBold,
                        ),
                      );
                    },
                  ),
                ),
                if (!isNameExtra) ...[
                  if (bookingState != null) ...[
                    if (bookingState.outbound!.isNotEmpty) ...[
                      Visibility(
                        visible: visible(),
                        child: SettingsWrapper(
                          settingType: AvailableSetting.insurance,
                          child: FormBuilderCheckbox(
                            name: "${widget.person.toString()}$formNameInsurance",
                            contentPadding: EdgeInsets.zero,
                            initialValue: insuranceSelected,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                            title: RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  const TextSpan(text: 'I want '),
                                  TextSpan(
                                    text: 'travel protection',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => const PdfViewer(
                                              title: 'Travel Protection',
                                              fileName:
                                                  'GI_MYAirline_TravelDomestic_SOB_20221222',
                                            ),
                                          ),
                                        );
                                      },
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.grey.shade900,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        " : MYR${travelProtectionRate(bookingState.outbound!)}",
                                  )
                                ],
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                insuranceSelected = value ?? false;
                              });

                              if (value == true) {
                                // widget.person.insuranceGroup =
                                //   currentInsuranceBundlde;

                                //widget.person = widget.person.copyWith(insurance: );

                                widget.insuranceSelected(
                                    true, currentInsuranceBundlde!);
                              } else {
                                widget.insuranceSelected(
                                    false, currentInsuranceBundlde!);

                                // widget.person = widget.person.copyWith(insuranceEmpty: true);

                                //widget.person.insuranceGroup = null;
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ],
                ]
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool visible() {
    if (widget.person.peopleType == PeopleType.infant) {
      return true;
    }
    return true;
  }

  String travelProtectionRate(List<Bundle> outbound) {
    currentInsuranceBundlde = outbound.first;
    var taxAmount = 0.0;
    if (currentInsuranceBundlde!.applicableTaxes != null) {
      taxAmount =
          currentInsuranceBundlde!.applicableTaxes!.first.taxAmount!.toDouble();
    }
    return (taxAmount + outbound.first.amount!.toDouble()).toStringAsFixed(2);
  }
}

class FriendsAndFamilySelectorPopUp extends StatelessWidget {
  FriendsAndFamilySelectorPopUp({
    Key? key,
    required this.friendsAndFamily,
  }) : super(key: key);
  List<FriendsFamily> friendsAndFamily;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.55,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kVerticalSpacer,
            const Text(
              'Family & Friends',
              style: kHugeSemiBold,
            ),
            const SizedBox(
              height: 8,
            ),
            const AppDividerWidget(
              //color: Styles.kSubTextColor,
              color: Colors.white,
            ),
            kVerticalSpacer,
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          if(index == 0){

                            Navigator.pop(context, const FriendsFamily(memberID: -121,firstName: 'My'));


                            return;
                          }
                          Navigator.pop(context, friendsAndFamily[index -1]);
                        },
                        child: index == 0 ? Text(
                          'I am flying',
                          style: kMediumRegular.copyWith(color: Styles.kPrimaryColor),
                        ) : Text(
                          friendsAndFamily[index-1].fullName,
                          style: kMediumRegular,
                        ),
                      ),
                      kVerticalSpacer,
                    ],
                  );
                },
                itemCount: friendsAndFamily.length + 1,
              ),
            ),
            kVerticalSpacerMini,
          ],
        ),
      ),
    );
  }
}
