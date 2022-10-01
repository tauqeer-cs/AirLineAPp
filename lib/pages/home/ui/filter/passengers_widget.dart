import 'package:app/models/number_person.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/passengers_sheet.dart';
import 'package:app/widgets/containers/bordered_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dropdown_transformer.dart';

class PassengersWidget extends StatelessWidget {
  const PassengersWidget({Key? key}) : super(key: key);

  _onPeoplePick(BuildContext context) {
    return showModalBottomSheet(

      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (_) => PassengersSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final numberOfPerson = context.watch<FilterCubit>().state.numberPerson;
    return GestureDetector(
      onTap: ()=>_onPeoplePick(context),
      child: BorderedContainer(
        child: DropdownTransformerWidget<NumberPerson>(
          value: numberOfPerson,
          label: "Passengers",
          suffix: Icon(Icons.keyboard_arrow_down_rounded, size: 25,),
        ),
      ),
    );
  }
}


