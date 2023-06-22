import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:paged_vertical_calendar/utils/date_utils.dart';
import '../../app/app_bloc_helper.dart';
import '../../app/app_flavor.dart';
import '../../data/repositories/flight_repository.dart';
import '../../data/repositories/manage_book_repository.dart';
import '../../data/requests/book_request.dart';
import '../../data/requests/change_flight_request.dart';
import '../../data/requests/manage_booking_request.dart';
import '../../data/requests/mmb_checkout_request.dart';
import '../../data/requests/search_change_flight_request.dart';
import '../../data/requests/search_flight_request.dart';
import '../../data/requests/verify_request.dart';
import '../../data/responses/flight_response.dart';
import '../../data/responses/manage_booking_response.dart';
import '../../data/responses/manage_booking_response.dart' as MBR;
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

  final List<Color> availableSeatsColor = [
    Colors.blue,
    Colors.greenAccent,
    Colors.green,
    Colors.yellowAccent,
    Colors.yellow,
    Colors.orangeAccent,
    Colors.orange,
    Colors.purple,
  ];

  void makeVerifyRequest() async {
    final _repository = FlightRepository();

    const outboundLFID = 68563;
    const outboundFBCode = 'WLH001MM';

    const inboundLFID = 68640;
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

    final wheelChairDeparture = verifyResponse.flightSSR?.wheelChairGroup?.outbound ?? [];
    final wheelChairReturn = verifyResponse.flightSSR?.wheelChairGroup?.inbound ?? [];

    Map<num?, Color> departureColorMapping = {};
    Map<num?, Color> returnColorMapping = {};

    for (int i = 0; i < seatsDeparture.length; i++) {
      final seat = seatsDeparture[i];
      departureColorMapping.putIfAbsent(
          seat.serviceID, () => availableSeatsColor[i]);
    }

    for (int i = 0; i < seatsReturn.length; i++) {
      final seat = seatsReturn[i];
      returnColorMapping.putIfAbsent(
          seat.serviceID, () => availableSeatsColor[i]);
    }
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

 seatIdsToMakeAvailableDep.add(finalSeat?.seatId?.toInt() ?? 0);
 //           List<int> seatIdsToMakeAvailableReturn = [];
            print('');
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

            seatIdsToMakeAvailableReturn.add(finalSeat?.seatId?.toInt() ?? 0);

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
        //Nasi Lemak Combo
        List<Bundle> result = verifyResponse.flightSSR?.baggageGroup?.outbound
                ?.where((e) =>
                    e.description?.toLowerCase() ==
                    currentIte.baggageName?.toLowerCase())
                .toList() ??
            [];

        if (result.isNotEmpty) {
          departureBaggage = result.first;
        }
        print('');
      }

      for (Baggage currentIte in returnBagSelected ?? []) {
        //Nasi Lemak Combo
        List<Bundle> result = verifyResponse.flightSSR?.baggageGroup?.inbound
                ?.where((e) =>
                    e.description?.toLowerCase() ==
                    currentIte.baggageName?.toLowerCase())
                .toList() ??
            [];

        if (result.isNotEmpty) {
          returnBaggage = result.first;
        }
        print('');
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
      var departWheelChaorOdThisUser = currentPerson.wheelChairDetail?.wheelChairs
          ?.where((e) => e.departReturn == 'Depart')
          .toList();
      if((departWheelChaorOdThisUser ?? []).isNotEmpty) {
        wheelDeparts = (departWheelChaorOdThisUser ?? []).first;
      }
      Baggage? wheelReturn;
      departWheelChaorOdThisUser = currentPerson.wheelChairDetail?.wheelChairs
          ?.where((e) => e.departReturn != 'Depart')
          .toList();
      if((departWheelChaorOdThisUser ?? []).isNotEmpty) {
        wheelReturn = departWheelChaorOdThisUser ?? [].first;
      }

      Bundle? selectedDepartWheelChairItem;
      Bundle? selectedReturnWheelChairItem;

      if(wheelDeparts != null) {
        //yes here
        var selectedWheels = wheelChairDeparture.where((e) => e.finalAmount.toInt() == wheelDeparts?.amount?.toInt()).toList();

        if((selectedWheels ?? []).isNotEmpty ) {
          selectedDepartWheelChairItem  = selectedWheels.first;
          print('');

        }
      }

      if(wheelReturn != null) {
        //yes here
        var selectedWheels = wheelChairReturn.where((e) => e.finalAmount.toInt() == wheelReturn?.amount?.toInt()).toList();

        if((selectedWheels ?? []).isNotEmpty ) {
          selectedReturnWheelChairItem  = selectedWheels.first;
          print('');

        }
      }
      for (Baggage currentIte in returnSportsSelected ?? []) {
        //Nasi Lemak Combo
        List<Bundle> result = verifyResponse.flightSSR?.sportGroup?.inbound
                ?.where((e) =>
                    e.description?.toLowerCase() ==
                    currentIte.sportEquipmentName?.toLowerCase())
                .toList() ??
            [];

        if (result.isNotEmpty) {
          returnSports = result.first;
        }
        print('');
      }

      //

      print('');

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
        returnWheelChair: selectedReturnWheelChairItem
      );
      currentPerson.personObject = currentObject;
      currentPerson.originalDepartSeatId = departureSeats?.seatId?.toInt();
      var princrTlist = seatsDeparture.where((e) => e.description?.toLowerCase() == departureSeats?.serviceDescription?.toLowerCase()).toList();

      if(princrTlist.isNotEmpty) {
        currentPerson.originalDepartSeatPrice = (princrTlist.first.amount?.toDouble() ?? 0.0) + (princrTlist.first.applicableTaxes?.first.taxAmount?.toDouble() ?? 0.0);;
      }

      currentPerson.originalReturnSeatId = returnSeats?.seatId?.toInt();
      princrTlist = seatsReturn.where((e) => e.description?.toLowerCase() == returnSeats?.serviceDescription?.toLowerCase()).toList();

      if(princrTlist.isNotEmpty) {
        currentPerson.originalReturnSeatPrice = (princrTlist.first.amount?.toDouble() ?? 0.0) + (princrTlist.first.applicableTaxes?.first.taxAmount?.toDouble() ?? 0.0);

      }
      currentPerson.originalHadWheelChairDepart = selectedDepartWheelChairItem != null;
      currentPerson.originalHadWheelChairReturn = selectedReturnWheelChairItem != null;

      currentPerson.originalDepartBaggageCode = departureBaggage?.codeType;
      currentPerson.originalDepartBaggagePrice = departureBaggage?.finalAmount.toDouble();
      currentPerson.originalReturnBaggageCode = returnBaggage?.codeType;
      currentPerson.originalReturnBaggagePrice = returnBaggage?.finalAmount.toDouble();

      currentPerson.originalDepartSportsCode = departureSports?.codeType;
      currentPerson.originalReturnSportsCode = returnSports?.codeType;
      currentPerson.originalDepartSportsPrice = departureSports?.finalAmount.toDouble();
      currentPerson.originalReturnSportsPrice = returnSports?.finalAmount.toDouble();


      //  currentPerson.copyWith(personObject: currentObject);
      print('');
    }

    var outboundRows = verifyResponse.flightSeat?.outbound?.first.retrieveFlightSeatMapResponse?.physicalFlights?.first.physicalFlightSeatMap?.seatConfiguration?.rows;

    int indexItem = 0;


    for(Rows currentItem in outboundRows ?? []) {
      //seatIdsToMakeAvailableDep
      var res = currentItem.seats?.where((e) => seatIdsToMakeAvailableDep.contains(e.seatId) ).toList();

      if((res ?? []).isNotEmpty) {
        var indexOfSeat = currentItem.seats?.indexOf((res ?? []).first);

        var copyObject =  (res ?? []).first.copyWith(isSeatAvailable: true);
        var currenT =  currentItem.seats ?? [];
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
        departureColorMapping: departureColorMapping,
        returnColorMapping: returnColorMapping));

    print('');

    //VerifyRequest();
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

  Future<void> reloadDataForConfirmation(String status, String superPnr) async {
    emit(
      state.copyWith(
          loadingSummary: true,
          message: '',
          blocState: BlocState.initial,
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
        ),
      );
      return;
    } catch (e, st) {
      emit(
        state.copyWith(
          message: ErrorUtils.getErrorMessage(e, st),
          blocState: BlocState.failed,
          loadingSummary: false,
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

  Future<bool?> getBookingInformation(
      String lastName, String bookingReference) async {
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

      emit(
        state.copyWith(
            selectedPax: verifyResponse.result?.passengersWithSSR?.first,
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
      makeVerifyRequest();

      return true;
    } catch (e, st) {
      emit(
        state.copyWith(
            message: ErrorUtils.getErrorMessage(e, st, dontShowError: true),
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
              lfid: state.selectedReturnFlight?.lfid?.toInt() ?? 0,
              fbCode: state.selectedReturnFlight?.fbCode ?? '',
            ),
          ],
          outboundFares: [
            OutboundFares(
              lfid: state.selectedDepartureFlight?.lfid?.toInt() ?? 0,
              fbCode: state.selectedDepartureFlight?.fbCode ?? '',
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
                lfid: state.selectedDepartureFlight?.lfid?.toInt() ?? 0,
                fbCode: state.selectedDepartureFlight?.fbCode ?? '',
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
                lfid: state.selectedDepartureFlight?.lfid?.toInt() ?? 0,
                fbCode: state.selectedDepartureFlight?.fbCode ?? '',
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
                lfid: state.selectedReturnFlight?.lfid?.toInt() ?? 0,
                fbCode: state.selectedReturnFlight?.fbCode ?? '',
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

  Future<String?> checkOutForPayment(String? voucher) async {
    try {

      emit(
        state.copyWith(loadingCheckoutPayment: true, message: ''),
      );

      var request = MmbCheckoutRequest(
        superPNRNo: state.superPnrNo ?? '',
        insertVoucher: voucher ?? '',
        orderId: state.orderId ?? 0,
        paymentDetail: PaymentDetail(
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

  void changeSelectedAddOnOption(AddonType addOnOptionSelected,
      {bool toNull = false}) {
    if (toNull) {
      emit(
        state.copyWith(addOnOptionSelected: AddonType.none),
      );

      return;
    }
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

  void addSeatToPerson(
      Person? selectedPerson, Vs.Seats seats, bool isDeparture) {
    var manageResponse = state.manageBookingResponse;
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

      if(isDeparture) {
        newPerson = item.personObject?.copyWith(departureSeats: () => seats);

        if(item.originalDepartSeatId == seats.seatId){
          newSSR = item.copyWith(personObject: newPerson,newDepartSeatSelected: Vs.Seats(seatId: 0));
        }
        else {
          newSSR = item.copyWith(personObject: newPerson,newDepartSeatSelected: seats);

        }

      }
      else {

        newPerson = item.personObject?.copyWith(returnSeats: () => seats);
        if(item.originalReturnSeatId == seats.seatId) {
          newSSR = item.copyWith(personObject: newPerson,newReturnSeatSelected: const Vs.Seats(seatId: 0));
        }
        else {
          newSSR = item.copyWith(personObject: newPerson,newReturnSeatSelected: seats);
        }

      }




      var copyList = state.manageBookingResponse?.result?.passengersWithSSR;
      copyList?.removeAt(index);
      copyList?.insert(index, newSSR);

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

      if(isDeparture) {
        if((item.originalDepartBaggagePrice ?? 0.0) > (baggage?.finalAmount.toDouble() ?? 0.0)) {

        }
        else {

          newPerson =
              item.personObject?.copyWith(departureBaggage: () => baggage);
        }

        if((item.originalDepartBaggagePrice ?? 0.0) > (baggage?.finalAmount.toDouble() ?? 0.0)) {

          item.newDepartBaggageSelected = null;
        }
        else if(item.originalDepartBaggageCode == baggage?.codeType){

          item.newDepartBaggageSelected = null;

        }
        else {
          item.newDepartBaggageSelected = baggage;
        }
      }
      else {
        if((item.originalReturnBaggagePrice ?? 0.0) > (baggage?.finalAmount.toDouble() ?? 0.0)) {

        }
        else {

          newPerson = item.personObject?.copyWith(returnBaggage: () => baggage);
        }



        if((item.originalReturnBaggagePrice ?? 0.0) > (baggage?.finalAmount.toDouble() ?? 0.0)) {

          item.newReturnBaggageSelected = null;
        }
        else if(item.originalReturnBaggageCode == baggage?.codeType){

          item.newReturnBaggageSelected = null;

        }
        else {
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

      if(isDeparture) {
        if((item.originalDepartSportsPrice ?? 0.0) > (baggage?.finalAmount.toDouble() ?? 0.0)) {

        }
        else {
          newPerson =
              item.personObject?.copyWith(departureSports: () => baggage);
        }
        if((item.originalDepartSportsPrice ?? 0.0) > (baggage?.finalAmount.toDouble() ?? 0.0)) {
          item.newDepartSportsSelected = null;
        }
        else if(item.originalDepartSportsCode == baggage?.codeType){

          item.newDepartSportsSelected = null;

        }
        else {
          item.newDepartSportsSelected = baggage;
        }
      }
      else {
        if((item.originalReturnSportsPrice ?? 0.0) > (baggage?.finalAmount.toDouble() ?? 0.0)) {

        }
        else {
          newPerson =
              item.personObject?.copyWith(returnSports: () => baggage);
        }


        if((item.originalReturnSportsPrice ?? 0.0) > (baggage?.finalAmount.toDouble() ?? 0.0)) {

          item.newReturnSportsSelected = null;
        }
        else if(item.originalReturnSportsCode == baggage?.codeType){

          item.newReturnSportsSelected = null;

        }
        else {
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


  void addWheelToPerson(bool isAdd,Person? person, Bundle? wheelChair, bool isDeparture) {

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

      if(isDeparture) {
        if(item.originalHadWheelChairDepart == true) {
          return;
        }
        if(isAdd == true){
          newPerson =
              item.personObject?.copyWith(departureWheelChair: () => wheelChair);
          item.newDepartWheelChair = wheelChair;
        }
        else {
          newPerson =
              item.personObject?.copyWithNull(departureWheelChair: true);

          item.newReturnWheelChair = null;
        }

      }
      else {
        if(item.originalHadWheelChairReturn == true) {
          return;
        }

        if(isAdd == true){
          newPerson =
              item.personObject?.copyWith(returnWheelChair: () => wheelChair);

          item.newReturnWheelChair = wheelChair;
        }
        else {

          newPerson =
              item.personObject?.copyWithNull(returnWheelChair: true);

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



  void addOrRemoveMealFromPerson({required bool isDeparture, required bool isAdd, Person? person, required Bundle meal}) {

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
      if(isDeparture) {
        meals = item.personObject?.departureMeal ?? [];
      }
      else {
        meals = item.personObject?.returnMeal ?? [];
      }

      if(isAdd) {
        meals.add(meal);
      }
      else {
        meals.remove(meal);
      }

      Person? newPerson;

      if(isDeparture) {
        newPerson =
            item.personObject?.copyWith(departureMeal:  meals);
        if(isAdd) {

          item.newDepartureMeal ??= [];
          item.newDepartureMeal?.add(meal);

        }
        else {
          int indexToRemove = item.newDepartureMeal?.indexOf(meal) ?? 0;


          item.newDepartureMeal?.removeAt(indexToRemove);
        }

      }
      else {
        newPerson =
            item.personObject?.copyWith(returnMeal:  meals);
        item.newDepartureMeal?.add(meal);

        if(isAdd) {
          item.newReturnMeal ??= [];
          item.newReturnMeal?.add(meal);

        }
        else {
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

  void setContactnewValue(String value,
      {bool isFirstName = false,
        bool isLastName = false,
        bool isPhoneCode = false,
        bool isPhoneNo = false,
      bool isEmail = false}) {
    if (isFirstName) {
      emit(
        state.copyWith(newContactFirstName: value),
      );
    } else if (isLastName) {
      emit(
        state.copyWith(newContactLastName: value),
      );
    } else if (isPhoneCode) {
      emit(
        state.copyWith(newContactCountryPhCode: value),
      );
    } else if (isPhoneNo) {
      emit(
        state.copyWith(newContactPhNo: value),
      );
    }
    else if (isEmail) {
      emit(
        state.copyWith(newContactEmail: value),
      );
    }
  }

  void setEmergencynewValue(String value,
      {bool isFirstName = false,
        bool isLastName = false,
        bool isPhoneCode = false,
        bool isPhoneNo = false,
        bool isRelation = false}) {
    if (isFirstName) {
      emit(
        state.copyWith(newEmergencyFirstName: value),
      );
    } else if (isLastName) {
      emit(
        state.copyWith(newEmergencyLastName: value),
      );
    } else if (isPhoneCode) {
      emit(
        state.copyWith(newEmergencyCountryPhCode: value),
      );
    } else if (isPhoneNo) {
      emit(
        state.copyWith(newEmergencyPhNo: value),
      );
    }
    else if (isRelation) {
      emit(
        state.copyWith(newEmergencyRelation: value),
      );
    }
  }


  void setCompanyTaxValue(String value,
      {bool isName = false,
        bool isAddress = false,
        bool isState = false,
        bool isCity = false,
        bool isPosCode = false,
        bool isEmail = false,
      }) {
    if (isName) {
      emit(
        state.copyWith(newCompanyTaxAame: value),
      );
    } else if (isAddress) {
      emit(
        state.copyWith(newEmergencyLastName: value),
      );
    } else if (isAddress) {
      emit(
        state.copyWith(newEmergencyCountryPhCode: value),
      );
    } else if (isState) {
      emit(
        state.copyWith(newCompanyTaxAddress: value),
      );
    }
    else if (isCity) {
      emit(
        state.copyWith(newCompanyTaxCity: value),
      );
    }
    else if (isPosCode) {
      emit(
        state.copyWith(newCompanyTaxPostCode: value),
      );
    }
    else if (isEmail) {
      emit(
        state.copyWith(newCompanyTaxEmailAddress: value),
      );
    }
  }


}
