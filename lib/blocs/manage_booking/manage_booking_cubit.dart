import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:paged_vertical_calendar/utils/date_utils.dart';
import '../../app/app_bloc_helper.dart';
import '../../app/app_flavor.dart';
import '../../data/repositories/flight_repository.dart';
import '../../data/repositories/manage_book_repository.dart';
import '../../data/requests/assign_flight_addon_request.dart';
import '../../data/requests/assign_flight_addon_request.dart' as AS;
import '../../data/requests/boarding_pass_request.dart';
import '../../data/requests/book_request.dart';
import '../../data/requests/change_flight_request.dart';
import '../../data/requests/check_in_request.dart';
import '../../data/requests/flight_summary_pnr_request.dart';
import '../../data/requests/flight_summary_pnr_request.dart' as FS;
import '../../data/requests/flight_summary_pnr_request.dart';
import '../../data/requests/get_flight_addon_request.dart';
import '../../data/requests/manage_booking_request.dart';
import '../../data/requests/mmb_checkout_request.dart';
import '../../data/requests/search_change_flight_request.dart';
import '../../data/requests/search_flight_request.dart';
import '../../data/requests/token_request.dart';
import '../../data/requests/update_booking_contacts.dart';
import '../../data/requests/verify_request.dart';
import '../../data/responses/change_ssr_response.dart';
import '../../data/responses/flight_add_ons_response.dart';
import '../../data/responses/flight_add_ons_response.dart' as FR;
import '../../data/responses/flight_response.dart';
import '../../data/responses/manage_booking_response.dart';
import '../../data/responses/manage_booking_response.dart' as MBR;
import '../../data/responses/promotions_response.dart';
import '../../models/confirmation_model.dart';
import '../../models/confirmation_model.dart' as CN;

import '../../data/responses/verify_response.dart';
import '../../data/responses/verify_response.dart' as Vs;
import '../../models/number_person.dart';
import '../../models/pay_redirection.dart';
import '../../pages/checkout/pages/insurance/bloc/insurance_cubit.dart';
import '../../utils/error_utils.dart';
import '../../data/responses/change_flight_response.dart';
import 'package:flutter/material.dart';

part 'manage_booking_state.dart';

part 'manage_booking_cubit.g.dart';

class ManageBookingCubit extends Cubit<ManageBookingState> {
  ManageBookingCubit()
      : super(
          const ManageBookingState(),
        );

  final _repository = ManageBookingRepository();

