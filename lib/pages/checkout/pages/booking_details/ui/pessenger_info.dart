import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/localizations/localizations_util.dart';
import 'package:app/models/number_person.dart';
import 'package:app/models/switch_setting.dart';
import 'package:app/pages/checkout/pages/booking_details/bloc/info/info_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/booking_details_view.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/shadow_input.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/theme/html_style.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/form_utils.dart';
import 'package:app/utils/string_utils.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_dropdown.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:app/widgets/settings_wrapper.dart';
import 'package:collection/collection.dart';
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
    //"${widget.person.toString()}$formNameTitle"
    return "${widget.person.toString()}$formNameTitle";
  }

  String get rewardKey {
    return "${widget.person.toString()}$formNameMYRewardId";
  }

  String? okId;
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

    final bookingState = context.watch<BookingCubit>().state;
    final insuranceGroup = context
        .watch<BookingCubit>()
        .state
        .verifyResponse
        ?.flightSSR
        ?.insuranceGroup;
    final wheelChairGroup =
        bookingState.verifyResponse?.flightSSR?.wheelChairGroup;
    final departureWheelChair = wheelChairGroup?.outbound;
    final returnWheelChair = filter.flightType == FlightType.oneWay
        ? null
        : wheelChairGroup?.inbound;

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
                    await onFamilyButtonTapped(profileBloc, filter, context);
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
                  name: titleKey,
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
                      ? infantDOBlimit(filter.departDate ?? DateTime.now())
                      : widget.person.dateLimitEnd(filter.departDate),
                  initialValue: passengerInfo?.dob,
                  format: DateFormat("dd MMM yyyy"),
                  initialDate: widget.person.peopleType == PeopleType.infant
                      ? infantDOBlimit(filter.departDate ?? DateTime.now())
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
                    title: const Text(
                        'Tick this box and check-in at the airport counter to receive a wheelchair'),
                    onChanged: (value) {
                      if (value ?? false) {
                        updateWheelChair(
                            context, departureWheelChair, returnWheelChair);
                      } else {
                        context.read<SearchFlightCubit>().addWheelChairToPerson(
                              widget.person,
                              null,
                              null,
                            );
                      }
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
                    onChanged: (id) {
                      okId = id;
                      updateWheelChair(
                          context, departureWheelChair, returnWheelChair);
                    },
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
                  if (insuranceGroup != null) ...[
                    if (insuranceGroup.outbound!.isNotEmpty) ...[
                      Visibility(
                        visible: visible(),
                        child: SettingsWrapper(
                          settingType: AvailableSetting.insurance,
                          child: FormBuilderCheckbox(
                            name:
                                "${widget.person.toString()}$formNameInsurance",
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
                                  makeClickableTextSpan(context,
                                      text: 'MY${' Travel Shield'}',
                                      pdfName:
                                          'https://booking.myairline.my/insurance/travel_protection.pdf',
                                      pdfIsLink: true),
                                  makeClickableTextSpan(context,
                                      text:
                                          ": MYR ${travelProtectionRate(insuranceGroup.outbound!)}",
                                      makeNormalTextBol: true),
                                ],
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                insuranceSelected = value ?? false;
                              });

                              if (value == true) {
                                widget.insuranceSelected(
                                    true, currentInsuranceBundlde!);
                              } else {
                                widget.insuranceSelected(
                                    false, currentInsuranceBundlde!);
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

  void updateWheelChair(BuildContext context, List<Bundle>? departureWheelChair,
      List<Bundle>? returnWheelChair) {
    if (okId?.isNotEmpty ?? false) {
      context.read<SearchFlightCubit>().addWheelChairToPerson(
            widget.person,
            departureWheelChair
                ?.firstWhereOrNull((element) => element.codeType == "WCHC"),
            returnWheelChair
                ?.firstWhereOrNull((element) => element.codeType == "WCHC"),
          );
    } else {
      context.read<SearchFlightCubit>().addWheelChairToPerson(
            widget.person,
            departureWheelChair
                ?.firstWhereOrNull((element) => element.codeType == "WCHR"),
            returnWheelChair
                ?.firstWhereOrNull((element) => element.codeType == "WCHR"),
          );
    }
  }

  DateTime infantDOBlimit(DateTime departDate) {
    final now = departDate;
    final limitEnd = now.subtract(const Duration(days: 8));
    return limitEnd;
  }

  Future<void> onFamilyButtonTapped(ProfileCubit profileBloc,
      FilterState filter, BuildContext context) async {
    DateTime userDob =
        profileBloc.state.profile?.userProfile?.dob ?? DateTime.now();

    var limitDate = widget.person.dateLimitStart(filter.departDate);

    int difference = userDob.difference(limitDate).inDays;

    FriendsFamily? selectFamily = await showBottomDialog(
      context,
      FriendsAndFamilySelectorPopUp(
        friendsAndFamily: profileBloc.friendFamily(
            widget.person, filter.departDate ?? DateTime.now()),
        person: widget.person,
        showMySelf: difference > 1,
      ),
    );
    if (selectFamily != null) {
      setFamilyMemberValues(selectFamily, profileBloc);
    }
  }

  void setFamilyMemberValues(
      FriendsFamily selectFamily, ProfileCubit profileBloc) {
    if (selectFamily.memberID == -121 && selectFamily.firstName == 'My') {
      changeSetValue(
          keyName: firstNameKey,
          value: profileBloc.state.profile?.userProfile?.firstName ?? '');
      changeSetValue(
          keyName: lastNameKey,
          value: profileBloc.state.profile?.userProfile?.lastName ?? '');
      if (profileBloc.state.profile?.userProfile?.dob != null) {
        changeSetValue(
            keyName: dobKey,
            value: profileBloc.state.profile?.userProfile?.dob);
      }

      defaultTitle = profileBloc.state.profile?.userProfile?.title;

      changeSetValue(
          keyName: titleKey,
          value: profileBloc.state.profile?.userProfile?.title ?? '');
      if (profileBloc.state.profile?.userProfile?.memberID != null) {
        changeSetValue(
            keyName: rewardKey,
            value: profileBloc.state.profile?.userProfile?.memberID.toString());
      }
    } else {
      changeSetValue(
          keyName: firstNameKey, value: selectFamily.firstName ?? '');
      changeSetValue(keyName: lastNameKey, value: selectFamily.lastName ?? '');

      if (selectFamily.dobDate != null) {
        changeSetValue(keyName: dobKey, value: selectFamily.dobDate);
      }

      defaultTitle = selectFamily.title ?? '';
      changeSetValue(keyName: titleKey, value: selectFamily.title ?? '');

      if (selectFamily.memberID != null) {
        if (selectFamily.memberID == 0) {
        } else {
          changeSetValue(keyName: rewardKey, value: selectFamily.memberID!);
        }
      } else {}
    }
  }

  void changeSetValue({required String keyName, required dynamic value}) {
    BookingDetailsView.fbKey.currentState!.fields[keyName]!.didChange(value);
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
  final Person person;

  final bool showMySelf;

  FriendsAndFamilySelectorPopUp({
    Key? key,
    required this.friendsAndFamily,
    required this.person,
    required this.showMySelf,
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
            if (!showMySelf && friendsAndFamily.isEmpty) ...[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Center(
                    child: Text(
                      'Your family and friends doesnt have ${person.peopleType!.toPersonTypeString()} added',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ] else ...[
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            if (showMySelf && index == 0) {
                              Navigator.pop(
                                  context,
                                  const FriendsFamily(
                                      memberID: -121, firstName: 'My'));

                              return;
                            }
                            Navigator.pop(context,
                                friendsAndFamily[index - (showMySelf ? 1 : 0)]);
                          },
                          child: (showMySelf && index == 0)
                              ? Text(
                                  'I am flying',
                                  style: kMediumRegular.copyWith(
                                      color: Styles.kPrimaryColor),
                                )
                              : Text(
                                  friendsAndFamily[index - (showMySelf ? 1 : 0)]
                                      .fullName,
                                  style: kMediumRegular,
                                ),
                        ),
                        kVerticalSpacer,
                      ],
                    );
                  },
                  itemCount: friendsAndFamily.length + (showMySelf ? 1 : 0),
                ),
              ),
            ],
            kVerticalSpacerMini,
          ],
        ),
      ),
    );
  }
}
