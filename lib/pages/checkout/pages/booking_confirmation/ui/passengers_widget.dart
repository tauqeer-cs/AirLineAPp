import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/string_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassengersWidget extends StatelessWidget {
  const PassengersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passengers = context
            .watch<ConfirmationCubit>()
            .state
            .confirmationModel
            ?.value
            ?.passengers ??
        [];

    int adult = 0;
    int infant = 0;
    int children = 0;
    print("passengers ${passengers.length}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Passengers",
            style: kHugeSemiBold,
          ),
        ),
        kVerticalSpacerSmall,
        ...passengers.mapIndexed(
          (index, e) {
            int number;
            switch (e.getType) {
              case PeopleType.adult:
                adult++;
                number = adult;
                break;
              case PeopleType.child:
                children++;
                number = children;
                break;
              case PeopleType.infant:
                infant++;
                number = infant;
                break;
              case null:
                number = 0;
                break;
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${e.getType?.name.capitalize()} $number"),
                kHorizontalSpacerSmall,
                Expanded(
                  child:
                      Text("${e.titleCode} ${e.givenName} ${e.surname}"),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
