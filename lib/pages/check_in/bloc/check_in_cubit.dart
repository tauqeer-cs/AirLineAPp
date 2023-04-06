import 'package:app/app/app_bloc_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/checkin_repository.dart';
import '../../../data/repositories/manage_book_repository.dart';
import '../../../data/requests/boarding_pass_request.dart';
import '../../../data/requests/check_in_request.dart';
import '../../../data/requests/get_boarding_pass_request.dart';
import '../../../data/requests/manage_booking_request.dart';
import '../../../data/responses/boardingpass_passenger_response.dart';
import '../../../data/responses/manage_booking_response.dart';
import '../../../models/my_bookings.dart';
import '../../../utils/error_utils.dart';

part 'check_in_state.dart';

class CheckInCubit extends Cubit<CheckInState> {
  CheckInCubit()
      : super(
          const CheckInState(),
        );

  final _manageBookingRepository = ManageBookingRepository();
  final _checkInRepository = CheckInRepository();

  void showUpcoming(bool status) {
    emit(
      state.copyWith(
        showUpcoming: status,
        message: '',
      ),
    );
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

  /*
  List<UpcomingBookings> get getUpcomingBookings {

    List<UpcomingBookings> result = [];


    final bookingsWithin72Hours = state.upcomingBookings?.where((booking) {
      final outboundFlight = booking.outboundFlight;
      final inboundFlight = booking.inboundFlight;

      if (outboundFlight == null && inboundFlight == null) {
        return false;
      }

      var now = DateTime.now();

      final isOutboundFlightWithin72Hours = outboundFlight != null &&
          now
              .difference(DateTime.parse(outboundFlight.departureDate!))
              .inHours < 72;

      final isInboundFlightWithin72Hours = inboundFlight != null &&
          now
              .difference(DateTime.parse(inboundFlight.departureDate!))
              .inHours < 72;

      return isOutboundFlightWithin72Hours || isInboundFlightWithin72Hours;
    }).toList();

    return bookingsWithin72Hours ?? [];

  }
  */

  //

  Future<String?> getBoardingPassPassengers() async {
    //
    var request = GetBoardingPassPassengerRequest(
      pNR: state.pnrEntered,
      lastName: state.lastName,
      getInboundPassenger: false,
      getOutboundPassenger: true
    );

    BoardingpassPassengerResponse? response = await _checkInRepository.getBoardingpassPassenger(request);

    BoardingPassRequest request2 = BoardingPassRequest();
    request2.pNR = state.pnrEntered;
    request2.lastName = state.lastName;
    request2.getBoardingPassBy = 'Download';
    request2.boardingPassPax = [];

    for(BoardingPassPassenger currentOne in response.outboundBoardingPassPassenger ?? []) {

      var boardItem = BoardingPassPax(
        lastName: currentOne.lastName,
        logicalFlightKey: currentOne.logicalFlightKey,
        personOrgId: currentOne.personOrgId
      );

      request2.boardingPassPax?.add(boardItem);

    }

    for(BoardingPassPassenger currentOne in response.inboundBoardingPassPassenger ?? []) {
      var boardItem = BoardingPassPax(
          lastName: currentOne.lastName,
          logicalFlightKey: currentOne.logicalFlightKey,
          personOrgId: currentOne.personOrgId
      );
      request2.boardingPassPax?.add(boardItem);
    }

    var filesResponse = await _checkInRepository.getBoardingPass(request2);

    return filesResponse.boardingPassURLs?.first ?? '';

    print('');

  }
  Future<void> changeFlight() async {
    var request = CheckInRequest();
    request.lastName = state.lastName;
    request.pNR = state.pnrEntered;
    request.superPNRNo = state.manageBookingResponse?.result?.superPNR?.superPNRNo ?? '';
    request.superPNRID = state.manageBookingResponse?.result?.superPNR?.superPNRID?.toInt();

    if(state.checkedDeparture) {

      request.outboundCheckInPassengerDetails = [];

      for(PassengersWithSSR currentItem in state.manageBookingResponse?.result?.passengersWithSSR ?? []){
        var currentOne = OutboundCheckInPassengerDetails(
            flightNumber: currentItem.checkInStatusInOut?.outboundCheckInStatus?.flightNumber ?? '',
            departureStationCode: currentItem.checkInStatusInOut?.outboundCheckInStatus?.departureStationCode ?? '',
            inkPaxID: currentItem.checkInStatusInOut?.outboundCheckInStatus?.inkPaxID ?? '',
            passportNumber: '',
            passportExpiryDate: '',
            memberID: currentItem.passengers?.myRewardMemberId ?? '1072'
        );
        request.outboundCheckInPassengerDetails?.add(currentOne);
      }

    }
    else if(state.checkReturn){

      request.inboundCheckInPassengerDetails = [];

      for(PassengersWithSSR currentItem in state.manageBookingResponse?.result?.passengersWithSSR ?? []){
        var currentOne = OutboundCheckInPassengerDetails(
          flightNumber: currentItem.checkInStatusInOut?.inboundCheckInStatus?.flightNumber ?? '',
          departureStationCode: currentItem.checkInStatusInOut?.inboundCheckInStatus?.departureStationCode ?? '',
          inkPaxID: currentItem.checkInStatusInOut?.inboundCheckInStatus?.inkPaxID ?? '',
          passportNumber: '',
          passportExpiryDate: '',
          memberID: currentItem.passengers?.myRewardMemberId ?? ''
        );
        request.inboundCheckInPassengerDetails?.add(currentOne);
      }
//      List<>? inboundCheckInPassengerDetails;

    }

    final verifyResponse = await _checkInRepository.checkInPassenger(request);

  }
  Future<bool?> getBookingsListing() async {
    emit(
      state.copyWith(
        isLoadingInfo: true,
        message: '',
      ),
    );

    try {
      final verifyResponse = await _manageBookingRepository.bookingListing();

      emit(
        state.copyWith(
            upcomingBookings: verifyResponse.upcomingBookings,
            pastBookings: verifyResponse.pastBookings,
            blocState: BlocState.finished,
            isLoadingInfo: false,
            listToCall: true),
      );
      return true;
    } catch (e, st) {
      emit(
        state.copyWith(
          message: ErrorUtils.getErrorMessage(e, st, dontShowError: true),
          blocState: BlocState.failed,
          isLoadingInfo: false,
        ),
      );
      return false;
    }
  }

  Future<bool?> getBookingInformation(String lastName, String pnr,
      {UpcomingBookings? bookSelected}) async {
    emit(
      state.copyWith(
        loadingListDetailItem: true,
        message: '',
      ),
    );

    try {
      final verifyResponse =
          await _manageBookingRepository.getBookingInfoForCheckIn(
        ManageBookingRequest(
            pnr: bookSelected != null ? bookSelected.pnr : pnr,
            lastname: bookSelected != null ? bookSelected.lastName : lastName),
      );

      emit(
        state.copyWith(
            blocState: BlocState.finished,
            manageBookingResponse: verifyResponse,
            loadingListDetailItem: false,
            bookingSelected: bookSelected,
            pnrEntered: bookSelected != null ? bookSelected.pnr : pnr,
            lastName: bookSelected != null ? bookSelected.lastName : lastName),
      );
      return true;
    } catch (e, st) {
      emit(
        state.copyWith(
          message: ErrorUtils.getErrorMessage(e, st, dontShowError: true),
          blocState: BlocState.failed,
          isLoadingInfo: false,
        ),
      );
      return false;
    }
  }

  bool get showPassport {
    return state.manageBookingResponse?.result?.isRequiredPassport ?? false;
  }

  bool get isReturn {
    return state.manageBookingResponse?.result?.isReturn ?? false;
  }

/*
  bool get isReturn {
    return state.manageBookingResponse?.result?.isReturn ?? false;
  }*/

}
