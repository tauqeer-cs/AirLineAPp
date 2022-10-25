import 'package:app/models/number_person.dart';
import 'package:app/pages/auth/pages/signup/signup_wrapper.dart';
import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class DobInput extends StatelessWidget {
  const DobInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormHeader(
          title: "When's your birthday",
          subtitle:
              "Collect more rewards and points on your birthday month when you fly MYAirline ",
        ),
        // Text("Birthday", style: kLargeSemiBold),
        // kVerticalSpacer,
        GreyCard(
          child: FormBuilderDateTimePicker(
            name: formNameDob,
            firstDate: DateTime(1920),
            lastDate: DateTime.now(),
            format: DateFormat("dd MMM yyyy"),
            initialDate: DateTime(2000),
            initialEntryMode: DatePickerEntryMode.calendar,
            decoration: InputDecoration(
              hintText: "Date of Birth",
              suffixIcon: Icon(Icons.calendar_month_sharp),
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12)
            ),
            inputType: InputType.date,
          ),
        ),
      ],
    );
  }
}
