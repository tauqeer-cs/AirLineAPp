import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:app/pages/home/ui/filter/dropdown_transformer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/forms/app_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonSelector extends StatelessWidget {
  final bool isContact;
  const PersonSelector({Key? key, this.isContact=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberOfPerson = context.watch<SearchFlightCubit>().state.filterState?.numberPerson;
    final selectedPerson = context.watch<SelectedPersonCubit>().state;
    final persons=List<Person>.from(numberOfPerson?.persons ?? []);
    if(!isContact){
      persons.removeWhere((element) => element.peopleType == PeopleType.infant);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kVerticalSpacer,
        const Text("Passenger", style: kHugeSemiBold),
        kVerticalSpacer,
        PhysicalModel(
          elevation: 5.0,
          shadowColor: const Color(0xff44BD32),
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),

          child: AppDropDown<Person>(
            items: persons,
            defaultValue: selectedPerson,
            onChanged: (val) {
              context.read<SelectedPersonCubit>().selectPerson(val);
            },
            sheetTitle: "Select person",
            isEnabled: true,
            valueTransformer: (value) {
              return DropdownTransformerWidget<Person>(
                value: value,
                prefix: const Icon(
                  Icons.person,
                  size: 20,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
