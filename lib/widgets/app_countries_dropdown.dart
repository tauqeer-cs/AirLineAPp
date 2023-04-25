import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/countries/countries_cubit.dart';
import 'package:app/custom_packages/dropdown_search/dropdown_search.dart';
import 'package:app/models/country.dart';
import 'package:app/pages/home/ui/filter/dropdown_transformer.dart';
import 'package:app/theme/theme.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'forms/app_dropdown.dart';

class AppCountriesDropdown extends StatelessWidget {
  final Country? initialValue;
  final bool isPhoneCode;
  final String? hintText, initialCountryCode;
  final List<String? Function(Country?)>? validators;
  final Function(Country?)? onChanged;
  final DropDownDecoratorProps? dropdownDecoration;

  const AppCountriesDropdown({
    Key? key,
    this.initialValue,
    required this.isPhoneCode,
    this.hintText,
    this.initialCountryCode,
    this.validators,
    this.onChanged,
    this.dropdownDecoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountriesCubit, CountriesState>(
      builder: (context, state) {
        List<Country> newList = [];
        if (state.countries.isNotEmpty) {
          newList = List<Country>.from(state.countries);
          final my = newList
              .firstWhereOrNull((element) => element == Country.defaultCountry);
          if (my != null) {
            newList.removeWhere((element) => element == my);
            newList.insert(0, my);
          }
        }
        final selectedCountry = initialCountryCode == null
            ? null
            : state.countries.firstWhereOrNull((element) => isPhoneCode
                ? element.phoneCode == initialCountryCode
                : element.countryCode2 == initialCountryCode);

        return blocBuilderWrapper(
          blocState: state.blocState,
          finishedBuilder: AppDropDown<Country>(
            sheetTitle: isPhoneCode ? "phone".tr() : "country".tr(),
            defaultValue:
                selectedCountry ?? initialValue ?? Country.defaultCountry,
            onChanged: onChanged,
            dropdownDecoration: dropdownDecoration,
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
            items: (newList.isNotEmpty ? newList : [Country.defaultCountry]),
          ),
        );
      },
    );
  }
}
