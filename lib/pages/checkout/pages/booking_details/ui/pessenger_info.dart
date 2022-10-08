import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/booking_details_view.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/widgets/app_image.dart';
import 'package:app/widgets/forms/app_dropdown.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class PassengerInfo extends StatefulWidget {
  final Person person;

  const PassengerInfo({Key? key, required this.person}) : super(key: key);

  @override
  State<PassengerInfo> createState() => _PassengerInfoState();
}

class _PassengerInfoState extends State<PassengerInfo> {
  late String title;
  late String nationality;

  @override
  void initState() {
    super.initState();
    title = widget.person.passenger?.title ?? "Mr";
    nationality = widget.person.passenger?.nationality ?? "MY";
  }

  @override
  Widget build(BuildContext context) {
    final passengerInfo = widget.person.passenger;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.person.toString(),
          style: kHugeSemiBold,
        ),
        kVerticalSpacer,
        AppInputText(
          name: "${widget.person.toString()}$formNameFirstName",
          hintText: "First Name/Given Name",
          initialValue: passengerInfo?.firstName,
          validators: [FormBuilderValidators.required()],
        ),
        kVerticalSpacer,
        AppInputText(
          name: "${widget.person.toString()}$formNameLastName",
          hintText: "Last Name/Family Name",
          initialValue: passengerInfo?.lastName,
          validators: [FormBuilderValidators.required()],
        ),
        kVerticalSpacer,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderDropdown<String>(
                      name: "${widget.person.toString()}$formNameTitle",
                      items: ["Mr", "Mrs", "Ms"]
                          .map(
                            (e) => DropdownMenuItem<String>(
                              child: Text(e),
                              value: e,
                            ),
                          )
                          .toList(),
                      initialValue: passengerInfo?.title ?? "Mr",
                      validator: FormBuilderValidators.required(),
                    ),
                  ),
                  kHorizontalSpacerMini,
                  Expanded(
                    child: FormBuilderDropdown<String>(
                      name: "${widget.person.toString()}$formNameNationality",
                      items: ["MY"]
                          .map((e) => DropdownMenuItem<String>(
                              child: Text(e), value: e))
                          .toList(),
                      enabled: false,
                      initialValue: passengerInfo?.title ?? "MY",
                      validator: FormBuilderValidators.required(),
                    ),
                  ),
                ],
              ),
            ),
            kHorizontalSpacerMini,
            Expanded(
              child: FormBuilderDateTimePicker(
                name: "${widget.person.toString()}$formNameDob",
                firstDate: DateTime(1920),
                lastDate: DateTime.now(),
                initialValue: passengerInfo?.dob,
                format: DateFormat("dd MMM yyyy"),
                initialDate: passengerInfo?.dob ?? DateTime(2000),
                initialEntryMode: DatePickerEntryMode.calendar,
                decoration: InputDecoration(hintText: "Date of Birth"),
                inputType: InputType.date,
                validator: FormBuilderValidators.required(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
