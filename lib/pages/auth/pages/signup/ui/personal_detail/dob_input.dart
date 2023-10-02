import 'package:app/pages/auth/pages/signup/signup_wrapper.dart';
import 'package:app/pages/auth/pages/signup/ui/form_header.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

class DobInput extends StatelessWidget {
  const DobInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localObject = context.locale;
    final locale = context.locale.toString();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormHeader(
          title: 'birthdayQuestion'.tr(),
          subtitle: 'birthdayDesc'.tr(),
        ),
        // Text("Birthday", style: kLargeSemiBold),
        // kVerticalSpacer,
        GreyCard(
          edgeInsets: const EdgeInsets.all(8),
          child: FormBuilderDateTimePicker(
            locale: localObject,
            name: formNameDob,
            validator: FormBuilderValidators.required(),
            firstDate: DateTime(1920),
            lastDate: DateTime.now().subtract(Duration(days: 730)),
            format: DateFormat("dd MMM yyyy",locale),
            initialDate: DateTime(2000),
            initialEntryMode: DatePickerEntryMode.calendar,
            decoration: InputDecoration(
                hintText: 'dob'.tr(),
                suffixIcon: const Icon(Icons.calendar_month_sharp),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 12)),
            inputType: InputType.date,
          ),
        ),
      ],
    );
  }
}
