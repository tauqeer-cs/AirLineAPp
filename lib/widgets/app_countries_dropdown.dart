import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/countries/countries_cubit.dart';
import 'package:app/blocs/countries/countries_cubit.dart';
import 'package:app/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AppCountriesDropdown extends StatelessWidget {
  final String name;
  final String? initialValue;
  final bool isPhoneCode;
  final String? hintText;
  final List<String? Function(Country?)>? validators;

  const AppCountriesDropdown(
      {Key? key,
      required this.name,
      this.initialValue,
      required this.isPhoneCode,
      this.hintText,
      this.validators})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountriesCubit, CountriesState>(
      builder: (context, state) {
        return blocBuilderWrapper(
          blocState: state.blocState,
          finishedBuilder: FormBuilderDropdown<Country>(
              validator: FormBuilderValidators.compose(validators ?? []),
              decoration: InputDecoration(
                hintText: hintText,
              ),
              name: name,
              items: (state.countries.isNotEmpty
                      ? state.countries
                      : [
                          Country(
                            countryCode: "MY",
                            phoneCode: "60",
                            phoneCodeDisplay: "+60",
                            country: "Malaysia",
                            countryCode2: "MYS",
                          )
                        ])
                  .map(
                    (e) => DropdownMenuItem<Country>(
                      child: Text(
                          (isPhoneCode ? e.phoneCodeDisplay : e.country) ?? ""),
                      value: e,
                    ),
                  )
                  .toList()),
        );
      },
    );
  }
}
