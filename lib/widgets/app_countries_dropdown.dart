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

class AppCountriesDropdown extends StatefulWidget {
  final Country? initialValue;
  final bool isMMB;

  final bool isPhoneCode;
  final String? hintText, initialCountryCode;
  final List<String? Function(Country?)>? validators;
  final Function(Country?)? onChanged;
  final DropDownDecoratorProps? dropdownDecoration;

  final String? customSheetTitle;
  final  bool hideDefualttValue;
  const AppCountriesDropdown({
    Key? key,
    this.isMMB = false,
    this.initialValue,
    required this.isPhoneCode,
    this.hintText,
    this.initialCountryCode,
    this.validators,
    this.customSheetTitle,
    this.hideDefualttValue = false,
    this.onChanged, this.dropdownDecoration,
  }) : super(key: key);

  @override
  State<AppCountriesDropdown> createState() => AppCountriesDropdownState();
}

class AppCountriesDropdownState extends State<AppCountriesDropdown> {

  var showOverrideValue = false;

  Country? newSelectedCountry;
  String changeCurrentCountry(String countryName) {
    List<Country> countriesList= newList.where((e) => e.country == countryName).toList();

    if(countryName.length == 3){
      countriesList= newList.where((e) => e.countryCode == countryName).toList();
    }
    if(countriesList.isNotEmpty) {
      showOverrideValue = true;



      newSelectedCountry = countriesList.first;
      setState(() {});
      return countriesList.first.countryCode ?? '';

    }

    return '';
  }

  changeCurrentCountryByPhone(String phoneCode) {
    List<Country> countriesList= newList.where((e) => e.phoneCode == phoneCode).toList();


    if(countriesList.isNotEmpty) {
      showOverrideValue = true;
      newSelectedCountry = countriesList.first;
      setState(() {});
    }
  }



  @override
  void initState() {
    super.initState();


  }



  List<Country> newList = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountriesCubit, CountriesState>(
      builder: (context, state) {
        newList = [];
        if (state.countries.isNotEmpty) {
          newList = List<Country>.from(state.countries);
          final my = newList
              .firstWhereOrNull((element) => element == Country.defaultCountry);
          if (my != null) {
            newList.removeWhere((element) => element == my);
            newList.insert(0, my);
          }


        }
        final selectedCountry = widget.initialCountryCode == null
            ? null
            : state.countries.firstWhereOrNull((element) => widget.isPhoneCode
                ? element.phoneCode == widget.initialCountryCode
                : element.countryCode == widget.initialCountryCode);

        return blocBuilderWrapper(
          blocState: state.blocState,
          finishedBuilder: AppDropDownWithSearch<Country>(
            numKey: widget.isPhoneCode,
            sheetTitle: widget.isPhoneCode ? "phone".tr() : "country".tr(),
            defaultValue: showOverrideValue ? newSelectedCountry : (
                 selectedCountry ?? widget.initialValue ?? (widget.isMMB || widget.hideDefualttValue ? null : Country.defaultCountry)),
            onChanged: widget.onChanged,
            dropdownDecoration: widget.dropdownDecoration,
            valueTransformerItem: (value, selected) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.isPhoneCode
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
                valueCustom: widget.isPhoneCode
                    ? "${value?.country} (${value?.phoneCodeDisplay})"
                    : value?.country,
              );
            },

            items: (newList.isNotEmpty ? newList : [Country.defaultCountry]),
            onSearch: (a,b){
              String searchQuery = b;
              Country country = a;
              if(searchQuery.isEmpty) {
                return true;
              }

              searchQuery = searchQuery.toLowerCase();


              if(country.countryCode?.toLowerCase().contains(searchQuery) == true){
                return true;
              }
              if(country.countryCode?.toLowerCase().contains(searchQuery) == true){
                return true;
              }
              if(country.country?.toLowerCase().contains(searchQuery) == true){
                return true;
              }

              if(widget.isPhoneCode) {
                if(country.phoneCode?.toLowerCase().contains(b) == true){

                  return true;
                }
                if(country.phoneCode?.toLowerCase().contains(b) == true){
                  return true;
                }

              }


              return false;

            },
          ),
        );
      },
    );
  }
}
