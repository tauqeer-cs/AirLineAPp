
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

import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../data/responses/manage_booking_response.dart';

class PassengerSelector extends StatelessWidget {
  final bool isContact;
  final bool isDeparture;
  final bool isSeatSelection;
  final AddonType addonType;
  int onCountChanged;

  PassengerSelector({
    Key? key,
    this.isContact = false,
    required this.isDeparture,
    this.isSeatSelection = false,
    required this.addonType,
    required this.onCountChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController scrollPassengerController = ScrollController();
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
	
    double moveToRight = (onCountChanged - 1) * 170;
    Future.delayed(Duration(seconds: 1), () {
      print("onCountChanged ${onCountChanged}");
      if(onCountChanged >= 2) {
        if (scrollPassengerController.hasClients)
          scrollPassengerController.animateTo(
              moveToRight, duration: Duration(seconds: 1),
              curve: Curves.linear);
      }
    });
	
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'passenger'.tr(),
          style: kLargeHeavy,
        ),
        kVerticalSpacerSmall,
        Container(
          constraints: const BoxConstraints(
            minHeight: 50,
          ),
          child: SingleChildScrollView (
            child: Scrollbar(
              child: SingleChildScrollView(
            controller: scrollPassengerController,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: persons.map((person) {
                bool isActive = selectedPerson == person;
                return GestureDetector(
                  onTap: (){
                    context.read<SelectedPersonCubit>().selectPerson(person);
                    var index = persons.indexOf(person);
                    onCountChanged = index;
                  },
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 160),
                    margin: const EdgeInsets.only(right: 8),
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
		  )
		  )
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
          hintText: 'passenger'.tr(),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        )),
        sheetTitle: 'passenger'.tr(),
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


class PassengerSelectorManageBooking extends StatelessWidget {



  final List<PassengersWithSSR> passengersWithSSR;
  final bool isSeatSelection;

  const PassengerSelectorManageBooking({
    Key? key,
    this.isSeatSelection = false,
     required this.passengersWithSSR,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var bloc = context.watch<ManageBookingCubit>();
    final selectedPax =
        context.watch<ManageBookingCubit>().state.selectedPax;




    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "passengers".tr(),
            style: k18Heavy.copyWith(color: Styles.kTextColor),
          ),
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
              children: passengersWithSSR.map((person) {
                bool isActive = false;

                if(selectedPax == person) {
                  isActive = true;
                }



                return GestureDetector(
                  onTap: (){

                    bloc.changeSelectedPax(person);

                   // context.read<SelectedPersonCubit>().selectPerson(person);
                  },
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 160),
                    margin: const EdgeInsets.only(right: 8),
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
                                  person.passengers?.fullName ?? '',
                                  style: kMediumSemiBold.copyWith(
                                      color: isActive ? Colors.white : null),
                                ),
                              ),
                              kVerticalSpacerMini,
                              Text(
                                isActive ? 'selecting'.tr() : 'idle'.tr(),
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


}

class PassengerViewerForSeats extends StatelessWidget {



  final List<PassengersWithSSR> passengersWithSSR;
  final bool isSeatSelection;

  const PassengerViewerForSeats({
    Key? key,
    this.isSeatSelection = false,
    required this.passengersWithSSR,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var bloc = context.watch<ManageBookingCubit>();
    final selectedPax =
        context.watch<ManageBookingCubit>().state.selectedPax;


    var rows = bloc.state.flightSeats?.outbound?.first.retrieveFlightSeatMapResponse?.physicalFlights?.first.physicalFlightSeatMap?.seatConfiguration?.rows ?? [];

    if(bloc.state.seatDeparture == false){
      rows = bloc.state.flightSeats?.inbound?.first.retrieveFlightSeatMapResponse?.physicalFlights?.first.physicalFlightSeatMap?.seatConfiguration?.rows ?? [];
    }



    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "passengers".tr(),
            style: k18Heavy.copyWith(color: Styles.kTextColor),
          ),
        ),
        kVerticalSpacerSmall,
        Container(
          constraints: const BoxConstraints(
            minHeight: 40,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: passengersWithSSR.map((person) {
                bool isActive = false;

                String toShow = 'idle'.tr();
                if(bloc.state.seatDeparture == true) {
                  if(person.personObject?.departureSeats != null) {

                    toShow = person.personObject?.departureSeats?.seatNameToShow(rows) ?? '';

                  }
                }
                else {
                  if(person.personObject?.returnSeats != null) {

                    toShow = person.personObject?.returnSeats?.seatNameToShow(rows) ?? '';

                  }
                }
                  if(selectedPax == person) {
                  isActive = true;
                }



                return GestureDetector(
                  onTap: (){

                    bloc.changeSelectedPax(person);

                  },
                  child: Container(

                    margin: const EdgeInsets.only(right: 0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8,bottom: 8,right: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              person.passengers?.fullName ?? '',
                              style: kMediumHeavy,
                            ),
                          ),
                          kVerticalSpacerMini,
                          Text(
                            isActive ? 'selecting'.tr() : toShow,
                            style: kLargeRegular,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }


}




