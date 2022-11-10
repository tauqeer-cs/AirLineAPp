import 'package:app/models/number_person.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/passengers_sheet.dart';
import 'package:app/widgets/containers/bordered_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dropdown_transformer.dart';

class PassengersWidget extends StatelessWidget {
  const PassengersWidget({Key? key}) : super(key: key);

  _onPeoplePick(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (_) => const PassengersSheet(),
      constraints: BoxConstraints(
        maxWidth: 0.9.sw,
      ),
      backgroundColor: const Color.fromRGBO(235, 235, 235, 0.85),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final numberOfPerson = context.watch<FilterCubit>().state.numberPerson;
    return InkWell(
      onTap: ()=>_onPeoplePick(context),
      child: BorderedContainer(
        child: DropdownTransformerWidget<NumberPerson>(
          value: numberOfPerson == NumberPerson.empty ? null : numberOfPerson,
          label: "Passengers",
          suffix: const Icon(Icons.keyboard_arrow_down_rounded, size: 25,),
        ),
      ),
    );
  }
}


