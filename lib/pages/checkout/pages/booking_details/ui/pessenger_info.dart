import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/checkout/pages/booking_details/bloc/info/info_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/booking_details_view.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/shadow_input.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/string_utils.dart';
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

class PassengerInfo extends StatefulWidget {
  final Person person;

  const PassengerInfo({Key? key, required this.person}) : super(key: key);

  @override
  State<PassengerInfo> createState() => _PassengerInfoState();
}

class _PassengerInfoState extends State<PassengerInfo> {
  late String nationality;
  final titleController = TextEditingController();
  final nationalityController = TextEditingController();
  final infantAdultName = TextEditingController();

  bool isUnder18 = false;

  @override
  void initState() {
    super.initState();
    nationality = widget.person.passenger?.nationality ?? "MY";
    nationalityController.text = nationality;
  }

  @override
  Widget build(BuildContext context) {
    final passengerInfo = widget.person.passenger;
    final notice = context.watch<CmsSsrCubit>().state.notice;
    final filter = context.watch<FilterCubit>().state;

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
                  },
                ),
                kVerticalSpacerMini,
                AppInputText(
                  name: "${widget.person.toString()}$formNameLastName",
                  hintText: "Last Name/Surname",
                  initialValue: passengerInfo?.lastName,
                  validators: [FormBuilderValidators.required()],
                ),
                ShadowInput(
                  name: "${widget.person.toString()}$formNameTitle",
                  validators: [FormBuilderValidators.required()],
                  textEditingController: titleController,
                  child: AppDropDown<String>(
                    items: widget.person.peopleType == PeopleType.adult ? availableTitle : availableTitleChild,
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
                  firstDate: DateTime(1920),
                  lastDate: DateTime.now(),
                  initialValue: passengerInfo?.dob,
                  format: DateFormat("dd MMM yyyy"),
                  initialDate: passengerInfo?.dob ?? DateTime(2000),
                  initialEntryMode: DatePickerEntryMode.calendar,
                  decoration: const InputDecoration(hintText: "Date of Birth"),
                  inputType: InputType.date,
                  validator: FormBuilderValidators.required(),
                  onChanged: (date) {
                    if (date == null) return;
                    if (AppDateUtils.isUnderage(date)) {
                      setState(() {
                        isUnder18 = true;
                      });
                    }
                  },
                ),
                kVerticalSpacerMini,
                Visibility(
                  visible: (notice?.content?.isNotEmpty ?? false) &&
                      (widget.person.peopleType == PeopleType.adult) &&
                      isUnder18 &&
                      (filter.numberPerson.totalPerson == 1),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                    width: 500.w,
                    decoration: BoxDecoration(
                      color: Color(0xFFECBBC0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(value: true, onChanged: (_) {}),
                        Expanded(child: Html(data: notice?.content ?? "")),
                      ],
                    ),
                  ),
                ),
                kVerticalSpacerMini,
                Visibility(
                  visible: widget.person.peopleType == PeopleType.infant,
                  child: BlocBuilder<InfoCubit, Map<String, String>>(
                    builder: (context, state) {
                      final adultName =
                          state["Adult ${widget.person.numberOrder}"];
                      print("adult name is $adultName");
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
                            bottom: BorderSide(color: Styles.kBorderColor.withOpacity(0.3)),
                          ),
                        ),
                        child: Text("Travel With $string", style: kSmallSemiBold,),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
