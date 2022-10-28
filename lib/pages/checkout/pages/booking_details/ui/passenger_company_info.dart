
import 'package:app/blocs/local_user/local_user_bloc.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/booking_details_view.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../theme/theme.dart';

class PassengerCompanyInfo extends StatefulWidget {
  const PassengerCompanyInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<PassengerCompanyInfo> createState() => _PassengerCompanyInfoState();
}

class _PassengerCompanyInfoState extends State<PassengerCompanyInfo> {
  String? name;
  String? address;
  String? state;
  String? city;
  String? postCode;
  String? emailAddress;

  @override
  void initState() {
    super.initState();
    final contact = context.read<LocalUserBloc>().state.companyTaxInvoice;
    name = contact?.companyName;
    address = contact?.companyAddress;
    state = contact?.state;
    city = contact?.city;
    postCode = contact?.postCode;
    emailAddress = contact?.emailAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kVerticalSpacer,
        const AppDividerFadeWidget(),
        kVerticalSpacer,
        const Text("Company Tax Invoice (Optional)", style: kHugeSemiBold),
        kVerticalSpacer,
        AppInputText(
          name: formNameCompanyName,
          initialValue: name,
          hintText: "Company",
          onChanged: (value) {
            final request =
                context.read<LocalUserBloc>().state.companyTaxInvoice;
            final newRequest = request?.copyWith(companyName: value);
            context.read<LocalUserBloc>().add(UpdateCompany(newRequest));
          },
        ),
        kVerticalSpacer,
        AppInputText(
          name: formNameCompanyAddress,
          initialValue: address,
          hintText: "Company Address",
          onChanged: (value) {
            final request =
                context.read<LocalUserBloc>().state.companyTaxInvoice;
            final newRequest = request?.copyWith(companyAddress: value);
            context.read<LocalUserBloc>().add(UpdateCompany(newRequest));
          },
        ),
        kVerticalSpacer,
        const AppCountriesDropdown(
          hintText: "Country",
          isPhoneCode: false,
        ),
        kVerticalSpacer,
        AppInputText(
          name: formNameCompanyState,
          initialValue: state,
          hintText: "State",
          onChanged: (value) {
            final request =
                context.read<LocalUserBloc>().state.companyTaxInvoice;
            final newRequest = request?.copyWith(state: value);
            context.read<LocalUserBloc>().add(UpdateCompany(newRequest));
          },
        ),
        kVerticalSpacer,
        AppInputText(
          name: formNameCompanyCity,
          initialValue: city,
          hintText: "City",
          onChanged: (value) {
            final request =
                context.read<LocalUserBloc>().state.companyTaxInvoice;
            final newRequest = request?.copyWith(city: value);
            context.read<LocalUserBloc>().add(UpdateCompany(newRequest));
          },
        ),
        kVerticalSpacer,
        AppInputText(
          name: formNameCompanyPostCode,
          initialValue: postCode,
          hintText: "Postcode",
          onChanged: (value) {
            final request =
                context.read<LocalUserBloc>().state.companyTaxInvoice;
            final newRequest = request?.copyWith(postCode: value);
            context.read<LocalUserBloc>().add(UpdateCompany(newRequest));
          },
        ),
        kVerticalSpacer,
        AppInputText(
          name: formNameCompanyEmailAddress,
          hintText: "Email Address",
          initialValue: emailAddress,
          validators: [FormBuilderValidators.email()],
          onChanged: (value) {
            final request =
                context.read<LocalUserBloc>().state.companyTaxInvoice;
            final newRequest = request?.copyWith(emailAddress: value);
            context.read<LocalUserBloc>().add(UpdateCompany(newRequest));
          },
        ),
        kVerticalSpacer,
      ],
    );
  }
}