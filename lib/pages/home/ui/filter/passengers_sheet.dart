import 'package:app/models/number_person.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_sheet_handler.dart';
import 'package:app/widgets/bottom_sheet_header_widget.dart';
import 'package:auto_route/auto_route.dart';
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
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Wrap(
        children: [
          InputWithPlusMinus(
            title: "Adults",
            subtitle: "12 years and above",
            number: passengers.numberOfAdult,
            peopleType: PeopleType.adult,
            handler: changeNumber,
          ),
          InputWithPlusMinus(
            title: "Children",
            subtitle: "2 to 11 years",
            number: passengers.numberOfChildren,
            peopleType: PeopleType.child,
            handler: changeNumber,
          ),
          InputWithPlusMinus(
            subtitle: "Below 2 years",
            title: "Infants",
            number: passengers.numberOfInfant,
            peopleType: PeopleType.infant,
            handler: changeNumber,
          ),
          kVerticalSpacer,
          ElevatedButton(
              onPressed: () {
                context.router.pop();
              },
              child: Text("Confirm"))
        ],
      ),
    );
  }
}

class InputWithPlusMinus extends StatelessWidget {
  final int number;
  final String title;
  final String subtitle;

  final PeopleType peopleType;
  final Function(PeopleType, bool) handler;

  const InputWithPlusMinus({
    Key? key,
    required this.number,
    required this.title,
    required this.handler,
    required this.subtitle,
    required this.peopleType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            children: [
              Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: kLargeSemiBold,
                      ),
                      Text(subtitle, style: kMediumRegular,),
                    ],
                  )),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 30.h,
                      height: 30.h,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent),
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
                      width: 30.h,
                      height: 30.h,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                        ),
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
