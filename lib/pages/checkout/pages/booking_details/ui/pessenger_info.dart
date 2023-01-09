import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/localizations/localizations_util.dart';
import 'package:app/models/number_person.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../../../../blocs/booking/booking_cubit.dart';
import '../../../../../blocs/search_flight/search_flight_cubit.dart';

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

  bool isNameExtra = false;

  @override
  Widget build(BuildContext context) {
    final passengerInfo = widget.person.passenger;
    final notice = context.watch<CmsSsrCubit>().state.notice;
    final filter = context.watch<FilterCubit>().state;
    final bookingState = context
        .watch<BookingCubit>()
        .state
        .verifyResponse
        ?.flightSSR
        ?.insuranceGroup;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.person.toString(),
            style: kHugeSemiBold,
          ),
        ),
        kVerticalSpacerSmall,
        AutofillGroup(
          child: GreyCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppInputText(
                  name: "${widget.person.toString()}$formNameFirstName",
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
                    }
                    else if(value == 'EXTRA') {
                      setState(() {
                        isNameExtra = true;
                      });

                    }
                    else {
                      setState(() {
                        isNameExtra = false;
                      });
                    }
                  },
                ),
                kVerticalSpacerMini,
                AppInputText(
                  name: "${widget.person.toString()}$formNameLastName",
                  hintText: "Last Name / Surname",
                  initialValue: passengerInfo?.lastName,
                  validators: [FormBuilderValidators.required()],
                ),
                ShadowInput(
                  name: "${widget.person.toString()}$formNameTitle",
                  validators: [FormBuilderValidators.required()],
                  textEditingController: titleController,
                  child: AppDropDown<String>(
                    items: widget.person.peopleType == PeopleType.adult
                        ? availableTitle
                        : availableTitleChild,
                    defaultValue: null,
                    sheetTitle: "Title",
                    onChanged: (value) {
                      titleController.text = value ?? "";
                    },
                  ),
                ),
                kVerticalSpacerMini,
                ShadowInput(
                  textEditingController: nationalityController,
                  name: "${widget.person.toString()}$formNameNationality",
                  child: AppCountriesDropdown(
                    hintText: "Country",
                    isPhoneCode: false,
                    onChanged: (value) {
                      nationalityController.text = value?.countryCode2 ?? "";
                    },
                  ),
                ),
                FormBuilderDateTimePicker(
                  name: "${widget.person.toString()}$formNameDob",
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
                  name: "${widget.person.toString()}$formNameMYRewardId",
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

                if(!isNameExtra) ... [
                  if (bookingState != null) ...[
                    if (bookingState.outbound!.isNotEmpty) ...[
                      Visibility(
                        visible: visible(),
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
                          title: Text(
                              "I want travel protection : MYR${travelProtectionRate(bookingState.outbound!)}"),
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
    if(widget.person.peopleType == PeopleType.infant){
      return true;

    }
    return true;
  }

  int travelProtectionRate(List<Bundle> outbound) {
    currentInsuranceBundlde = outbound.first;

    return outbound.first.amount!.toInt();
  }
}
