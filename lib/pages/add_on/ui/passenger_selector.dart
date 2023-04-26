import 'dart:developer';

import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/custom_packages/dropdown_search/dropdown_search.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:app/pages/home/ui/filter/dropdown_transformer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/forms/app_dropdown.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassengerSelector extends StatelessWidget {
  final bool isContact;
  final bool isDeparture;
  final bool isSeatSelection;
  final AddonType addonType;

  const PassengerSelector({
    Key? key,
    this.isContact = false,
    required this.isDeparture,
    this.isSeatSelection = false,
    required this.addonType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberOfPerson =
        context.watch<SearchFlightCubit>().state.filterState?.numberPerson;
    final selectedPerson = context.watch<SelectedPersonCubit>().state;
    final persons = List<Person>.from(numberOfPerson?.persons ?? []);
    final bookingState = context.watch<BookingCubit>().state;
    final flightSeats = bookingState.verifyResponse?.flightSeat;
    final inboundSeats =
        isDeparture ? flightSeats?.outbound : flightSeats?.inbound;
    final rows = inboundSeats
        ?.firstOrNull
        ?.retrieveFlightSeatMapResponse
        ?.physicalFlights
        ?.firstOrNull
        ?.physicalFlightSeatMap
        ?.seatConfiguration
        ?.rows;
    if (!isContact) {
      persons.removeWhere((element) => element.peopleType == PeopleType.infant);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'seatsSelection.passenger'.tr(),
          style: kLargeHeavy,
        ),
        kVerticalSpacerSmall,
        Container(
          constraints: const BoxConstraints(
            minHeight: 50,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: persons.map((person) {
                bool isActive = selectedPerson == person;
                return GestureDetector(
                  onTap: (){
                    context.read<SelectedPersonCubit>().selectPerson(person);
                  },
                  child: Container(
                    constraints: BoxConstraints(minWidth: 160),
                    margin: EdgeInsets.only(right: 8),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: isActive ? Styles.kActiveColor : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  person.generateText(numberOfPerson, separator: "\n"),
                                  style: kMediumSemiBold.copyWith(
                                      color: isActive ? Colors.white : null),
                                ),
                              ),
                              kVerticalSpacerMini,
                              Text(
                                person.getPersonSelectorText(
                                  isActive,
                                  isDeparture,
                                  addonType,
                                  rows: rows ?? [],
                                ),
                                style: kSmallMedium.copyWith(
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
      ],
    );
  }

  AppCard buildPassengerDropDown(List<Person> persons, Person? selectedPerson,
      BuildContext context, NumberPerson? numberOfPerson) {
    return AppCard(
      edgeInsets: EdgeInsets.zero,
      child: AppDropDown<Person>(
        items: persons,
        defaultValue: selectedPerson,
        onChanged: (val) {
          context.read<SelectedPersonCubit>().selectPerson(val);
        },
        dropdownDecoration:  DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          hintText: 'seatsSelection.passenger'.tr(),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        )),
        sheetTitle: 'seatsSelection.passenger'.tr(),
        isEnabled: true,
        valueTransformer: (value) {
          return DropdownTransformerWidget<Person>(
            value: value,
            valueCustom: value?.generateText(numberOfPerson),
            hintText: 'pleaseSelect'.tr(),
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
