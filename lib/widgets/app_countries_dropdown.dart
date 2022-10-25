import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/countries/countries_cubit.dart';
import 'package:app/blocs/countries/countries_cubit.dart';
import 'package:app/models/country.dart';
import 'package:app/pages/home/ui/filter/dropdown_transformer.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'forms/app_dropdown.dart';

class AppCountriesDropdown extends StatelessWidget {
  final String name;
  final Country? initialValue;
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
          finishedBuilder: AppDropDown<Country>(
            sheetTitle: isPhoneCode ? "Phone" : "Country",
            defaultValue: initialValue ?? Country.defaultCountry,
            onChanged: (country) {
              print(country);
            },
            valueTransformerItem: (value, selected) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isPhoneCode
                        ? "${value?.country} (${value?.phoneCodeDisplay})"
                        : value?.country ?? "",
                    style: kMediumMedium.copyWith(
                      color: selected ? Styles.kPrimaryColor : null,
                    ),
                  ),
                ],
              );
            },
            valueTransformer: (value) {
              return DropdownTransformerWidget<Country>(
                value: value,
                valueCustom: isPhoneCode
                    ? "${value?.country} (${value?.phoneCodeDisplay})"
                    : value?.country,
              );
            },
            items: (state.countries.isNotEmpty
                ? state.countries
                : [Country.defaultCountry]),
          ),
        );
      },
    );
  }
}
