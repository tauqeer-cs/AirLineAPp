import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/pages/checkout/pages/insurance/bloc/insurance_cubit.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../theme/theme.dart';

class PassengerInsuranceSelector extends StatelessWidget {
  const PassengerInsuranceSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final insuranceCubit = context.watch<InsuranceCubit>().state;
    final passengers = insuranceCubit.passengers;
    final selectedPassengers = insuranceCubit.selectedPassenger;
    print("selected is $selectedPassengers");
    return Column(
      children: [
        Text(
          "Passenger",
          style: kLargeHeavy,
        ),
        kVerticalSpacerSmall,
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
              minHeight: 50,
            ),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: passengers.mapIndexed((index,person) {
                  bool isActive = selectedPassengers == index;
                  return GestureDetector(
                    onTap: () {
                      context.read<InsuranceCubit>().selectPassenger(index);
                    },
                    child: Container(
                      width: 150,
                      margin: EdgeInsets.only(right: 8),
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          color: isActive ? Styles.kActiveColor : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  person.firstName ?? "",
                                  style: kMediumSemiBold.copyWith(
                                      color: isActive ? Colors.white : null),
                                ),
                                kVerticalSpacerMini,
                                Text(
                                  getPersonSelectorText(isActive, person),
                                  style: kMediumSemiBold.copyWith(
                                      color: isActive ? Colors.white : null),
                                ),
                              ],
                            ),
                          )),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        kVerticalSpacerSmall,
      ],
    );
  }

  String getPersonSelectorText(bool isActive, Passenger passenger) {
    if (isActive) return "Selecting";
    if (passenger.ifPassengerHasInsurance != null)
      return passenger.ifPassengerHasInsuranceName ?? "";
    return "No Item Selected";
  }
}
