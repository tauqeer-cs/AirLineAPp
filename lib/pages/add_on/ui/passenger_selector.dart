import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/custom_packages/dropdown_search/dropdown_search.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:app/pages/home/ui/filter/dropdown_transformer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/forms/app_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassengerSelector extends StatelessWidget {
  final bool isContact;
  final bool isDeparture;

  final bool isSeatSelection;


  const PassengerSelector({Key? key, this.isContact = false, required this.isDeparture, this.isSeatSelection = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberOfPerson =
        context.watch<SearchFlightCubit>().state.filterState?.numberPerson;
    final selectedPerson = context.watch<SelectedPersonCubit>().state;
    final persons = List<Person>.from(numberOfPerson?.persons ?? []);
    if (!isContact) {
      persons.removeWhere((element) => element.peopleType == PeopleType.infant);
    }
    return AppCard(
      edgeInsets: EdgeInsets.zero,
      child: AppDropDown<Person>(
        items: persons,
        defaultValue: selectedPerson,
        onChanged: (val) {
          context.read<SelectedPersonCubit>().selectPerson(val);
        },
        dropdownDecoration: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            border: InputBorder.none,
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            hintText:  "Passenger",
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          )
        ),
        sheetTitle: "Passenger",
        isEnabled: true,
        valueTransformer: (value) {
          return DropdownTransformerWidget<Person>(
            value: value,
            valueCustom: value?.generateText(numberOfPerson),
            hintText: "Please Select",
          );
        },
        valueTransformerItem: (value, selected) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value?.generateText(numberOfPerson) ?? "",
                style: kMediumMedium.copyWith(
                  color: selected ? Styles.kPrimaryColor : null,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