  DateTime get minDate {
    var ccc = state.manageBookingResponse;

    if (ccc?.isTwoWay ?? false) {
      if (state.checkedDeparture == true && state.checkReturn == false) {
        return DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .removeTime();
      } else if (state.checkedDeparture == false && state.checkReturn == true) {
        return ccc?.currentStartDate?.removeTime().add(
                  const Duration(days: 0),
                ) ??
            DateTime.now();
      }
    }
    return DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day)
        .removeTime();
  }

  String get currentCurrency {
    return state.manageBookingResponse?.result?.fareAndBundleDetail
            ?.fareAndBundles?.first.currency ??
        'MYR';
  }

  DateTime get maxDate {
    var ccc = state.manageBookingResponse;
    if (ccc?.isTwoWay ?? false) {
      if (state.checkedDeparture == true && state.checkReturn == false) {
        return ccc?.currentEndDate?.removeTime().add(
                  const Duration(days: 0),
                ) ??
            DateTime.now();
      } else if (state.checkedDeparture == false && state.checkReturn == true) {
        return DateTime.now().add(const Duration(days: 365)).removeTime();
      }
    }
    return DateTime.now().add(const Duration(days: 365)).removeTime();
  }

  String get changeFeePerPerson {
    return '80.0';
  }

  num get departureTotal {
    return 50;
  }

  num get returnTotal {
    return 60;
  }

  num get newSeatsTotalPrice {
    num total = 0.0;

    List<PassengersWithSSR> passengers =
        state.manageBookingResponse?.result?.passengersWithSSR ?? [];

    for (PassengersWithSSR currentUser in passengers) {
      total +=
          currentUser.newDepartSeatSelected?.seatPriceOffers?.first.amount ??
              0.0;
      total +=
          currentUser.newReturnSeatSelected?.seatPriceOffers?.first.amount ??
              0.0;
    }
    return total;
  }

  num get notConfirmedSeatsTotalPrice {
    num total = 0.0;

    List<PassengersWithSSR> passengers =
        state.manageBookingResponse?.result?.passengersWithSSR ?? [];

    for (PassengersWithSSR currentUser in passengers) {
      if (currentUser.newDepartSeatSelected != null) {
        total += currentUser
            .newDepartSeatSelected?.seatPriceOffers?.first.amount ??
            0.0;

        var tmpS = state.manageBookingResponse?.result?.seatDetail?.seats
            ?.where((element) =>
        element.givenName == currentUser.passengers?.givenName &&
            element.surName == currentUser.passengers?.surname &&
            element.departReturn == 'Depart')
            .toList();

        if ((tmpS ?? []).isNotEmpty) {
          total = total - ((tmpS ?? []).first.amount ?? 0.0);
        }
      }

      if (currentUser.newReturnSeatSelected != null) {
        total += currentUser
            .newReturnSeatSelected?.seatPriceOffers?.first.amount ??
            0.0;

        var tmpS = state.manageBookingResponse?.result?.seatDetail?.seats
            ?.where((element) =>
        element.givenName == currentUser.passengers?.givenName &&
            element.surName == currentUser.passengers?.surname &&
            element.departReturn != 'Depart')
            .toList();

        if ((tmpS ?? []).isNotEmpty) {
          total = total - ((tmpS ?? []).first.amount ?? 0.0);
        }
      }
    }
    return total;
  }


  num get confirmedSeatsTotalPrice {
    num total = 0.0;

    List<PassengersWithSSR> passengers =
        state.manageBookingResponse?.result?.passengersWithSSR ?? [];

    for (PassengersWithSSR currentUser in passengers) {
      if (currentUser.confirmedDepartSeatSelected != null) {
        total += currentUser
                .confirmedDepartSeatSelected?.seatPriceOffers?.first.amount ??
            0.0;

        var tmpS = state.manageBookingResponse?.result?.seatDetail?.seats
            ?.where((element) =>
                element.givenName == currentUser.passengers?.givenName &&
                element.surName == currentUser.passengers?.surname &&
                element.departReturn == 'Depart')
            .toList();

        if ((tmpS ?? []).isNotEmpty) {
          total = total - ((tmpS ?? []).first.amount ?? 0.0);
        }
      }

      if (currentUser.confirmedReturnSeatSelected != null) {
        total += currentUser
                .confirmedReturnSeatSelected?.seatPriceOffers?.first.amount ??
            0.0;

        var tmpS = state.manageBookingResponse?.result?.seatDetail?.seats
            ?.where((element) =>
        element.givenName == currentUser.passengers?.givenName &&
            element.surName == currentUser.passengers?.surname &&
                element.departReturn != 'Depart')
            .toList();

        if ((tmpS ?? []).isNotEmpty) {
          total = total - ((tmpS ?? []).first.amount ?? 0.0);
        }
      }
    }
    return total;
  }

  num get notConfirmedWheelChairTotalPrice {
    num total = 0.0;

    List<PassengersWithSSR> passengers =
        state.manageBookingResponse?.result?.passengersWithSSR ?? [];
    for (PassengersWithSSR currentUser in passengers) {
      total += currentUser.newDepartWheelChair?.finalAmount ?? 0.0;
      total += currentUser.newReturnWheelChair?.finalAmount ?? 0.0;
    }

    return total;
  }

  num get confirmedWheelChairTotalPrice {
    num total = 0.0;

    List<PassengersWithSSR> passengers =
        state.manageBookingResponse?.result?.passengersWithSSR ?? [];

    for (PassengersWithSSR currentUser in passengers) {
      total += currentUser.confirmDepartWheelChair?.finalAmount ?? 0.0;

      total += currentUser.confirmReturnWheelChair?.finalAmount ?? 0.0;
    }

    return total;
  }

  num get notConfirmedBaggageTotalPrice {
    num total = 0.0;

    List<PassengersWithSSR> passengers =
        state.manageBookingResponse?.result?.passengersWithSSR ?? [];

    for (PassengersWithSSR currentUser in passengers) {
      total += currentUser.newDepartBaggageSelected?.finalAmount ?? 0.0;

      total += currentUser.newReturnBaggageSelected?.finalAmount ?? 0.0;

      total += currentUser.newDepartSportsSelected?.finalAmount ?? 0.0;

      total += currentUser.newReturnSportsSelected?.finalAmount ?? 0.0;

    }

    return total;
  }


  num get confirmedBaggageTotalPrice {
    num total = 0.0;

    List<PassengersWithSSR> passengers =
        state.manageBookingResponse?.result?.passengersWithSSR ?? [];

    for (PassengersWithSSR currentUser in passengers) {
      total += currentUser.confirmDepartBaggageSelected?.finalAmount ?? 0.0;
      total += currentUser.confirmReturnBaggageSelected?.finalAmount ?? 0.0;

      //total += currentUser.confirmedDepartSportsSelected?.finalAmount ?? 0.0;
      //total += currentUser.confirmedReturnSportsSelected?.finalAmount ?? 0.0;

    }

    return total;
  }

  num get confirmedSportsTotalPrice {
    num total = 0.0;

    List<PassengersWithSSR> passengers =
        state.manageBookingResponse?.result?.passengersWithSSR ?? [];

    for (PassengersWithSSR currentUser in passengers) {
      //total += currentUser.confirmDepartBaggageSelected?.finalAmount ?? 0.0;
      //total += currentUser.confirmReturnBaggageSelected?.finalAmount ?? 0.0;

      total += currentUser.confirmedDepartSportsSelected?.finalAmount ?? 0.0;
      total += currentUser.confirmedReturnSportsSelected?.finalAmount ?? 0.0;

    }

    return total;
  }


  num get confirmedInsruanceTotalPrice {
    if((state.flightSSR?.insuranceGroup?.outbound ?? []).isEmpty ){
      return 0.0;
    }
    num total = 0.0;
    var totalPerPax  = state.flightSSR?.insuranceGroup?.outbound?.first.finalAmount ?? 0.0;

    List<PassengersWithSSR> passengers =
        state.manageBookingResponse?.result?.passengersWithSSR ?? [];
    if(state.confirmedInsuranceType == InsuranceType.all) {

      total = totalPerPax * passengers.length;

    }
    else if(state.confirmedInsuranceType == InsuranceType.selected){
      for (PassengersWithSSR currentUser in passengers) {
        total += currentUser.confirmedInsuranceBundleSelected?.finalAmount ?? 0.0;
      }

    }





    return total;
  }


  num get notConfirmedMealsTotalPrice {
    num total = 0.0;

    List<PassengersWithSSR> passengers =
        state.manageBookingResponse?.result?.passengersWithSSR ?? [];

    for (PassengersWithSSR currentUser in passengers) {
      num? totalAmount = currentUser.newDepartureMeal
          ?.map((bundle) => bundle.amount ?? 0)
          .fold(0, (previousValue, amount) => (previousValue ?? 0) + amount);

      if (totalAmount != null) {
        total += totalAmount;
      }

      totalAmount = currentUser.newReturnMeal
          ?.map((bundle) => bundle.amount ?? 0)
          .fold(0, (previousValue, amount) => (previousValue ?? 0) + amount);

      if (totalAmount != null) {
        total += totalAmount;
      }
    }
    return total;
  }

  num get confirmedMealsTotalPrice {
    num total = 0.0;

    List<PassengersWithSSR> passengers =
        state.manageBookingResponse?.result?.passengersWithSSR ?? [];

    for (PassengersWithSSR currentUser in passengers) {
      num? totalAmount = currentUser.confirmedDepartMeals
          ?.map((bundle) => bundle.amount ?? 0)
          .fold(0, (previousValue, amount) => (previousValue ?? 0) + amount);

      if (totalAmount != null) {
        total += totalAmount;
      }

      totalAmount = currentUser.confirmedReturnMeals
          ?.map((bundle) => bundle.amount ?? 0)
          .fold(0, (previousValue, amount) => (previousValue ?? 0) + amount);

      if (totalAmount != null) {
        total += totalAmount;
      }
    }
    return total;
  }

  void selectedDepartureFlight(InboundOutboundSegment segment) {
    emit(
      state.copyWith(selectedDepartureFlight: segment),
    );
  }

  bool isWithinTwoYears(DateTime date) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);
    return difference.inDays < 365 * 2;
  }

  double get passengerCount {
    return passengersWithSSRNotBaby.length.toDouble();
  }

  /*
  void makeVerifyRequest() async {
    final _repository = FlightRepository();

    const outboundLFID = '68563';
    const outboundFBCode = 'WLH001MM';

    const inboundLFID = '68640';
    const inboundFBCode = 'WLH001MM';

    final inboundFares =
        OutboundFares(fbCode: inboundFBCode, lfid: inboundLFID);
    final outboundFares =
        OutboundFares(fbCode: outboundFBCode, lfid: outboundLFID);

    var outboundSegment =
        state.manageBookingResponse?.result?.flightSegments?.first.outbound;
    var inboundSegment =
        state.manageBookingResponse?.result?.flightSegments?.first.inbound;

    var commonRuest = CommonFlightRequest(
        originAirport:
            outboundSegment?.first.departureAirportLocationCode ?? '',
        destinationAirport:
            outboundSegment?.first.arrivalAirportLocationCode ?? '',
        departDate: outboundSegment?.first.departureDateTime?.toIso8601String(),
        returnDate: inboundSegment?.first.departureDateTime?.toIso8601String(),
        adults: 2,
        childrens: 1,
        infants: 1,
        isReturn: true,
        tripType: 'Round Trip',
        outboundFares: [outboundFares],
        inboundFares: [inboundFares],
        totalAmount: 426.0,
        promoCode: '');
    print('');

    var request = VerifyRequest(flightVerifyRequest: commonRuest);
    final verifyResponse = await _repository.verifyFlight(request);
    List<Person> allPeople = [];

    var outBoundSeatRows = verifyResponse
        .flightSeat
        ?.outbound
        ?.first
        .retrieveFlightSeatMapResponse
        ?.physicalFlights
        ?.first
        .physicalFlightSeatMap
        ?.seatConfiguration
        ?.rows;
    var inBoundSeatRows = verifyResponse
        .flightSeat
        ?.outbound
        ?.first
        .retrieveFlightSeatMapResponse
        ?.physicalFlights
        ?.first
        .physicalFlightSeatMap
        ?.seatConfiguration
        ?.rows;

    var mainObject = state.manageBookingResponse;

    final seatsDeparture = verifyResponse.flightSSR?.seatGroup?.outbound ?? [];
    final seatsReturn = verifyResponse.flightSSR?.seatGroup?.inbound ?? [];

    final wheelChairDeparture =
        verifyResponse.flightSSR?.wheelChairGroup?.outbound ?? [];
    final wheelChairReturn =
        verifyResponse.flightSSR?.wheelChairGroup?.inbound ?? [];

    int personIndex = 0;

    List<int> seatIdsToMakeAvailableDep = [];
    List<int> seatIdsToMakeAvailableReturn = [];

    for (PassengersWithSSR currentPerson
        in mainObject?.result?.passengersWithSSR ?? []) {
      personIndex = personIndex + 1;

      var result = currentPerson.seatDetail?.seats
          ?.where((e) => e.departReturn == 'Depart')
          .toList();

      var result2 = currentPerson.seatDetail?.seats
          ?.where((e) => e.departReturn == 'Return')
          .toList();

      Vs.Seats? departureSeats;

      if (result?.isNotEmpty ?? false) {
        String input = result?.first.seatPosition ?? '';
        if (input.isNotEmpty) {
          RegExp regex = RegExp(r'([A-Za-z]+)(\d+)');
          var match = regex.firstMatch(input);

          String? characterPart = match?.group(1); // C
          String? numberPart = match?.group(2); // 17

          int seatNo = int.tryParse(numberPart ?? '') ?? 0;

          var ress =
              outBoundSeatRows?.where((e) => e.rowNumber == seatNo).toList();

          if (ress?.isNotEmpty ?? false) {
            var finalSeat = ress?.first.seats
                ?.where((e) => e.seatColumn == characterPart)
                .toList()
                .first;

            departureSeats = finalSeat;

            seatIdsToMakeAvailableDep.add(int.parse(finalSeat?.seatId ?? ''));
          }

          print('');
        }
      }
      Vs.Seats? returnSeats;

      if (result2?.isNotEmpty ?? false) {
        String input = result2?.first.seatPosition ?? '';
        if (input.isNotEmpty) {
          RegExp regex = RegExp(r'([A-Za-z]+)(\d+)');
          var match = regex.firstMatch(input);

          String? characterPart = match?.group(1); // C
          String? numberPart = match?.group(2); // 17

          int seatNo = int.tryParse(numberPart ?? '') ?? 0;

          var ress =
              inBoundSeatRows?.where((e) => e.rowNumber == seatNo).toList();

          if (ress?.isNotEmpty ?? false) {
            var finalSeat = ress?.first.seats
                ?.where((e) => e.seatColumn == characterPart)
                .toList()
                .first;

            returnSeats = finalSeat;

            seatIdsToMakeAvailableReturn
                .add(int.parse(finalSeat?.seatId ?? '') ?? 0);

            print('');
          }

          print('');
        }
      }

      List<Bundle> departureMeal = [];
      List<Bundle> returnMeal = [];

      Bundle? departureBaggage;
      Bundle? returnBaggage;

      Bundle? departureSports;
      Bundle? returnSports;

      //Depart

      var departMealsSelected = currentPerson.mealDetail?.departureMealsOnly;
      var returnMealsSelected = currentPerson.mealDetail?.returnMealsOnly;

      for (MealList currentIte in departMealsSelected ?? []) {
        //Nasi Lemak Combo
        List<Bundle> result = verifyResponse.flightSSR?.mealGroup?.outbound
                ?.where((e) =>
                    e.description?.toLowerCase() ==
                    currentIte.mealName?.toLowerCase())
                .toList() ??
            [];

        if (result.isNotEmpty) {
          departureMeal.add(result.first);
        }
        print('');
      }

      for (MealList currentIte in returnMealsSelected ?? []) {
        //Nasi Lemak Combo
        List<Bundle> result = verifyResponse.flightSSR?.mealGroup?.inbound
                ?.where((e) =>
                    e.description?.toLowerCase() ==
                    currentIte.mealName?.toLowerCase())
                .toList() ??
            [];

        if (result.isNotEmpty) {
          returnMeal.add(result.first);
        }
        print('');
      }

      var departBagSelected = currentPerson.baggageDetail?.departureBaggages;
      var returnBagSelected = currentPerson.baggageDetail?.returnBaggages;

      for (Baggage currentIte in departBagSelected ?? []) {
        List<Bundle> result = verifyResponse.flightSSR?.baggageGroup?.outbound
                ?.where((e) =>
                    e.description?.toLowerCase() ==
                    currentIte.baggageName?.toLowerCase())
                .toList() ??
            [];

        if (result.isNotEmpty) {
          departureBaggage = result.first;
        }
      }

      for (Baggage currentIte in returnBagSelected ?? []) {
        List<Bundle> result = verifyResponse.flightSSR?.baggageGroup?.inbound
                ?.where((e) =>
                    e.description?.toLowerCase() ==
                    currentIte.baggageName?.toLowerCase())
                .toList() ??
            [];

        if (result.isNotEmpty) {
          returnBaggage = result.first;
        }
      }

      var departSportSelected =
          currentPerson.sportEquipmentDetail?.departureBaggages;
      var returnSportsSelected =
          currentPerson.sportEquipmentDetail?.returnBaggages;

      for (Baggage currentIte in departSportSelected ?? []) {
        //Nasi Lemak Combo
        List<Bundle> result = verifyResponse.flightSSR?.sportGroup?.outbound
                ?.where((e) =>
                    e.description?.toLowerCase() ==
                    currentIte.sportEquipmentName?.toLowerCase())
                .toList() ??
            [];

        if (result.isNotEmpty) {
          departureSports = result.first;
        }
        print('');
      }

      Baggage? wheelDeparts;
      // if(currentPerson.wheelChairDetail.)
      var departWheelChaorOdThisUser = currentPerson
          .wheelChairDetail?.wheelChairs
          ?.where((e) => e.departReturn == 'Depart')
          .toList();
      if ((departWheelChaorOdThisUser ?? []).isNotEmpty) {
        wheelDeparts = (departWheelChaorOdThisUser ?? []).first;
      }
      Baggage? wheelReturn;
      departWheelChaorOdThisUser = currentPerson.wheelChairDetail?.wheelChairs
          ?.where((e) => e.departReturn != 'Depart')
          .toList();
      if ((departWheelChaorOdThisUser ?? []).isNotEmpty) {
        wheelReturn = departWheelChaorOdThisUser ?? [].first;
      }

      Bundle? selectedDepartWheelChairItem;
      Bundle? selectedReturnWheelChairItem;

      if (wheelDeparts != null) {
        //yes here
        var selectedWheels = wheelChairDeparture
            .where(
                (e) => e.finalAmount.toInt() == wheelDeparts?.amount?.toInt())
            .toList();

        if ((selectedWheels ?? []).isNotEmpty) {
          selectedDepartWheelChairItem = selectedWheels.first;
          print('');
        }
      }

      if (wheelReturn != null) {
        //yes here
        var selectedWheels = wheelChairReturn
            .where((e) => e.finalAmount.toInt() == wheelReturn?.amount?.toInt())
            .toList();

        if ((selectedWheels ?? []).isNotEmpty) {
          selectedReturnWheelChairItem = selectedWheels.first;
          print('');
        }
      }
      for (Baggage currentIte in returnSportsSelected ?? []) {
        List<Bundle> result = verifyResponse.flightSSR?.sportGroup?.inbound
                ?.where((e) =>
                    e.description?.toLowerCase() ==
                    currentIte.sportEquipmentName?.toLowerCase())
                .toList() ??
            [];

        if (result.isNotEmpty) {
          returnSports = result.first;
        }
      }


      PeopleType type;

      if (currentPerson.passengers?.passengerType == 'INF') {
        type = PeopleType.infant;
      } else if (currentPerson.passengers?.passengerType == 'CHD') {
        type = PeopleType.child;
      } else {
        type = PeopleType.adult;
      }

      var currentObject = Person(
          peopleType: type,
          departureMeal: departureMeal,
          returnMeal: returnMeal,
          departureSeats: departureSeats,
          returnSeats: returnSeats,
          departureBaggage: departureBaggage,
          returnBaggage: returnBaggage,
          departureSports: departureSports,
          returnSports: returnSports,
          numberOrder: personIndex,
          departureWheelChair: selectedDepartWheelChairItem,
          returnWheelChair: selectedReturnWheelChairItem);
      currentPerson.personObject = currentObject;
      currentPerson.originalDepartSeatId =
          int.parse(departureSeats?.seatId ?? '');
      var princrTlist = seatsDeparture
          .where((e) =>
              e.description?.toLowerCase() ==
              departureSeats?.serviceDescription?.toLowerCase())
          .toList();

      if (princrTlist.isNotEmpty) {
        currentPerson.originalDepartSeatPrice =
            (princrTlist.first.amount?.toDouble() ?? 0.0) +
                (princrTlist.first.applicableTaxes?.first.taxAmount
                        ?.toDouble() ??
                    0.0);
        ;
      }

      currentPerson.originalReturnSeatId = int.parse(returnSeats?.seatId ?? '');
      princrTlist = seatsReturn
          .where((e) =>
              e.description?.toLowerCase() ==
              returnSeats?.serviceDescription?.toLowerCase())
          .toList();

      if (princrTlist.isNotEmpty) {
        currentPerson.originalReturnSeatPrice =
            (princrTlist.first.amount?.toDouble() ?? 0.0) +
                (princrTlist.first.applicableTaxes?.first.taxAmount
                        ?.toDouble() ??
                    0.0);
      }
      currentPerson.originalHadWheelChairDepart =
          selectedDepartWheelChairItem != null;
      currentPerson.originalHadWheelChairReturn =
          selectedReturnWheelChairItem != null;

      currentPerson.originalDepartBaggageCode = departureBaggage?.codeType;
      currentPerson.originalDepartBaggagePrice =
          departureBaggage?.finalAmount.toDouble();
      currentPerson.originalReturnBaggageCode = returnBaggage?.codeType;
      currentPerson.originalReturnBaggagePrice =
          returnBaggage?.finalAmount.toDouble();

      currentPerson.originalDepartSportsCode = departureSports?.codeType;
      currentPerson.originalReturnSportsCode = returnSports?.codeType;
      currentPerson.originalDepartSportsPrice =
          departureSports?.finalAmount.toDouble();
      currentPerson.originalReturnSportsPrice =
          returnSports?.finalAmount.toDouble();

      //  currentPerson.copyWith(personObject: currentObject);
      print('');
    }

    var outboundRows = verifyResponse
        .flightSeat
        ?.outbound
        ?.first
        .retrieveFlightSeatMapResponse
        ?.physicalFlights
        ?.first
        .physicalFlightSeatMap
        ?.seatConfiguration
        ?.rows;

    int indexItem = 0;

    for (Rows currentItem in outboundRows ?? []) {
      //seatIdsToMakeAvailableDep
      var res = currentItem.seats
          ?.where((e) => seatIdsToMakeAvailableDep.contains(e.seatId))
          .toList();

      if ((res ?? []).isNotEmpty) {
        var indexOfSeat = currentItem.seats?.indexOf((res ?? []).first);

        var copyObject = (res ?? []).first.copyWith(isSeatAvailable: true);
        var currenT = currentItem.seats ?? [];
        print('');

        currenT.removeAt(indexOfSeat ?? 0);
        currenT.insert(indexOfSeat ?? 0, copyObject);
      }

      indexItem++;
    }

    print('');

    emit(state.copyWith(
        verifyResponse: verifyResponse,
        manageBookingResponse: mainObject,

    ));

    print('');

    //VerifyRequest();
  }
*/

  bool get showPayOption {
    for(PassengersWithSSR currentPerson in state.manageBookingResponse?.result?.passengersWithSSR ?? []) {

      if(currentPerson.confirmedDepartSeatSelected != null) {

        return true;
      }

      if(currentPerson.confirmedReturnSeatSelected != null) {

        return true;
      }

      if((currentPerson.confirmedDepartMeals ?? []).isNotEmpty )  {

        return true;
      }

      if((currentPerson.confirmedReturnMeals ?? []).isNotEmpty )  {

        return true;
      }

      if(currentPerson.confirmDepartBaggageSelected != null) {

        return true;
      }

      if(currentPerson.confirmReturnBaggageSelected != null) {

        return true;
      }



      if(currentPerson.confirmDepartWheelChair != null) {

        return true;
      }

      if(currentPerson.confirmReturnWheelChair != null) {

        return true;
      }

      if(state.insuranceType == InsuranceType.all) {

        if(state.manageBookingResponse?.allInsuranceBundleSelected != null) {
          return true;
        }

      }
      else if(state.insuranceType == InsuranceType.selected) {

        if(currentPerson.newInsuranceBoundSelected != null) {
          return true;
        }
      }




    }
    return false;

  }

  void setSsrOfUser() {
    /*
    var outBoundSeatRows = verifyResponse
        .flightSeat
        ?.outbound
        ?.first
        .retrieveFlightSeatMapResponse
        ?.physicalFlights
        ?.first
        .physicalFlightSeatMap
        ?.seatConfiguration
        ?.rows;
    * */
    List<Rows>? outBoundSeatRows = state
        .flightSeats
        ?.outbound
        ?.first
        .retrieveFlightSeatMapResponse
        ?.physicalFlights
        ?.first
        .physicalFlightSeatMap
        ?.seatConfiguration
        ?.rows;
    List<Rows>? inBoundSeatRows = [];

    if ((state.flightSeats?.inbound ?? []).isNotEmpty) {
      state
          .flightSeats
          ?.inbound
          ?.first
          .retrieveFlightSeatMapResponse
          ?.physicalFlights
          ?.first
          .physicalFlightSeatMap
          ?.seatConfiguration
          ?.rows;
    }

    var mainObject = state.manageBookingResponse;

    final wheelChairDeparture =
        state.flightSSR?.wheelChairGroup?.outbound ?? [];
    final wheelChairReturn = state.flightSSR?.wheelChairGroup?.inbound ?? [];

    int personIndex = 0;

    List<String> seatIdsToMakeAvailableDep = [];
    List<String> seatIdsToMakeAvailableReturn = [];

    for (PassengersWithSSR currentPerson
        in mainObject?.result?.passengersWithSSR ?? []) {
      personIndex = personIndex + 1;

      var result = currentPerson.seatDetail?.seats
          ?.where((e) => e.departReturn == 'Depart')
          .toList();

      var result2 = currentPerson.seatDetail?.seats
          ?.where((e) => e.departReturn == 'Return')
          .toList();

      Vs.Seats? departureSeats;

      if (result?.isNotEmpty ?? false) {
        String input = result?.first.seatPosition ?? '';
        if (input.isNotEmpty) {
          RegExp regex = RegExp(r'([A-Za-z]+)(\d+)');
          var match = regex.firstMatch(input);

          String? characterPart = match?.group(1); // C
          String? numberPart = match?.group(2); // 17

          int seatNo = int.tryParse(numberPart ?? '') ?? 0;

          var ress =
              outBoundSeatRows?.where((e) => e.rowNumber == seatNo).toList();

          if (ress?.isNotEmpty ?? false) {
            var finalSeat = ress?.first.seats
                ?.where((e) => e.seatColumn == characterPart)
                .toList()
                .first;

            departureSeats = finalSeat;

            seatIdsToMakeAvailableDep.add((finalSeat?.seatId ?? ''));
          }

          print('');
        }
      }
      Vs.Seats? returnSeats;

      if (result2?.isNotEmpty ?? false) {
        String input = result2?.first.seatPosition ?? '';
        if (input.isNotEmpty) {
          RegExp regex = RegExp(r'([A-Za-z]+)(\d+)');
          var match = regex.firstMatch(input);

          String? characterPart = match?.group(1); // C
          String? numberPart = match?.group(2); // 17

          int seatNo = int.tryParse(numberPart ?? '') ?? 0;

          var ress =
              inBoundSeatRows.where((e) => e.rowNumber == seatNo).toList();

          if (ress?.isNotEmpty ?? false) {
            var finalSeat = ress?.first.seats
                ?.where((e) => e.seatColumn == characterPart)
                .toList()
                .first;
            returnSeats = finalSeat;
            seatIdsToMakeAvailableReturn.add((finalSeat?.seatId ?? '') ?? '');
          }
        }
      }

      List<Bundle> departureMeal = [];
      List<Bundle> returnMeal = [];

      Bundle? departureBaggage;
      Bundle? returnBaggage;

      Bundle? departureSports;
      Bundle? returnSports;


      var departMealsSelected = currentPerson.mealDetail?.departureMealsOnly;
      var returnMealsSelected = currentPerson.mealDetail?.returnMealsOnly;

      for (MealList currentIte in departMealsSelected ?? []) {
        //Nasi Lemak Combo
        List<Bundle> result = state.flightSSR?.mealGroup?.outbound
                ?.where((e) =>
                    e.description?.toLowerCase() ==
                    currentIte.mealName?.toLowerCase())
                .toList() ??
            [];

        if (result.isNotEmpty) {
          departureMeal.addAll((result) ) ;
        }
        print('');
      }

      for (MealList currentIte in returnMealsSelected ?? []) {
        //Nasi Lemak Combo
        List<Bundle> result = state.flightSSR?.mealGroup?.inbound
                ?.where((e) =>
                    e.description?.toLowerCase() ==
                    currentIte.mealName?.toLowerCase())
                .toList() ??
            [];

        if (result.isNotEmpty) {
          returnMeal.addAll(result);
        }
        print('');
      }

      var departBagSelected = currentPerson.baggageDetail?.departureBaggages;
      var returnBagSelected = currentPerson.baggageDetail?.returnBaggages;

      for (Baggage currentIte in departBagSelected ?? []) {
        List<Bundle> result = state.flightSSR?.baggageGroup?.outbound
                ?.where((e) =>
                    e.codeType?.toLowerCase() ==
                    currentIte.baggageName?.toLowerCase())
                .toList() ??
            [];

        if (result.isNotEmpty) {
          departureBaggage = result.first;
        }
      }

      for (Baggage currentIte in returnBagSelected ?? []) {
        List<Bundle> result = state.flightSSR?.baggageGroup?.inbound
                ?.where((e) =>
                    e.codeType?.toLowerCase() ==
                    currentIte.baggageName?.toLowerCase())
                .toList() ??
            [];

        if (result.isNotEmpty) {
          returnBaggage = result.first;
        }
      }

      var departSportSelected =
          currentPerson.sportEquipmentDetail?.departureBaggages;
      var returnSportsSelected =
          currentPerson.sportEquipmentDetail?.returnBaggages;

      for (Baggage currentIte in departSportSelected ?? []) {
        //Nasi Lemak Combo
        List<Bundle> result = state.flightSSR?.sportGroup?.outbound
                ?.where((e) =>
                    e.description?.toLowerCase() ==
                    currentIte.sportEquipmentName?.toLowerCase())
                .toList() ??
            [];

        if (result.isNotEmpty) {
          departureSports = result.first;
        }
        print('');
      }

      Baggage? wheelDeparts;
      // if(currentPerson.wheelChairDetail.)
      var departWheelChaorOdThisUser = currentPerson
          .wheelChairDetail?.wheelChairs
          ?.where((e) => e.departReturn == 'Depart')
          .toList();
      if ((departWheelChaorOdThisUser ?? []).isNotEmpty) {
        wheelDeparts = (departWheelChaorOdThisUser ?? []).first;
      }
      Baggage? wheelReturn;
      departWheelChaorOdThisUser = currentPerson.wheelChairDetail?.wheelChairs
          ?.where((e) => e.departReturn != 'Depart')
          .toList();
      if ((departWheelChaorOdThisUser ?? []).isNotEmpty) {
        wheelReturn = (departWheelChaorOdThisUser ?? []).first;
      }

      Bundle? selectedDepartWheelChairItem;
      Bundle? selectedReturnWheelChairItem;

      if (wheelDeparts != null) {
        //yes here
        var selectedWheels = wheelChairDeparture
            .where(
                (e) => e.finalAmount.toInt() == wheelDeparts?.amount?.toInt())
            .toList();

        if ((selectedWheels ?? []).isNotEmpty) {
          selectedDepartWheelChairItem = selectedWheels.first;
          print('');
        }
      }

      if (wheelReturn != null) {
        //yes here
        var selectedWheels = wheelChairReturn
            .where((e) => e.finalAmount.toInt() == wheelReturn?.amount?.toInt())
            .toList();

        if ((selectedWheels ?? []).isNotEmpty) {
          selectedReturnWheelChairItem = selectedWheels.first;
          print('');
        }
      }
      for (Baggage currentIte in returnSportsSelected ?? []) {
        List<Bundle> result = state.flightSSR?.sportGroup?.inbound
                ?.where((e) =>
                    e.description?.toLowerCase() ==
                    currentIte.sportEquipmentName?.toLowerCase())
                .toList() ??
            [];

        if (result.isNotEmpty) {
          returnSports = result.first;
        }
      }

      PeopleType type;

      if (currentPerson.passengers?.passengerType == 'INF') {
        type = PeopleType.infant;
      } else if (currentPerson.passengers?.passengerType == 'CHD') {
        type = PeopleType.child;
      } else {
        type = PeopleType.adult;
      }

      var currentObject = Person(
          peopleType: type,
          departureMeal: departureMeal,
          returnMeal: returnMeal,
          departureSeats: departureSeats,
          returnSeats: returnSeats,
          departureBaggage: departureBaggage,
          returnBaggage: returnBaggage,
          departureSports: departureSports,
          returnSports: returnSports,
          numberOrder: personIndex,
          departureWheelChair: selectedDepartWheelChairItem,
          returnWheelChair: selectedReturnWheelChairItem);
      currentPerson.personObject = currentObject;
      currentPerson.seatDetail;

      currentPerson.originalDepartSeatId = (departureSeats?.seatId ?? '');


      currentPerson.originalDepartSeatPrice = departureSeats?.seatPriceOffers?.first.amount ?? 0.0;
      currentPerson.originalReturnSeatPrice = returnSeats?.seatPriceOffers?.first.amount ?? 0.0;


      currentPerson.originalReturnSeatId = (returnSeats?.seatId ?? '');


      currentPerson.originalHadWheelChairDepart =
          selectedDepartWheelChairItem != null;
      currentPerson.originalHadWheelChairReturn =
          selectedReturnWheelChairItem != null;

      currentPerson.originalDepartBaggageCode = departureBaggage?.codeType;
      currentPerson.originalDepartBaggagePrice =
          departureBaggage?.finalAmount.toDouble();
      currentPerson.originalReturnBaggageCode = returnBaggage?.codeType;
      currentPerson.originalReturnBaggagePrice =
          returnBaggage?.finalAmount.toDouble();

      currentPerson.originalDepartSportsCode = departureSports?.codeType;
      currentPerson.originalReturnSportsCode = returnSports?.codeType;
      currentPerson.originalDepartSportsPrice =
          departureSports?.finalAmount.toDouble();
      currentPerson.originalReturnSportsPrice =
          returnSports?.finalAmount.toDouble();

      //  currentPerson.copyWith(personObject: currentObject);
      print('');
    }

    List<Rows>? outboundRows = state.flightSeats?.outbound?.first.retrieveFlightSeatMapResponse!.physicalFlights!.first.physicalFlightSeatMap!.seatConfiguration!.rows;
    /*
    verifyResponse
        .flightSeat
        ?.outbound
        ?.first
        .retrieveFlightSeatMapResponse
        ?.physicalFlights
        ?.first
        .physicalFlightSeatMap
        ?.seatConfiguration
        ?.rows;*/

    int indexItem = 0;

    for (Rows currentItem in outboundRows ?? []) {
      //seatIdsToMakeAvailableDep
      var res = currentItem.seats
          ?.where((e) => seatIdsToMakeAvailableDep.contains(e.seatId))
          .toList();

      if ((res ?? []).isNotEmpty) {
        var indexOfSeat = currentItem.seats?.indexOf((res ?? []).first);

        var copyObject = (res ?? []).first.copyWith(isSeatAvailable: true);
        var currenT = currentItem.seats ?? [];
        print('');

        currenT.removeAt(indexOfSeat ?? 0);
        currenT.insert(indexOfSeat ?? 0, copyObject);
      }

      indexItem++;
    }

    print('');

    emit(state.copyWith(
      manageBookingResponse: mainObject,
    ));
  }

  String onePersonTotalToShowDepart(String personName) {
    if (state.changeFlightResponse?.result?.changeFlightResponse
            ?.flightBreakDown?.departDetail?.flightPaxNameList !=
        null) {
      var object = state.changeFlightResponse?.result?.changeFlightResponse
          ?.flightBreakDown?.departDetail!.flightPaxNameList!
          .firstWhere((e) =>
              ('${e.givenName ?? ''} ${e.surname ?? ''}').toLowerCase() ==
              personName.toLowerCase());

      if (object != null) {
        return (object.changeAmount ?? 0.0).toDouble().toStringAsFixed(2);
      }
    }

    return '0.0';
  }

  String onePersonTotalToShowReturn(String personName) {
    if (state.changeFlightResponse?.result?.changeFlightResponse
            ?.flightBreakDown?.returnDetail?.flightPaxNameList !=
        null) {
      var object = state.changeFlightResponse?.result?.changeFlightResponse
          ?.flightBreakDown?.returnDetail!.flightPaxNameList!
          .firstWhere((e) =>
              ('${e.givenName ?? ''} ${e.surname ?? ''}').toLowerCase() ==
              personName.toLowerCase());

      if (object != null) {
        return (object.changeAmount ?? 0.0).toStringAsFixed(2);
      }
    }

    return '0.0';
  }

  String onePersonTotalToShow(String personName) {
    return (double.parse(onePersonTotalToShowDepart(personName)) +
            double.parse(onePersonTotalToShowReturn(personName)))
        .toStringAsFixed(2);
  }

  List<PassengersWithSSR> get passengersWithSSRNotBaby {
    var currentIterter = state.manageBookingResponse?.result?.passengersWithSSR;
    List<PassengersWithSSR> result = [];

    for (PassengersWithSSR currentItem in currentIterter ?? []) {
      if (!isWithinTwoYears(currentItem.passengers?.dob ?? DateTime.now())) {
        result.add(currentItem);
      }
    }
    return result;
  }

  double? get totalAmountToShowInChangeFlight {
    num totalChange = 0.0;

    var currentIterter = state.manageBookingResponse?.result?.passengersWithSSR;

    int multiplier = 0;

    for (PassengersWithSSR currentItem in currentIterter ?? []) {
      if (!isWithinTwoYears(currentItem.passengers?.dob ?? DateTime.now())) {
        multiplier++;
      }
    }

    multiplier = 1;

    if (state.selectedDepartureFlight != null) {
      totalChange =
          (state.selectedDepartureFlight?.changeFlightAmountToShow ?? 0.0) *
              multiplier;
    }

    if (state.selectedReturnFlight != null) {
      totalChange = totalChange +
          (state.selectedReturnFlight?.changeFlightAmountToShow ?? 0.0) *
              multiplier;
    }

    return totalChange.toDouble();
  }

  bool get showChangeButton {
    if (state.manageBookingResponse!.isTwoWay) {
      if (state.checkReturn == true && state.checkedDeparture == true) {
        if (state.selectedDepartureFlight != null &&
            state.selectedReturnFlight != null) {
          return true;
        }
      } else if (state.checkReturn == true && state.checkedDeparture == false) {
        if (state.selectedReturnFlight != null) {
          return true;
        }
      } else if (state.checkReturn == false && state.checkedDeparture == true) {
        if (state.selectedDepartureFlight != null) {
          return true;
        }
      }
    } else {
      if (state.selectedDepartureFlight != null) {
        return true;
      }
    }

    return false;
  }

  void selectedReturnFlight(InboundOutboundSegment segment) {
    emit(
      state.copyWith(
          selectedReturnFlight: segment,
          message: '',
          blocState: BlocState.initial),
    );
  }

  Future<void> reloadDataForConfirmation(String status, String superPnr,{bool extraLoading = false}) async {
    emit(
      state.copyWith(
          loadingSummary: true,
          message: '',
          blocState: BlocState.initial,
          extraLoading: extraLoading,
          showPending: status == 'PPB'),
    );

    try {
      if (status == 'PPB') {
        print('');

        emit(
          state.copyWith(
            loadingSummary: false,
          ),
        );
        return;
      }
      final verifyResponse = await _repository.getBookingInfo(
        ManageBookingRequest(pnr: state.pnrEntered, lastname: state.lastName),
      );

      emit(
        state.copyWith(
          blocState: BlocState.finished,
          manageBookingResponse: verifyResponse,
          loadingSummary: false,
          isPaying : false,
          extraLoading: false,
        ),
      );
      return;
    } catch (e, st) {
      emit(
        state.copyWith(
          message: ErrorUtils.getErrorMessage(e, st),
          blocState: BlocState.failed,
          loadingSummary: false,
          extraLoading: false
        ),
      );
      return;
    }
  }

  updateStartDate(DateTime date) async {
    var newBookingObject = state.manageBookingResponse;
    if (state.manageBookingResponse?.isTwoWay == true &&
        state.checkedDeparture == false &&
        state.checkReturn == true) {
      newBookingObject?.customSelected = true;

      newBookingObject?.newStartDateSelected = null;
      newBookingObject?.newReturnDateSelected = date;

      emit(
        state.copyWith(message: '', manageBookingResponse: newBookingObject),
      );
      return;
    } else if (state.manageBookingResponse?.isTwoWay == true &&
        state.checkedDeparture == true &&
        state.checkReturn == false) {
      newBookingObject?.customSelected = true;
      newBookingObject?.newReturnDateSelected = null;

      newBookingObject?.newStartDateSelected = date;

      emit(
        state.copyWith(
            message: '',
            blocState: BlocState.finished,
            manageBookingResponse: newBookingObject),
      );
      return;
    } else if (state.manageBookingResponse?.isOneWay ?? true) {
      newBookingObject?.customSelected = true;
      newBookingObject?.newReturnDateSelected = null;

      newBookingObject?.newStartDateSelected = date;

      emit(
        state.copyWith(message: '', manageBookingResponse: newBookingObject),
      );
      return;
    }
    if (newBookingObject?.customSelected == true &&
        newBookingObject?.newStartDateSelected != null) {
      newBookingObject?.customSelected = false;
      newBookingObject?.newReturnDateSelected = date;

      emit(
        state.copyWith(message: '', manageBookingResponse: newBookingObject),
      );
      return;
    }
    newBookingObject?.customSelected = true;
    newBookingObject?.newReturnDateSelected = null;

    newBookingObject?.newStartDateSelected = date;

    emit(
      state.copyWith(message: '', manageBookingResponse: newBookingObject),
    );
  }

  Future<String?> getAvailableFlights(
      DateTime? startDate, DateTime? endDate) async {
    try {
      var request = SearchChangeFlightRequest.makeRequestObject(
          pnr: state.pnrEntered ?? '',
          lastName: state.lastName ?? '',
          startDate: state.manageBookingResponse?.newStartDateSelected ??
              DateTime.now().add(const Duration(days: 7)),
          endDate: state.manageBookingResponse?.newReturnDateSelected ??
              DateTime.now().add(const Duration(days: 17)));

      if (state.checkedDeparture && state.checkReturn) {
      } else if ((state.manageBookingResponse!.isOneWay) ||
          state.checkedDeparture) {
        request = SearchChangeFlightRequest.makeRequestObject(
            pnr: state.pnrEntered ?? '',
            lastName: state.lastName ?? '',
            startDate: state.manageBookingResponse?.newStartDateSelected ??
                DateTime.now().add(const Duration(days: 7)),
            endDate: null);
      } else if (state.checkReturn) {
        request = SearchChangeFlightRequest.makeRequestObject(
            pnr: state.pnrEntered ?? '',
            lastName: state.lastName ?? '',
            startDate: null,
            endDate: state.manageBookingResponse?.newReturnDateSelected ??
                DateTime.now().add(const Duration(days: 17)));
      }
      //setFlightDates

      emit(
        state.copyWith(
          message: '',
          loadingDatesData: true,
        ),
      );

      var response = await _repository.getAvailableFlights(request);

      emit(
        state.copyWith(
          flightSearchResponse: response,
          loadingDatesData: false,
          removeSelectedReturn: true,
          removeSelectedDeparture: true,
        ),
      );

      return null;
    } catch (e, st) {
      state.copyWith(
        loadingDatesData: false,
      );

      return ErrorUtils.getErrorMessage(e, st, dontShowError: true);
    }
  }

  Future<ChangeSsrResponse?> checkSsrChange() async {
    emit(
      state.copyWith(
        isPaying: true,
      ),
    );
    try {


    var request = RequestAssignFlightAddOnRequest();

    request.assignFlightAddOnRequest = AssignFlightAddOnRequest();
    request.assignFlightAddOnRequest?.lastName = state.lastName;
    request.assignFlightAddOnRequest?.pNR = state.pnrEntered;

    List<PassengerAddOn>? passengerAddOn = [];

    for (PassengersWithSSR currentItem
        in state.manageBookingResponse?.result?.passengersWithSSR ?? []) {
      var tmpPassengerAddOn = PassengerAddOn();
      tmpPassengerAddOn.passengerKey = currentItem.personOrgID;

      tmpPassengerAddOn.sSR = AS.SSR(outbound: [], inbound: []);

      if (currentItem.confirmedDepartMeals != null) {
        if (currentItem.confirmedDepartMeals!.isNotEmpty) {
          List<String?>? ssrCodesList = currentItem.confirmedDepartMeals!
              .map((bundle) => bundle.ssrCode)
              .where((ssrCode) => ssrCode != null)
              .toSet()
              .toList();

          if (ssrCodesList.isNotEmpty) {
            for (int i = 0; i < ssrCodesList.length; i++) {
              String currentString = ssrCodesList[i] ?? '';

              tmpPassengerAddOn.sSR?.outbound?.add(FS.Bound(
                logicalFlightId: currentItem.confirmedDepartMeals!
                        .where((e) => e.ssrCode == currentString)
                        .toList()
                        .first
                        .logicalFlightID ??
                    '',
                ssrCode: currentString,
                servicesType: 'MEAL',
                quantity: currentItem.confirmedDepartMeals!
                        .where((e) => e.ssrCode == currentString)
                        .toList()
                        .length ??
                    0,
              ));
            }
          }
        }
      }

      if (currentItem.confirmedReturnMeals != null) {
        if (currentItem.confirmedReturnMeals!.isNotEmpty) {
          List<String?>? ssrCodesList = currentItem.confirmedReturnMeals!
              .map((bundle) => bundle.ssrCode)
              .where((ssrCode) => ssrCode != null)
              .toSet()
              .toList();

          if (ssrCodesList.isNotEmpty) {
            for (int i = 0; i < ssrCodesList.length; i++) {
              String currentString = ssrCodesList[i] ?? '';

              tmpPassengerAddOn.sSR?.inbound?.add(FS.Bound(
                logicalFlightId: currentItem.confirmedReturnMeals!
                        .where((e) => e.ssrCode == currentString)
                        .toList()
                        .first
                        .logicalFlightID ??
                    '',
                ssrCode: currentString,
                servicesType: 'MEAL',
                quantity: currentItem.confirmedReturnMeals!
                        .where((e) => e.ssrCode == currentString)
                        .toList()
                        .length ??
                    0,
              ));
            }
          }
        }
      }

      if (currentItem.confirmDepartBaggageSelected != null) {
        tmpPassengerAddOn.sSR?.outbound?.add(
          FS.Bound(
            logicalFlightId:
                currentItem.confirmDepartBaggageSelected?.logicalFlightID,
            ssrCode: currentItem.confirmDepartBaggageSelected?.ssrCode ?? '',
            servicesType: 'BAGGAGE',
            quantity: 1,
          ),
        );
      }

      if (currentItem.confirmedDepartSportsSelected != null) {
        tmpPassengerAddOn.sSR?.outbound?.add(
          FS.Bound(
            logicalFlightId:
            currentItem.confirmedDepartSportsSelected?.logicalFlightID,
            ssrCode: currentItem.confirmedDepartSportsSelected?.ssrCode ?? '',
            servicesType: 'SPORT',
            quantity: 1,
          ),
        );
      }


      if (currentItem.confirmReturnBaggageSelected != null) {
        tmpPassengerAddOn.sSR?.inbound?.add(
          FS.Bound(
            logicalFlightId:
                currentItem.confirmDepartBaggageSelected?.logicalFlightID,
            ssrCode: currentItem.confirmDepartBaggageSelected?.ssrCode ?? '',
            servicesType: 'BAGGAGE',
            quantity: 1,
          ),
        );
      }

      if (currentItem.confirmedReturnSportsSelected != null) {
        tmpPassengerAddOn.sSR?.inbound?.add(
          FS.Bound(
            logicalFlightId:
            currentItem.confirmedReturnSportsSelected?.logicalFlightID,
            ssrCode: currentItem.confirmedReturnSportsSelected?.ssrCode ?? '',
            servicesType: 'SPORT',
            quantity: 1,
          ),
        );
      }


      if (currentItem.confirmDepartWheelChair != null) {
        tmpPassengerAddOn.sSR?.outbound?.add(
          FS.Bound(
            logicalFlightId:
                currentItem.confirmDepartWheelChair?.logicalFlightID,
            ssrCode: currentItem.confirmDepartWheelChair?.ssrCode ?? '',
            servicesType: 'WheelChair',
            quantity: 1,
          ),
        );
      }

      if (currentItem.confirmReturnWheelChair != null) {
        tmpPassengerAddOn.sSR?.inbound?.add(
          FS.Bound(
            logicalFlightId:
                currentItem.confirmDepartWheelChair?.logicalFlightID,
            ssrCode: currentItem.confirmDepartWheelChair?.ssrCode ?? '',
            servicesType: 'WheelChair',
            quantity: 1,
          ),
        );
      }

      if(state.confirmedInsuranceType == InsuranceType.all) {

        if(state.manageBookingResponse?.confirmedInsuranceBoundSelected != null) {
          tmpPassengerAddOn.sSR?.outbound?.add(
            FS.Bound(
              logicalFlightId:
              state.manageBookingResponse?.confirmedInsuranceBoundSelected?.logicalFlightId ??
                  '',
              ssrCode: state.manageBookingResponse?.confirmedInsuranceBoundSelected?.ssrCode ??
                  '',
              servicesType: 'Insurance',
              quantity: 1,
            ),
          );
        }
      }
      else if(state.confirmedInsuranceType == InsuranceType.selected){


        if(currentItem.confirmedInsuranceBundleSelected != null) {
          tmpPassengerAddOn.sSR?.outbound?.add(
            FS.Bound(
              logicalFlightId:
              currentItem.confirmedInsuranceBundleSelected?.logicalFlightID ??
                  '',
              ssrCode: currentItem.confirmedInsuranceBundleSelected?.ssrCode ??
                  '',
              servicesType: 'Insurance',
              quantity: 1,
            ),
          );
        }

      }


      if (currentItem.confirmedDepartSeatSelected != null) {
        var ccc = state.addOnList?.flightSeats?.outbound?.first
            .retrieveFlightSeatMapResponse?.physicalFlights;
        var result = ccc?.first.physicalFlightSeatMap?.seatConfiguration?.rows
            ?.where((e) =>
                e.rowId == currentItem.confirmedDepartSeatSelected?.rowId)
            .first;

        tmpPassengerAddOn.seat = AS.Seat(
          outbound: Outbound(
              physicalFlightId: departPhysicalFlightIdForSeat ??
                  currentItem.confirmedDepartSeatSelected?.seatId ??
                  '',
              seatRow: result?.rowNumber ??
                  currentItem.confirmedDepartSeatSelected?.rowId,
              seatColumn:
                  currentItem.confirmedDepartSeatSelected?.seatColumn ?? ''),
        );
      }

      if (currentItem.confirmedReturnSeatSelected != null) {
        var ccc = state.addOnList?.flightSeats?.inbound?.first
            .retrieveFlightSeatMapResponse?.physicalFlights;
        var result = ccc?.first.physicalFlightSeatMap?.seatConfiguration?.rows
            ?.where((e) =>
        e.rowId == currentItem.confirmedDepartSeatSelected?.rowId)
            .first;

        if(tmpPassengerAddOn.seat != null) {
          tmpPassengerAddOn.seat!.inbound = Outbound(
              physicalFlightId: returnPhysicalFlightIdForSeat ??
                  currentItem.confirmedReturnSeatSelected?.seatId ??
                  '',
              seatRow: result?.rowNumber ??
                  currentItem.confirmedReturnSeatSelected?.rowId,
              seatColumn:
              currentItem.confirmedReturnSeatSelected?.seatColumn ?? '');


      }
        else {
          tmpPassengerAddOn.seat = AS.Seat(
            inbound: Outbound(
                physicalFlightId: returnPhysicalFlightIdForSeat ??
                    currentItem.confirmedReturnSeatSelected?.seatId ??
                    '',
                seatRow: result?.rowNumber ??
                    currentItem.confirmedReturnSeatSelected?.rowId,
                seatColumn:
                currentItem.confirmedReturnSeatSelected?.seatColumn ?? ''),
          );
        }
        }


      print('');
      passengerAddOn.add(tmpPassengerAddOn);
    }

    request.assignFlightAddOnRequest?.passengerAddOn = passengerAddOn;

    //print('');
    ChangeSsrResponse response =
        await _repository.setAssignFlightAddon(request);

    return response;



    }
    catch (e, st) {
      emit(
        state.copyWith(
            message: ErrorUtils.getErrorMessage(e, st, dontShowError: true),
            isPaying: false,
        ),
      );
      return null;
    }

  }

  String? departPhysicalFlightIdForSeat;
  String? returnPhysicalFlightIdForSeat;

  String? oringalPNRNo;

  Future<bool?> getBookingInformation(
      String lastName, String bookingReference,{bool? showError}) async {
    emit(
      state.copyWith(
        isLoadingInfo: true,
        message: '',
      ),
    );

    try {
      final verifyResponse = await _repository.getBookingInfo(
        ManageBookingRequest(pnr: bookingReference, lastname: lastName),
      );

      oringalPNRNo = verifyResponse.result?.superPNR?.superPNRNo;

      if (verifyResponse.result?.passengersWithSSRWithoutInfant.first != null) {
        PassengersWithSSR? v =
            verifyResponse.result?.passengersWithSSRWithoutInfant.first;

        changeSelectedPax(v!);
      }

      //  String? pNR;
      //   String? lastName;
      //   bool? isInternational;
      var flightRequest = GetFlightAddonRequest(
          pNR: bookingReference,
          lastName: lastName,
          isInternational: verifyResponse.result?.isRequiredPassport ?? false);
      FightAddOns addOns =
          await _repository.getFlightAddonRequest(flightRequest);

      var selected = state.selectedPax;

      departPhysicalFlightIdForSeat = addOns
          .flightSeats
          ?.outbound
          ?.first
          .retrieveFlightSeatMapResponse
          ?.physicalFlights
          ?.first
          .physicalFlightID;

      if(state.manageBookingResponse?.result?.isReturn == true) {

        if((addOns
            .flightSeats
            ?.inbound ?? []) .isNotEmpty) {
          returnPhysicalFlightIdForSeat = addOns
              .flightSeats
              ?.inbound
              ?.first
              .retrieveFlightSeatMapResponse
              ?.physicalFlights
              ?.first
              .physicalFlightID;
        }


      }



      var whichOne = addOns.paxAddOnSSR
          ?.where((e) => e.passengerKey == selected?.personOrgID)
          .toList();

      emit(
        state.copyWith(
            flightSeats: addOns.flightSeats,
            flightSSR: whichOne?.first.flightSSR,
            addOnList: addOns,
            blocState: BlocState.finished,
            dataLoaded: true,
            manageBookingResponse: verifyResponse,
            isLoadingInfo: false,
            checkedDeparture: false,
            checkReturn: false,
            superPnrNo: '',
            orderId: 0,
            pnrEntered: bookingReference,
            lastName: lastName),
      );

      setSsrOfUser();
      //makeVerifyRequest();

      return true;
    } catch (e, st) {
      emit(
        state.copyWith(
            message: ErrorUtils.getErrorMessage(e, st, dontShowError: showError ?? true),
            blocState: BlocState.failed,
            isLoadingInfo: false,
            dataLoaded: false),
      );
      return false;
    }
  }

  void setCheckDeparture(bool value) {
    emit(
      state.copyWith(
        checkedDeparture: value,
        message: '',
      ),
    );
  }

  void setCheckReturn(bool value) {
    emit(
      state.copyWith(
        checkReturn: value,
        message: '',
      ),
    );
  }

  void setDepartureFlight(InboundOutboundSegment segment) {
    emit(
      state.copyWith(
        selectedDepartureFlight: segment,
        message: '',
      ),
    );
  }

  void setReturnFlight(InboundOutboundSegment segment) {
    state.copyWith(selectedReturnFlight: segment);

    emit(
      state.copyWith(selectedReturnFlight: segment),
    );
  }

  void removeDepartureFlight(InboundOutboundSegment segment) {
    emit(
      state.copyWithNull(selectedDepartureFlight: true),
    );
  }

  void removeReturnFlight(InboundOutboundSegment segment) {
    emit(state.copyWithNull(selectedReturnFlight: true));
  }

  Future<bool?> changeFlight() async {
    try {
      var departureDate =
          '${state.selectedDepartureFlight?.departureDate?.toIso8601String() ?? ''}Z'; //  ';
      var returnDate =
          '${state.selectedReturnFlight?.departureDate?.toIso8601String() ?? ''}Z'; //  ';

      var request = ChangeFlightRequest(
          pNR: state.pnrEntered,
          lastName: state.lastName,
          isReturn: true,
          departDate: departureDate,
          returnDate: returnDate,
          inboundFares: [
            OutboundFares(
              lfid: state.selectedReturnFlight?.lfid ?? '',
              fbCode: state.selectedReturnFlight?.fareTypeWithTaxDetails?.first
                      .fareInfoWithTaxDetails?.first.fareID ??
                  '',
            ),
          ],
          outboundFares: [
            OutboundFares(
              lfid: state.selectedDepartureFlight?.lfid ?? '',
              fbCode: state.selectedDepartureFlight?.fareTypeWithTaxDetails
                      ?.first.fareInfoWithTaxDetails?.first.fareID ??
                  '',
            ),
          ]);

      if (state.manageBookingResponse?.isOneWay ?? false) {
        request = ChangeFlightRequest(
            pNR: state.pnrEntered,
            lastName: state.lastName,
            isReturn: false,
            departDate: departureDate,
            returnDate: null,
            inboundFares: [],
            outboundFares: [
              OutboundFares(
                lfid: state.selectedDepartureFlight?.lfid ?? '',
                fbCode: state.selectedDepartureFlight?.fareTypeWithTaxDetails
                        ?.first.fareInfoWithTaxDetails?.first.fareID ??
                    '',
              ),
            ]);
      } else if (state.checkedDeparture == true && state.checkReturn == false) {
        request = ChangeFlightRequest(
            pNR: state.pnrEntered,
            lastName: state.lastName,
            isReturn: true,
            departDate: departureDate,
            returnDate: null,
            inboundFares: [],
            outboundFares: [
              OutboundFares(
                lfid: state.selectedDepartureFlight?.lfid ?? '',
                fbCode: state.selectedDepartureFlight?.fareTypeWithTaxDetails
                        ?.first.fareInfoWithTaxDetails?.first.fareID ??
                    '',
              ),
            ]);
      } else if (state.checkedDeparture == false && state.checkReturn == true) {
        request = ChangeFlightRequest(
            pNR: state.pnrEntered,
            lastName: state.lastName,
            isReturn: true,
            departDate: null,
            returnDate: returnDate,
            inboundFares: [
              OutboundFares(
                lfid: state.selectedReturnFlight?.lfid ?? '',
                fbCode: state.selectedReturnFlight?.fareTypeWithTaxDetails
                        ?.first.fareInfoWithTaxDetails?.first.fareID ??
                    '',
              ),
            ],
            outboundFares: []);
      }

      emit(
        state.copyWith(
            loadingSelectingFlight: true,
            blocState: BlocState.initial,
            message: ''),
      );

      var response = await _repository.changeFlight(
        ChangingFlightRequest(changeFlightRequest: request),
      );

      if (response.result?.changeFlightResponse == null &&
          (response.message?.isNotEmpty ?? false)) {
        emit(
          state.copyWith(
              loadingSelectingFlight: false,
              message: response.message,
              blocState: BlocState.failed),
        );

        return false;
      }
      emit(
        state.copyWith(
          flightToken: response.result?.token ?? '',
          changeFlightResponse: response,
          loadingSelectingFlight: false,
        ),
      );

      return true;
    } catch (e, st) {
      emit(
        state.copyWith(
          isLoadingInfo: false,
          loadingSelectingFlight: false,
          blocState: BlocState.failed,
          message: ErrorUtils.getErrorMessage(e, st),
        ),
      );
      return false;
    }
  }

  String get currentToken {
    return state.changeFlightResponse?.result?.token ?? '';
  }

  Future<String?> checkOutForPaymentSSR(
      String? voucher, ChangeSsrResponse rp) async {
    try {


      var request = MmbCheckoutRequest(
        superPNRNo:
        state.superPnrNo ?? '',
        insertVoucher: voucher ?? '',
        orderId: state.orderId ?? 0,
        paymentDetail: PaymentDetail(
          currency: state.manageBookingResponse?.result?.passengersWithSSR
                  ?.first.fareAndBundleDetail?.currencyToShow ??
              'MYR',
          frontendUrl: AppFlavor.paymentRedirectUrl,
          promoCode: '',
          totalAmountNeedToPay:
              rp.assignFlightAddOnResponse?.totalReservationAmount ?? 0.0,
          totalAmount:
              rp.assignFlightAddOnResponse?.totalReservationAmount ?? 0.0,
        ),
        token: rp.token,
      );

      //MmbCheckoutRequest
      //loadingCheckoutPayment
      PayRedirectionValue response = await _repository.checkOutFlight(request);
      String? superNo;
      int? orderId;

      if (response.value?.superPnrNo != null) {
        superNo = response.value?.superPnrNo;
      }

      if (response.value?.orderId != null) {
        orderId = response.value?.orderId;
      }
      //loadingCheckoutPayment
      FormData formData = FormData.fromMap(
          response.value?.paymentRedirectData?.redirectMap() ?? {});

      var responseView = await Dio().post(
        response.value?.paymentRedirectData?.paymentUrl ?? '',
        data: formData,
      );

      emit(
        state.copyWith(
            loadingCheckoutPayment: false,
            orderId: orderId,
            superPnrNo: superNo,
            message: ''),
      );
      return 1 == 1
          ? responseView.data
          : response.value?.paymentRedirectData?.paymentUrl;
    } catch (e, st) {
      emit(
        state.copyWith(
          loadingCheckoutPayment: false,
          isPaying: false,
          blocState: BlocState.failed,
          message: ErrorUtils.getErrorMessage(e, st),
        ),
      );

      return null;
    }

    /*
    emit(state.copyWith(
      blocState: BlocState.finished,
      bookRequest: bookRequest,
      paymentResponse: payRedirection.value,
      paymentRedirect: response.data,
    ));*/

    /*
        var bookRequest = BookRequest(
      token: state.changeFlightResponse?.result?.token,
      paymentDetail: request.paymentDetail,
    );

    final bookRequest = state.paymentResponse != null
        ? BookRequest(
      paymentDetail: paymentDetail,
      superPNRNo: state.paymentResponse?.superPnrNo,
    )
        : BookRequest(
      token: token,
      paymentDetail: paymentDetail,
      flightSummaryPNRRequest: flightSummaryPnrRequestNew,
    );
    */
  }

  Future<String?> checkOutForPayment(String? voucher) async {
    try {
      emit(
        state.copyWith(loadingCheckoutPayment: true, message: ''),
      );

      var request = MmbCheckoutRequest(
        superPNRNo: state.superPnrNo ?? '',
        insertVoucher: voucher ?? '',
        orderId: state.orderId ?? 0,
        myRewardRedemptionName:  state.rewardItem?.redemptionName,
        paymentDetail: PaymentDetail(
          myRewardRedemptionName: state.rewardItem?.redemptionName,
          currency: state.manageBookingResponse?.result?.passengersWithSSR
                  ?.first.fareAndBundleDetail?.currencyToShow ??
              'MYR',
          frontendUrl: AppFlavor.paymentRedirectUrl,
          promoCode: '',
          totalAmountNeedToPay: state.changeFlightResponse?.result
              ?.changeFlightResponse?.totalReservationAmount,
          totalAmount: state.changeFlightResponse?.result?.changeFlightResponse
              ?.totalReservationAmount,
        ),
        token: currentToken,
      );

      //MmbCheckoutRequest
      //loadingCheckoutPayment
      PayRedirectionValue response = await _repository.checkOutFlight(request);
      String? superNo;
      int? orderId;

      if (response.value?.superPnrNo != null) {
        superNo = response.value?.superPnrNo;
      }

      if (response.value?.orderId != null) {
        orderId = response.value?.orderId;
      }
      //loadingCheckoutPayment
      FormData formData = FormData.fromMap(
          response.value?.paymentRedirectData?.redirectMap() ?? {});

      var responseView = await Dio().post(
        response.value?.paymentRedirectData?.paymentUrl ?? '',
        data: formData,
      );

      emit(
        state.copyWith(
            loadingCheckoutPayment: false,
            orderId: orderId,
            superPnrNo: superNo,
            message: ''),
      );
      return 1 == 1
          ? responseView.data
          : response.value?.paymentRedirectData?.paymentUrl;
    } catch (e, st) {
      emit(
        state.copyWith(
          loadingCheckoutPayment: false,
          blocState: BlocState.failed,
          message: ErrorUtils.getErrorMessage(e, st),
        ),
      );
      return null;
    }

    /*
    emit(state.copyWith(
      blocState: BlocState.finished,
      bookRequest: bookRequest,
      paymentResponse: payRedirection.value,
      paymentRedirect: response.data,
    ));*/

    /*
        var bookRequest = BookRequest(
      token: state.changeFlightResponse?.result?.token,
      paymentDetail: request.paymentDetail,
    );

    final bookRequest = state.paymentResponse != null
        ? BookRequest(
      paymentDetail: paymentDetail,
      superPNRNo: state.paymentResponse?.superPnrNo,
    )
        : BookRequest(
      token: token,
      paymentDetail: paymentDetail,
      flightSummaryPNRRequest: flightSummaryPnrRequestNew,
    );
    */
  }

  void resetData() {
    newCompanyTaxName = null;
    newCompanyTaxAddress = null;
    newCompanyTaxState = null;
    newCompanyTaxCity = null;
    newCompanyTaxPostCode = null;
    newCompanyTaxEmailAddress = null;

    newEmergencyFirstName = null;
    newEmergencyLastName = null;
    newEmergencyCountryPhCode = null;
    newEmergencyPhNo = null;
    newEmergencyRelation = null;

    newContactFirstName = null;
    newContactLastName = null;
    newContactCountryPhCode = null;
    newContactPhNo = null;
    newContactEmail = null;

    emit(
      state.copyWith(
        checkedDeparture: false,
        checkReturn: false,
      ),
    );
  }

  void setFlightDates() {
    var newBookingObject = state.manageBookingResponse;

    newBookingObject?.newReturnDateSelected = null;
    newBookingObject?.newStartDateSelected = null;
    newBookingObject?.customSelected = false;

    //
    emit(
      state.copyWith(
        message: '',
        manageBookingResponse: newBookingObject,
      ),
    );
  }

  void refreshData() async {
    //

    emit(
      state.copyWith(
        loadingSummary: true,
        message: '',
        blocState: BlocState.initial,
      ),
    );

    try {
      final verifyResponse = await _repository.getBookingInfo(
        ManageBookingRequest(
            pnr: false ? 'AGBBRY' : state.pnrEntered, lastname: state.lastName),
      );

      emit(
        state.copyWith(
            blocState: BlocState.finished,
            manageBookingResponse: verifyResponse,
            loadingSummary: false,
            showPending: false),
      );
      return;
    } catch (e, st) {
      emit(
        state.copyWith(
          loadingSummary: false,
        ),
      );
      return;
    }
  }

  void changeSelectedPax(PassengersWithSSR person) {
    emit(
      state.copyWith(
        selectedPax: person,
      ),
    );
  }

  void changeInfantSelected(int i) {
    var mResponse = state.manageBookingResponse?.copyWith();
    mResponse?.result?.passengersWithSSR?[i].infantExpanded =
        !(mResponse.result?.passengersWithSSR?[i].infantExpanded ?? false);

    emit(
      state.copyWith(
        manageBookingResponse: mResponse,
      ),
    );
  }

  bool get hasAnySeatChanged {
    var passengers =
        state.manageBookingResponse?.result?.passengersWithSSR ?? [];

    for (PassengersWithSSR currentPassenger in passengers) {


      if (currentPassenger.newDepartSeatSelected != null) {
        return true;
      }

      if (currentPassenger.newDepartureMeal != null) {
        return true;
      }

      if (currentPassenger.newReturnMeal != null) {
        return true;
      }

      if (currentPassenger.newDepartBaggageSelected != null) {
        return true;
      }

      if (currentPassenger.newReturnBaggageSelected != null) {
        return true;
      }

      if (currentPassenger.newReturnWheelChair != null) {
        return true;
      }

      if (currentPassenger.newReturnSeatSelected != null) {
        return true;
      }

      if (currentPassenger.newReturnMeal != null) {
        return true;
      }

      if (currentPassenger.newReturnMeal != null) {
        return true;
      }
      if (currentPassenger.newDepartWheelChair != null) {
        return true;
      }

      if(state.insuranceType == InsuranceType.all) {

        if(state.manageBookingResponse?.allInsuranceBundleSelected != null) {
          return true;
        }

      }
      else if(state.insuranceType == InsuranceType.selected) {

        if(currentPassenger.newInsuranceBoundSelected != null) {
          return true;
        }
      }
      else if(state.insuranceType == InsuranceType.none) {


        return true;
      }


      print('');
    }
    print('');

    return false;
  }

  bool get hasAnyDepartSeatChanged {
    var passengers =
        state.manageBookingResponse?.result?.passengersWithSSR ?? [];

    for (PassengersWithSSR currentPassenger in passengers) {
      if (currentPassenger.newDepartSeatSelected != null) {
        return true;
      }

      print('');
    }
    print('');

    return false;
  }

  bool get hasAnyReturnSeatChanged {
    var passengers =
        state.manageBookingResponse?.result?.passengersWithSSR ?? [];

    for (PassengersWithSSR currentPassenger in passengers) {
      if (currentPassenger.newDepartSeatSelected != null) {
        return true;
      }

      print('');
    }
    print('');

    return false;
  }

  void changeSelectedAddOnOption(AddonType addOnOptionSelected,
      {bool toNull = false}) {

    emit(
      state.copyWith(
        addOnOptionSelected: addOnOptionSelected,
      ),
    );
  }

  void changeContactsExpanded(
      {bool isEmergency = false,
      bool isCompany = false,
      bool isPayment = false}) {
    if (isPayment) {
      emit(
        state.copyWith(paymentDetailsExpanded: !state.paymentDetailsExpanded),
      );
      return;
    } else if (isCompany == true) {
      emit(
        state.copyWith(
            companyTaxInvoiceExpanded: !state.companyTaxInvoiceExpanded),
      );
      return;
    } else if (isEmergency == true) {
      emit(
        state.copyWith(
            emergencySectionExpanded: !state.emergencySectionExpanded),
      );
      return;
    }
    emit(
      state.copyWith(contactsSectionExpanded: !state.contactsSectionExpanded),
    );
  }

  void seatConfirmSeatChange() {
    var manageResponse = state.manageBookingResponse;
    var userList = state.manageBookingResponse?.result?.passengersWithSSR
        ?.where((e) =>
            e.newDepartSeatSelected != null || e.newReturnSeatSelected != null)
        .toList();
    if ((userList ?? []).isNotEmpty) {
      var copyList = state.manageBookingResponse?.result?.passengersWithSSR;
      for (PassengersWithSSR currentUser in (userList ?? [])) {
        if (currentUser.newDepartSeatSelected != null &&
            currentUser.newReturnSeatSelected != null) {
          int index = 0;
          index = state.manageBookingResponse?.result?.passengersWithSSR
                  ?.indexOf(currentUser) ??
              0;
          PassengersWithSSR? newSSR = currentUser;
          newSSR.confirmedDepartSeatSelected =
              currentUser.newDepartSeatSelected;
          newSSR.confirmedReturnSeatSelected =
              currentUser.newReturnSeatSelected;
          copyList?.removeAt(index);
          copyList?.insert(index, newSSR);
        } else if (currentUser.newDepartSeatSelected != null) {
          int index = 0;
          index = state.manageBookingResponse?.result?.passengersWithSSR
                  ?.indexOf(currentUser) ??
              0;
          PassengersWithSSR? newSSR = currentUser;
          newSSR.confirmedDepartSeatSelected =
              currentUser.newDepartSeatSelected;
          copyList?.removeAt(index);
          copyList?.insert(index, newSSR);
        }
        if (currentUser.newReturnSeatSelected != null) {
          int index = 0;
          index = state.manageBookingResponse?.result?.passengersWithSSR
                  ?.indexOf(currentUser) ??
              0;
          PassengersWithSSR? newSSR = currentUser;
          newSSR.confirmedReturnSeatSelected =
              currentUser.newReturnSeatSelected;
          copyList?.removeAt(index);
          copyList?.insert(index, newSSR);
        }
      }

      MBR.Result? cc = manageResponse?.result;
      var result2 = cc?.copyWith(passengersWithSSR: copyList);
      var finalResult = manageResponse?.copyWith(result: result2);

      emit(
        state.copyWith(manageBookingResponse: finalResult),
      );
    }
  }

  void baggageConfirmSeatChange() {
    var manageResponse = state.manageBookingResponse;
    var userList = state.manageBookingResponse?.result?.passengersWithSSR
        ?.where((e) =>
            e.newDepartBaggageSelected != null ||
            e.newReturnBaggageSelected != null)
        .toList();
    if ((userList ?? []).isNotEmpty) {
      var copyList = state.manageBookingResponse?.result?.passengersWithSSR;
      for (PassengersWithSSR currentUser in (userList ?? [])) {
        if (currentUser.newDepartBaggageSelected != null &&
            currentUser.newReturnBaggageSelected != null) {
          int index = 0;
          index = state.manageBookingResponse?.result?.passengersWithSSR
                  ?.indexOf(currentUser) ??
              0;
          PassengersWithSSR? newSSR = currentUser;
          newSSR.confirmDepartBaggageSelected =
              currentUser.newDepartBaggageSelected;
          newSSR.confirmReturnBaggageSelected =
              currentUser.newReturnBaggageSelected;

          newSSR.confirmedDepartSportsSelected =
              currentUser.newDepartSportsSelected;
          newSSR.confirmedReturnSportsSelected =
              currentUser.newReturnSportsSelected;

          copyList?.removeAt(index);
          copyList?.insert(index, newSSR);
        } else if (currentUser.newDepartBaggageSelected != null) {
          int index = 0;
          index = state.manageBookingResponse?.result?.passengersWithSSR
                  ?.indexOf(currentUser) ??
              0;
          PassengersWithSSR? newSSR = currentUser;
          newSSR.confirmDepartBaggageSelected =
              currentUser.newDepartBaggageSelected;
          newSSR.confirmedDepartSportsSelected =
              currentUser.newDepartSportsSelected;
          newSSR.confirmedReturnSportsSelected =
              currentUser.newReturnSportsSelected;

          copyList?.removeAt(index);
          copyList?.insert(index, newSSR);
        }

        if (currentUser.newReturnBaggageSelected != null) {
          int index = 0;
          index = state.manageBookingResponse?.result?.passengersWithSSR
                  ?.indexOf(currentUser) ??
              0;
          PassengersWithSSR? newSSR = currentUser;
          newSSR.confirmReturnBaggageSelected =
              currentUser.newReturnBaggageSelected;
          newSSR.confirmedDepartSportsSelected =
              currentUser.newDepartSportsSelected;
          newSSR.confirmedReturnSportsSelected =
              currentUser.newReturnSportsSelected;


          copyList?.removeAt(index);
          copyList?.insert(index, newSSR);
        }
      }

      MBR.Result? cc = manageResponse?.result;
      var result2 = cc?.copyWith(passengersWithSSR: copyList);
      var finalResult = manageResponse?.copyWith(result: result2);

      emit(
        state.copyWith(manageBookingResponse: finalResult),
      );
    }
  }

  void wheelChairConfirmSeatChange() {
    var manageResponse = state.manageBookingResponse;
    var userList = state.manageBookingResponse?.result?.passengersWithSSR
        ?.where((e) =>
            e.newDepartWheelChair != null || e.newReturnWheelChair != null)
        .toList();
    if ((userList ?? []).isNotEmpty) {
      var copyList = state.manageBookingResponse?.result?.passengersWithSSR;
      for (PassengersWithSSR currentUser in (userList ?? [])) {
        if (currentUser.newDepartWheelChair != null &&
            currentUser.newReturnWheelChair != null) {
          int index = 0;
          index = state.manageBookingResponse?.result?.passengersWithSSR
                  ?.indexOf(currentUser) ??
              0;
          PassengersWithSSR? newSSR = currentUser;
          newSSR.confirmDepartWheelChair = currentUser.newDepartWheelChair;
          newSSR.confirmReturnWheelChair = currentUser.newReturnWheelChair;
          copyList?.removeAt(index);
          copyList?.insert(index, newSSR);
        } else if (currentUser.newDepartWheelChair != null) {
          int index = 0;
          index = state.manageBookingResponse?.result?.passengersWithSSR
                  ?.indexOf(currentUser) ??
              0;
          PassengersWithSSR? newSSR = currentUser;
          newSSR.confirmDepartWheelChair = currentUser.newDepartWheelChair;
          copyList?.removeAt(index);
          copyList?.insert(index, newSSR);
        }
        if (currentUser.newReturnWheelChair != null) {
          int index = 0;
          index = state.manageBookingResponse?.result?.passengersWithSSR
                  ?.indexOf(currentUser) ??
              0;
          PassengersWithSSR? newSSR = currentUser;
          newSSR.confirmReturnWheelChair = currentUser.newReturnWheelChair;
          copyList?.removeAt(index);
          copyList?.insert(index, newSSR);
        }
      }

      MBR.Result? cc = manageResponse?.result;
      var result2 = cc?.copyWith(passengersWithSSR: copyList);
      var finalResult = manageResponse?.copyWith(result: result2);

      emit(
        state.copyWith(manageBookingResponse: finalResult),
      );
    }
  }

  void seatMealSeatChange() {
    var manageResponse = state.manageBookingResponse;
    var userList = state.manageBookingResponse?.result?.passengersWithSSR
        ?.where((e) => e.newDepartureMeal != null || e.newReturnMeal != null)
        .toList();
    if ((userList ?? []).isNotEmpty) {
      var copyList = state.manageBookingResponse?.result?.passengersWithSSR;
      for (PassengersWithSSR currentUser in (userList ?? [])) {
        if (currentUser.newDepartureMeal != null &&
            currentUser.newReturnMeal != null) {
          int index = 0;
          index = state.manageBookingResponse?.result?.passengersWithSSR
                  ?.indexOf(currentUser) ??
              0;
          PassengersWithSSR? newSSR = currentUser;
          newSSR.confirmedDepartMeals = currentUser.newDepartureMeal;
          newSSR.confirmedReturnMeals = currentUser.newReturnMeal;
          copyList?.removeAt(index);
          copyList?.insert(index, newSSR);
        } else if (currentUser.newDepartureMeal != null) {
          int index = 0;
          index = state.manageBookingResponse?.result?.passengersWithSSR
                  ?.indexOf(currentUser) ??
              0;
          PassengersWithSSR? newSSR = currentUser;
          newSSR.confirmedDepartMeals = currentUser.newDepartureMeal;
          copyList?.removeAt(index);
          copyList?.insert(index, newSSR);
        }
        if (currentUser.newReturnMeal != null) {
          int index = 0;
          index = state.manageBookingResponse?.result?.passengersWithSSR
                  ?.indexOf(currentUser) ??
              0;
          PassengersWithSSR? newSSR = currentUser;
          newSSR.confirmedReturnMeals = currentUser.newReturnMeal;
          copyList?.removeAt(index);
          copyList?.insert(index, newSSR);
        }
      }

      MBR.Result? cc = manageResponse?.result;
      var result2 = cc?.copyWith(passengersWithSSR: copyList);
      var finalResult = manageResponse?.copyWith(result: result2);

      emit(
        state.copyWith(manageBookingResponse: finalResult),
      );
    }
  }

  void addSeatToPerson(
      Person? selectedPerson, Vs.Seats seats, bool isDeparture) {
    bool makeSeatEmpty = false;

    var manageResponse = state.manageBookingResponse;
    if(isDeparture) {
      if(selectedPerson?.departureSeats != null){


        var resultr = state.manageBookingResponse?.result?.passengersWithSSR?.where((element) => element.personObject == selectedPerson).toList();
        if((resultr ?? [] ).first.newDepartSeatSelected?.seatId == seats.seatId) {

          if((resultr ?? [] ).first.originalDepartSeatId != null) {
            List<Rows>? rows =  state.flightSeats?.outbound?.first.retrieveFlightSeatMapResponse?.physicalFlights?.first.physicalFlightSeatMap?.seatConfiguration?.rows;

            if(rows != null) {

              for(Rows currentRow in rows ?? []) {
                var list = currentRow.seats?.where((e) => e.seatId == (resultr ?? [] ).first.originalDepartSeatId ).toList();
                if( (list ?? []) .isNotEmpty) {
                  Vs.Seats tmpSeat =  (list ?? [] ).first;

                  addSeatToPerson(selectedPerson,tmpSeat,isDeparture);

                  return;

                }
              }
            }
          }
          else {
            makeSeatEmpty = true;
          }

        }
        else if((resultr ?? [] ).first.originalDepartSeatId?.contains(seats.seatId ?? '') == true) {


        }
        else if((resultr ?? [] ).isNotEmpty) {

          if( ((resultr ?? [] ).first.originalDepartSeatPrice ?? 0.0) >= (seats.seatPriceOffers?.first.amount ?? 0.0) ){
            return;
          }
        }



      }
    }
    else {

      var resultr = state.manageBookingResponse?.result?.passengersWithSSR?.where((element) => element.personObject == selectedPerson).toList();
      if((resultr ?? [] ).first.newReturnSeatSelected?.seatId == seats.seatId) {

        if((resultr ?? [] ).first.originalReturnSeatId != null) {
          List<Rows>? rows =  state.flightSeats?.outbound?.first.retrieveFlightSeatMapResponse?.physicalFlights?.first.physicalFlightSeatMap?.seatConfiguration?.rows;

          if(rows != null) {

            for(Rows currentRow in rows ?? []) {
              var list = currentRow.seats?.where((e) => e.seatId == (resultr ?? [] ).first.originalReturnSeatId ).toList();
              if( (list ?? []) .isNotEmpty) {
                Vs.Seats tmpSeat =  (list ?? [] ).first;
                addSeatToPerson(selectedPerson,tmpSeat,isDeparture);
                return;
              }
            }
          }
        }
        else {
          makeSeatEmpty = true;
        }

      }
      else
      if((resultr ?? [] ).first.originalReturnSeatId == seats.seatId) {

      }
      if((resultr ?? [] ).isNotEmpty) {
        if( ((resultr ?? [] ).first.originalReturnSeatPrice ?? 0.0) >= (seats.seatPriceOffers?.first.amount ?? 0.0) ){
          return;
        }
      }



    }
    var tmpObj = state.manageBookingResponse?.result?.passengersWithSSR
        ?.where((e) => e.personObject == selectedPerson)
        .toList();

    if ((tmpObj ?? []).isNotEmpty) {
      var item = (tmpObj ?? []).first;

      int index = 0;
      index = state.manageBookingResponse?.result?.passengersWithSSR
              ?.indexOf(item) ??
          0;

      Person? newPerson;
      PassengersWithSSR? newSSR;

      if (isDeparture) {
        newPerson = item.personObject?.copyWith(departureSeats: () => seats);

        if(makeSeatEmpty) {
          item.personObject?.copyWithNull(departureSeats: true);
        }
        if (item.originalDepartSeatId == seats.seatId) {

          newSSR = item.copyWith(
              personObject: newPerson, newDepartSeatSelected: seats);

          newSSR.newDepartSeatSelected = null;


        } else {

          if(makeSeatEmpty) {
            newSSR = item.copyWith(
                personObject: newPerson, );

            newSSR.newDepartSeatSelected = null;

          }
          else {
            newSSR = item.copyWith(
                personObject: newPerson, newDepartSeatSelected: seats);
          }

        }
      } else {
        newPerson = item.personObject?.copyWith(returnSeats: () => seats);

        if(makeSeatEmpty) {
          item.personObject?.copyWithNull(returnSeats: true);
        }


        if (item.originalReturnSeatId == seats.seatId) {

          newSSR = item.copyWith(
              personObject: newPerson, newReturnSeatSelected: seats);

          newSSR.newReturnSeatSelected = null;

        } else {
          if(makeSeatEmpty) {
            newSSR = item.copyWith(
                personObject: newPerson, newReturnSeatSelected: seats);

            newSSR.newReturnSeatSelected = null;

          }
          else {
            newSSR = item.copyWith(
                personObject: newPerson, newReturnSeatSelected: seats);
          }

        }
      }

      var copyList = state.manageBookingResponse?.result?.passengersWithSSR;
      copyList?.removeAt(index);
      copyList?.insert(index, newSSR!);

      MBR.Result? cc = manageResponse?.result;
      var result2 = cc?.copyWith(passengersWithSSR: copyList);
      var finalResult = manageResponse?.copyWith(result: result2);

      emit(
        state.copyWith(manageBookingResponse: finalResult, selectedPax: newSSR),
      );

      print('');
    }
  }

  void addBaggageToPerson(Person? person, Bundle? baggage, bool isDeparture) {
    var manageResponse = state.manageBookingResponse;
    var tmpObj = state.manageBookingResponse?.result?.passengersWithSSR
        ?.where((e) => e.personObject == person)
        .toList();

    if ((tmpObj ?? []).isNotEmpty) {
      var item = (tmpObj ?? []).first;

      int index = 0;
      index = state.manageBookingResponse?.result?.passengersWithSSR
              ?.indexOf(item) ??
          0;
      Person? newPerson;

      if (isDeparture) {
        if ((item.originalDepartBaggagePrice ?? 0.0) >
            (baggage?.finalAmount.toDouble() ?? 0.0)) {
        } else {
          newPerson =
              item.personObject?.copyWith(departureBaggage: () => baggage);
        }

        if ((item.originalDepartBaggagePrice ?? 0.0) >
            (baggage?.finalAmount.toDouble() ?? 0.0)) {
          item.newDepartBaggageSelected = null;
        } else if (item.originalDepartBaggageCode == baggage?.codeType) {
          item.newDepartBaggageSelected = null;
        } else {
          item.newDepartBaggageSelected = baggage;
        }
      } else {
        if ((item.originalReturnBaggagePrice ?? 0.0) >
            (baggage?.finalAmount.toDouble() ?? 0.0)) {
        } else {
          newPerson = item.personObject?.copyWith(returnBaggage: () => baggage);
        }

        if ((item.originalReturnBaggagePrice ?? 0.0) >
            (baggage?.finalAmount.toDouble() ?? 0.0)) {
          item.newReturnBaggageSelected = null;
        } else if (item.originalReturnBaggageCode == baggage?.codeType) {
          item.newReturnBaggageSelected = null;
        } else {
          item.newReturnBaggageSelected = baggage;
        }
      }

      var newSSR = item.copyWith(personObject: newPerson);

      var copyList = state.manageBookingResponse?.result?.passengersWithSSR;
      copyList?.removeAt(index);
      copyList?.insert(index, newSSR);
      MBR.Result? cc = manageResponse?.result;
      var result2 = cc?.copyWith(passengersWithSSR: copyList);
      var finalResult = manageResponse?.copyWith(result: result2);

      emit(
        state.copyWith(manageBookingResponse: finalResult, selectedPax: newSSR),
      );
    }
  }

  void addSportToPerson(Person? person, Bundle? baggage, bool isDeparture) {
    var manageResponse = state.manageBookingResponse;
    var tmpObj = state.manageBookingResponse?.result?.passengersWithSSR
        ?.where((e) => e.personObject == person)
        .toList();

    if ((tmpObj ?? []).isNotEmpty) {
      var item = (tmpObj ?? []).first;
      int index = 0;
      index = state.manageBookingResponse?.result?.passengersWithSSR
              ?.indexOf(item) ??
          0;
      Person? newPerson;

      if (isDeparture) {
        if ((item.originalDepartSportsPrice ?? 0.0) >
            (baggage?.finalAmount.toDouble() ?? 0.0)) {
        } else {
          newPerson =
              item.personObject?.copyWith(departureSports: () => baggage);
        }
        if ((item.originalDepartSportsPrice ?? 0.0) >
            (baggage?.finalAmount.toDouble() ?? 0.0)) {
          item.newDepartSportsSelected = null;
        } else if (item.originalDepartSportsCode == baggage?.codeType) {
          item.newDepartSportsSelected = null;
        } else {
          item.newDepartSportsSelected = baggage;
        }
      } else {
        if ((item.originalReturnSportsPrice ?? 0.0) >
            (baggage?.finalAmount.toDouble() ?? 0.0)) {
        } else {
          newPerson = item.personObject?.copyWith(returnSports: () => baggage);
        }

        if ((item.originalReturnSportsPrice ?? 0.0) >
            (baggage?.finalAmount.toDouble() ?? 0.0)) {
          item.newReturnSportsSelected = null;
        } else if (item.originalReturnSportsCode == baggage?.codeType) {
          item.newReturnSportsSelected = null;
        } else {
          item.newReturnSportsSelected = baggage;
        }
      }

      var newSSR = item.copyWith(personObject: newPerson);

      var copyList = state.manageBookingResponse?.result?.passengersWithSSR;
      copyList?.removeAt(index);
      copyList?.insert(index, newSSR);
      MBR.Result? cc = manageResponse?.result;
      var result2 = cc?.copyWith(passengersWithSSR: copyList);
      var finalResult = manageResponse?.copyWith(result: result2);

      emit(
        state.copyWith(manageBookingResponse: finalResult, selectedPax: newSSR),
      );
    }
  }

  void addWheelToPerson(
      bool isAdd, Person? person, Bundle? wheelChair, bool isDeparture) {
    var manageResponse = state.manageBookingResponse;
    var tmpObj = state.manageBookingResponse?.result?.passengersWithSSR
        ?.where((e) => e.personObject == person)
        .toList();

    if ((tmpObj ?? []).isNotEmpty) {
      var item = (tmpObj ?? []).first;
      int index = 0;
      index = state.manageBookingResponse?.result?.passengersWithSSR
              ?.indexOf(item) ??
          0;
      Person? newPerson;

      if (isDeparture) {
        if (item.originalHadWheelChairDepart == true) {
          return;
        }
        if (isAdd == true) {
          newPerson = item.personObject
              ?.copyWith(departureWheelChair: () => wheelChair);
          item.newDepartWheelChair = wheelChair;
        } else {
          newPerson =
              item.personObject?.copyWithNull(departureWheelChair: true);

          item.newReturnWheelChair = null;
        }
      } else {
        if (item.originalHadWheelChairReturn == true) {
          return;
        }

        if (isAdd == true) {
          newPerson =
              item.personObject?.copyWith(returnWheelChair: () => wheelChair);

          item.newReturnWheelChair = wheelChair;
        } else {
          newPerson = item.personObject?.copyWithNull(returnWheelChair: true);

          item.newReturnWheelChair = null;
        }
      }

      var newSSR = item.copyWith(personObject: newPerson);

      var copyList = state.manageBookingResponse?.result?.passengersWithSSR;
      copyList?.removeAt(index);
      copyList?.insert(index, newSSR);
      MBR.Result? cc = manageResponse?.result;
      var result2 = cc?.copyWith(passengersWithSSR: copyList);
      var finalResult = manageResponse?.copyWith(result: result2);

      emit(
        state.copyWith(manageBookingResponse: finalResult, selectedPax: newSSR),
      );
    }
  }

  void addWheelId(bool isAdd, Person? person, bool isDeparture, String okId) {
    var manageResponse = state.manageBookingResponse;
    var tmpObj = state.manageBookingResponse?.result?.passengersWithSSR
        ?.where((e) => e.personObject == person)
        .toList();

    if ((tmpObj ?? []).isNotEmpty) {
      var item = (tmpObj ?? []).first;
      int index = 0;
      index = state.manageBookingResponse?.result?.passengersWithSSR
              ?.indexOf(item) ??
          0;
      Person? newPerson;

      if (isDeparture) {
        if (item.originalHadWheelChairDepart == true) {
          return;
        }
      } else {
        if (item.originalHadWheelChairReturn == true) {
          return;
        }
        item.wheelChairIdReturn = okId;
      }

      var newSSR = item.copyWith(personObject: newPerson);

      var copyList = state.manageBookingResponse?.result?.passengersWithSSR;
      copyList?.removeAt(index);
      copyList?.insert(index, newSSR);
      MBR.Result? cc = manageResponse?.result;
      var result2 = cc?.copyWith(passengersWithSSR: copyList);
      var finalResult = manageResponse?.copyWith(result: result2);

      emit(
        state.copyWith(manageBookingResponse: finalResult, selectedPax: newSSR),
      );
    }
  }

  void addOrRemoveMealFromPerson(
      {required bool isDeparture,
      required bool isAdd,
      Person? person,
      required Bundle meal}) {
    var manageResponse = state.manageBookingResponse;
    var tmpObj = state.manageBookingResponse?.result?.passengersWithSSR
        ?.where((e) => e.personObject == person)
        .toList();

    if ((tmpObj ?? []).isNotEmpty) {
      var item = (tmpObj ?? []).first;

      int index = 0;
      index = state.manageBookingResponse?.result?.passengersWithSSR
              ?.indexOf(item) ??
          0;

      List<Bundle> meals = [];
      if (isDeparture) {
        meals = item.personObject?.departureMeal ?? [];
      } else {
        meals = item.personObject?.returnMeal ?? [];
      }

      if (isAdd) {
        meals.add(meal);
        if(meals.length == 10) {
          //return;

        }
      } else {
        meals.remove(meal);
      }

      Person? newPerson;

      if (isDeparture) {
        newPerson = item.personObject?.copyWith(departureMeal: meals);
        if (isAdd) {
          item.newDepartureMeal ??= [];
          item.newDepartureMeal?.add(meal);
        } else {
          int indexToRemove = item.newDepartureMeal?.indexOf(meal) ?? 0;

          item.newDepartureMeal?.removeAt(indexToRemove);
        }
      } else {
        newPerson = item.personObject?.copyWith(returnMeal: meals);
        item.newDepartureMeal?.add(meal);

        if (isAdd) {
          item.newReturnMeal ??= [];
          item.newReturnMeal?.add(meal);
        } else {
          int indexToRemove = item.newReturnMeal?.indexOf(meal) ?? 0;

          item.newReturnMeal?.removeAt(indexToRemove);
        }
      }

      var newSSR = item.copyWith(personObject: newPerson);

      var copyList = state.manageBookingResponse?.result?.passengersWithSSR;
      copyList?.removeAt(index);
      copyList?.insert(index, newSSR);
      MBR.Result? cc = manageResponse?.result;
      var result2 = cc?.copyWith(passengersWithSSR: copyList);
      var finalResult = manageResponse?.copyWith(result: result2);

      emit(
        state.copyWith(manageBookingResponse: finalResult, selectedPax: newSSR),
      );
    }
  }

  void setSelectionDeparture(bool value,
      {bool isSeat = false,
      bool isFood = false,
      bool isBaggage = false,
      bool isSpecial = false}) {
    if (isSeat) {
      emit(
        state.copyWith(seatDeparture: value),
      );
    } else if (isFood) {
      emit(
        state.copyWith(foodDepearture: value),
      );
    } else if (isBaggage) {
      emit(
        state.copyWith(baggageDeparture: value),
      );
    } else if (isSpecial) {
      emit(
        state.copyWith(specialAppOpsDeparture: value),
      );
    }
  }

  String? newContactFirstName;
  String? newContactLastName;
  String? newContactCountryPhCode;
  String? newContactPhNo;
  String? newContactEmail;

  void setContactnewValue(String value,
      {bool isFirstName = false,
      bool isLastName = false,
      bool isPhoneCode = false,
      bool isPhoneNo = false,
      bool isEmail = false}) {
    if (isFirstName) {
      newContactFirstName = value;

      emit(
        state.copyWith(
          newContactFirstName: value,
          anyContactValueChange: true,
        ),
      );
    } else if (isLastName) {
      newContactLastName = value;

      emit(
        state.copyWith(
          newContactLastName: value,
          anyContactValueChange: true,
        ),
      );
    } else if (isPhoneCode) {
      newContactCountryPhCode = value;

      emit(
        state.copyWith(
          newContactCountryPhCode: value,
          anyContactValueChange: true,
        ),
      );
    } else if (isPhoneNo) {
      newContactPhNo = value;

      emit(
        state.copyWith(
          newContactPhNo: value,
          anyContactValueChange: true,
        ),
      );
    } else if (isEmail) {
      newContactEmail = value;

      emit(
        state.copyWith(
          newContactEmail: value,
          anyContactValueChange: true,
        ),
      );
    }
  }

  String? newEmergencyFirstName;
  String? newEmergencyLastName;
  String? newEmergencyCountryPhCode;
  String? newEmergencyPhNo;
  String? newEmergencyRelation;

  void setEmergencynewValue(String value,
      {bool isFirstName = false,
      bool isLastName = false,
      bool isPhoneCode = false,
      bool isPhoneNo = false,
      bool isRelation = false}) {
    if (isFirstName) {
      newEmergencyFirstName = value;

      emit(
        state.copyWith(
          newEmergencyFirstName: value,
          anyContactValueChange: true,
        ),
      );
    } else if (isLastName) {
      newEmergencyLastName = value;

      emit(
        state.copyWith(
          newEmergencyLastName: value,
          anyContactValueChange: true,
        ),
      );
    } else if (isPhoneCode) {
      newEmergencyCountryPhCode = value;

      emit(
        state.copyWith(
          newEmergencyCountryPhCode: value,
          anyContactValueChange: true,
        ),
      );
    } else if (isPhoneNo) {
      newEmergencyPhNo = value;
      emit(
        state.copyWith(
          newEmergencyPhNo: value,
          anyContactValueChange: true,
        ),
      );
    } else if (isRelation) {
      newEmergencyRelation = value;
      emit(
        state.copyWith(
          newEmergencyRelation: value,
          anyContactValueChange: true,
        ),
      );
    }
  }

  String? newCompanyTaxName;
  String? newCompanyTaxAddress;
  String? newCompanyTaxState;
  String? newCompanyTaxCity;
  String? newCompanyTaxPostCode;
  String? newCompanyTaxEmailAddress;

  void setCompanyTaxValue(
    String value, {
    bool isName = false,
    bool isAddress = false,
    bool isState = false,
    bool isCity = false,
    bool isPosCode = false,
    bool isEmail = false,
  }) {
    if (isName) {
      newCompanyTaxName = value;

      emit(
        state.copyWith(
          newCompanyTaxAame: value,
          anyContactValueChange: true,
        ),
      );
    } else if (isAddress) {
      newCompanyTaxAddress = value;

      emit(
        state.copyWith(newEmergencyLastName: value),
      );
    } else if (isPosCode) {
      newCompanyTaxPostCode = value;

      emit(
        state.copyWith(
          newEmergencyCountryPhCode: value,
          anyContactValueChange: true,
        ),
      );
    } else if (isState) {
      newCompanyTaxState = value;

      emit(
        state.copyWith(
          newCompanyTaxAddress: value,
          anyContactValueChange: true,
        ),
      );
    } else if (isCity) {
      newCompanyTaxCity = value;

      emit(
        state.copyWith(
          newCompanyTaxCity: value,
          anyContactValueChange: true,
        ),
      );
    } else if (isPosCode) {
      newCompanyTaxPostCode = value;

      emit(
        state.copyWith(
          newCompanyTaxPostCode: value,
          anyContactValueChange: true,
        ),
      );
    } else if (isEmail) {
      newCompanyTaxEmailAddress = value;
      emit(
        state.copyWith(
          newCompanyTaxEmailAddress: value,
          anyContactValueChange: true,
        ),
      );
    }
  }

  void saveContactChanges() async {
    var bookingContactInfo = UpdateBookingContact();

    emit(
      state.copyWith(
        savingContactChanges: true,
      ),
    );

    try {
      List<UpdateInfantAssociation>? updateInfantAssociation = [];

      List<BoardingPassPax>? updatePassengerList = [];

      for (PassengersWithSSR currentOne in state
              .manageBookingResponse?.result?.passengersWithSSRWithoutInfant ??
          []) {
        //date = "2025-07-08 00:00:00.000"
        var passPortExp = (currentOne.passExpdate ?? '').isEmpty ? '' : (currentOne.passExpdate ?? '').substring(0,(currentOne.passExpdate ?? '').indexOf(' '));

        updatePassengerList.add(
          BoardingPassPax(
              personOrgId: currentOne.personOrgID ?? '',
              memberID: currentOne.checkInMemberID ?? '',
              passport: currentOne.checkInPassportNo,
              passportExpiryDate: passPortExp.isEmpty ?  '2025-04-18T00:00:00.000Z' : '${passPortExp}T00:00:00.000Z'),
        );

        if (currentOne.haveInfant == true) {
          updateInfantAssociation.add(
            UpdateInfantAssociation(
                infantFirstName: currentOne.infantGivenName,
                infantLastName: currentOne.infantSurname,
                adultPersonOrgID: currentOne.personOrgID,
            ),
          );
        }
      }

      bookingContactInfo.updatePassengerList = updatePassengerList;
      bookingContactInfo.updateInfantAssociation = updateInfantAssociation;

      bookingContactInfo.pNR = state.pnrEntered;
      bookingContactInfo.lastName = state.lastName;
      bookingContactInfo.superPNRID = state
          .manageBookingResponse?.result?.superPNROrder?.superPNRID
          ?.toInt();
      bookingContactInfo.superPNRNo =
          state.manageBookingResponse?.result?.superPNR?.superPNRNo ?? '';

      var updatedContact = UpdateContact();

      BookingContact? bookingContact =
          state.manageBookingResponse?.result?.bookingContact;

      bookingContact = bookingContact?.copyWith(
          givenName: newContactFirstName,
          surname: newContactLastName,
          phone1LocationCode: newContactCountryPhCode,
          phone1: newContactPhNo,
          email: newContactEmail);

      var emergency = EmergencyContact(
          firstName: newEmergencyFirstName ??
              (bookingContact?.emergencyGivenName ?? ''),
          lastName:
              newEmergencyLastName ?? (bookingContact?.emergencySurname ?? ''),
          email: (bookingContact?.emergencyEmail ?? ''),
          relationship: newEmergencyRelation ??
              (bookingContact?.emergencyRelationship ?? ''),
          phoneCode: newEmergencyCountryPhCode ??
              (bookingContact?.emergencyPhoneCode ?? ''),
          phoneNumber:
              newEmergencyPhNo ?? (bookingContact?.emergencyPhone ?? ''));

      updatedContact.bookingContact = TempBookingContact(
        email: bookingContact?.email ?? '',
        lastName: bookingContact?.surname ?? '',
        firstName: bookingContact?.givenName ?? '',
        phoneCode: bookingContact?.phone1LocationCode ?? '',
        phoneNumber: bookingContact?.phone1 ?? '',
      );
      updatedContact.emergencyContact = emergency;
      if (newCompanyTaxEmailAddress != null ||
          newCompanyTaxName != null ||
          newCompanyTaxAddress != null ||
          newCompanyTaxState != null ||
          newCompanyTaxCity != null ||
          newCompanyTaxPostCode != null) {
        updatedContact.companyContact =
            state.manageBookingResponse?.result?.companyTaxInvoice?.copyWith(
                companyName: newCompanyTaxName,
                companyAddress: newCompanyTaxAddress,
                state: newCompanyTaxState,
                city: newCompanyTaxCity,
                postCode: newCompanyTaxPostCode,
                emailAddress: newCompanyTaxEmailAddress,
                country: 'MYS');
      }
      bookingContactInfo.updateContact = updatedContact;
      var result = await _repository.changeContactsInfo(bookingContactInfo);

      if (result.success == true) {
        emit(
          state.copyWith(
            message: ErrorUtils.showErrorMessage(result.message ?? ''),
            savingContactChanges: false,
            anyContactValueChange: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            anyContactValueChange: false,
            savingContactChanges: false,
          ),
        );
      }
    } catch (e, st) {
      emit(
        state.copyWith(
          savingContactChanges: false,
          message: ErrorUtils.getErrorMessage(e, st),
          blocState: BlocState.failed,
        ),
      );
      return;
    }

    //savingContactChanges
  }

  void selectInsuranceType(InsuranceType type) {

    emit(
      state.copyWith(
        insuranceType: type,
      ),
    );

    //insuranceType
  }

  void addInsuranceToAllPeople(Bundle bundle,FS.Bound bound) {

    List<PassengersWithSSR> allPassengers = state.manageBookingResponse?.result?.passengersWithSSR ?? [];
    List<PassengersWithSSR> newPassengersList = [];

    var newFlog= false;
    for(PassengersWithSSR currentObject in allPassengers ) {
      //currentObject.personObject
      var personObject = currentObject.passengers;
      if(state.manageBookingResponse?.allInsuranceSelected == true && bundle.codeType == state.manageBookingResponse?.allInsuranceBundleSelected?.codeType){
        var c = currentObject.personObject?.copyWithNull(insuranceGroup: true);

        currentObject.personObject = c;


        newPassengersList.add(currentObject);
      }
      else {
        var c = currentObject.personObject?.copyWith(insurance: bundle);
        newFlog = true;

        currentObject.personObject = c;


        newPassengersList.add(currentObject);
      }


    }

    var manageBookingResponse = state.manageBookingResponse?.copyWith();
    manageBookingResponse?.allInsuranceSelected = newFlog;
    if(newFlog == false) {
      manageBookingResponse?.allInsuranceBoundSelected = null;
      manageBookingResponse?.allInsuranceBundleSelected = null;
    }
    else {
      manageBookingResponse?.allInsuranceBoundSelected = bound;
      manageBookingResponse?.allInsuranceBundleSelected = bundle;
    }


    emit(state.copyWith(
      manageBookingResponse: manageBookingResponse,
    ));


  }

  void addInsuranceToPeople(Bundle bundle, FS.Bound tmp, PassengersWithSSR? selectedPax) {

    List<PassengersWithSSR> allPassengers = state.manageBookingResponse?.result?.passengersWithSSR ?? [];
    List<PassengersWithSSR> newPassengersList = [];

    var newFlog= false;
    PassengersWithSSR? selectedPerson;

    for(PassengersWithSSR currentObject in allPassengers ) {
      //currentObject.personObject

      if(selectedPax?.personOrgID == currentObject.personOrgID) {

        if(currentObject.newInsuranceBoundSelected != null && bundle.codeType == currentObject.newInsuranceBundleSelected?.codeType){
          currentObject.newInsuranceBundleSelected = null;
          currentObject.newInsuranceBoundSelected = null;
          newPassengersList.add(currentObject);
        }
        else {
          currentObject.newInsuranceBundleSelected = bundle;
          currentObject.newInsuranceBoundSelected = tmp;


          newPassengersList.add(currentObject);
        }

        selectedPerson = currentObject;

      }
      else {

        newPassengersList.add(currentObject);

      }



    }

    var manageBookingResponse = state.manageBookingResponse?.copyWith();
    manageBookingResponse?.allInsuranceSelected = newFlog;
    manageBookingResponse?.result?.passengersWithSSR = newPassengersList;


    emit(state.copyWith(
      manageBookingResponse: manageBookingResponse,
      selectedPax: selectedPerson
    ));
  }

  void insuranceConfirmChange() {

    if(state.insuranceType == InsuranceType.all) {
      var manageBookingResponse = state.manageBookingResponse?.copyWith();

      manageBookingResponse?.confirmedInsuranceBoundSelected = manageBookingResponse.allInsuranceBoundSelected;
      manageBookingResponse?.confirmedInsuranceBundleSelected = manageBookingResponse.allInsuranceBundleSelected;


      emit(
        state.copyWith(confirmedInsuranceType: state.insuranceType,manageBookingResponse: manageBookingResponse),
      );

    }
    else if(state.insuranceType == InsuranceType.selected) {

      var manageBookingResponse = state.manageBookingResponse?.copyWith();
      List<PassengersWithSSR> listOfPassengers = [];
      //


      for(PassengersWithSSR currentPersonSsr in manageBookingResponse?.result?.passengersWithSSR ?? []){
        currentPersonSsr.confirmedInsuranceBundleSelected = currentPersonSsr.newInsuranceBundleSelected;
        currentPersonSsr.confirmedInsuranceBoundSelected = currentPersonSsr.newInsuranceBoundSelected;
        listOfPassengers.add(currentPersonSsr);
      }

      manageBookingResponse?.result?.passengersWithSSR = listOfPassengers;


      emit(
        state.copyWith(confirmedInsuranceType: state.insuranceType,manageBookingResponse: manageBookingResponse),
      );

    }
    else if(state.insuranceType == InsuranceType.none){
      emit(
        state.copyWith(confirmedInsuranceType: state.insuranceType,),
      );
    }

  }


  getAvailablePromotions() async {


    emit(state.copyWith(
      isLoadingPromo: true
    ));


    final flightRepo = FlightRepository();


    final response = await flightRepo.getPromoInfoMMb(Token(token: state.flightToken ?? ''));

    if (response.statusCode == 200) {
      emit(state.copyWith(
        redemptionOption: response.value!.lmsRedemptionOption,
        promoReady: true,
          isLoadingPromo: false
      ));
      return;
    } else {
      emit(state.copyWith(
        promoReady: true,
          isLoadingPromo: false,
      ));
      return;
    }
  }

  void selectedRewardItem(AvailableRedeemOptions rewardItem) {

    emit(state.copyWith(
      rewardItem: rewardItem,
    ));

  }


}
