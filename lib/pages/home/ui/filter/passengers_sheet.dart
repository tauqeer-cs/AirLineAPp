import 'package:app/models/number_person.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_sheet_handler.dart';
import 'package:app/widgets/bottom_sheet_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PassengersSheet extends StatefulWidget {
  const PassengersSheet({Key? key}) : super(key: key);

  @override
  PassengersSheetState createState() => PassengersSheetState();
}

class PassengersSheetState extends State<PassengersSheet> {
  @override
  void initState() {
    super.initState();
  }

  changeNumber(PeopleType peopleType, bool isAdd) {
    context
        .read<FilterCubit>()
        .updatePassengers(type: peopleType, isAdd: isAdd);
  }

  @override
  Widget build(BuildContext context) {
    final passengers = context.watch<FilterCubit>().state.numberPerson;
    return Padding(
      padding: kPagePadding,
      child: Wrap(
        children: [
          AppSheetHandler(title: "Passengers", edgeInsets: EdgeInsets.zero),
          InputWithPlusMinus(
            title: "Adults",
            number: passengers.numberOfAdult,
            peopleType: PeopleType.adults,
            handler: changeNumber,
          ),
          InputWithPlusMinus(
            title: "Children",
            number: passengers.numberOfChildren,
            peopleType: PeopleType.children,
            handler: changeNumber,
          ),
          InputWithPlusMinus(
            title: "Infants",
            number: passengers.numberOfInfant,
            peopleType: PeopleType.infants,
            handler: changeNumber,
          ),
        ],
      ),
    );
  }
}

class InputWithPlusMinus extends StatelessWidget {
  final int number;
  final String title;
  final PeopleType peopleType;
  final Function(PeopleType, bool) handler;

  const InputWithPlusMinus({
    Key? key,
    required this.number,
    required this.title,
    required this.handler,
    required this.peopleType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            children: [
              Expanded(flex: 7, child: Text(title)),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 35.h,
                      height: 35.h,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: CircleBorder(), padding: EdgeInsets.zero),
                        onPressed: number > 0
                            ? () => handler(peopleType, false)
                            : null,
                        child: const Icon(
                          Icons.remove,
                          size: 20,
                        ),
                      ),
                    ),
                    Text(number.toString()),
                    SizedBox(
                      width: 35.h,
                      height: 35.h,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: CircleBorder(), padding: EdgeInsets.zero),
                        onPressed: () => handler(peopleType, true),
                        child: const Icon(
                          Icons.add,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
