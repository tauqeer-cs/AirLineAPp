import 'package:app/app/app_bloc_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/checkin_repository.dart';
import '../../../data/repositories/manage_book_repository.dart';
import '../../../data/requests/boarding_pass_request.dart';
import '../../../data/requests/check_in_request.dart';
import '../../../data/requests/get_boarding_pass_request.dart';
import '../../../data/requests/manage_booking_request.dart';
import '../../../data/responses/boardingpass_passenger_response.dart';
import '../../../data/responses/check_in_response.dart';
import '../../../data/responses/manage_booking_response.dart';
import '../../../models/my_bookings.dart';
import '../../../utils/error_utils.dart';
import '../../../utils/file_utils.dart';

part 'check_in_state.dart';

part 'check_in_cubit.g.dart';

class CheckInCubit extends Cubit<CheckInState> {
  CheckInCubit()
      : super(
          const CheckInState(),
        );

  final _manageBookingRepository = ManageBookingRepository();
  final _checkInRepository = CheckInRepository();

  bool get outBoundCheckInDoneForAnyUser {
    for (PassengersWithSSR currentItem
        in state.manageBookingResponse?.result?.passengersWithSSR ?? []) {
      if (currentItem.checkInStatusInOut?.outboundCheckInStatus != null) {
        if (currentItem
                .checkInStatusInOut?.outboundCheckInStatus?.checkInStatus ==
            'Checked In') {
          return true;
        }
      }
    }

    return false;
  }

  bool get inBoundCheckInDoneForAnyUser {
    for (PassengersWithSSR currentItem
        in state.manageBookingResponse?.result?.passengersWithSSR ?? []) {
      if (currentItem.checkInStatusInOut?.inboundCheckInStatus != null) {
        if (currentItem
                .checkInStatusInOut?.inboundCheckInStatus?.checkInStatus ==
            'Checked In') {
          return true;
        }
      }
    }

    return false;
  }

  //showCheckInButton
  bool get isOpenToCheck {
    for (PassengersWithSSR currentItem
        in state.manageBookingResponse?.result?.passengersWithSSR ?? []) {
      if (currentItem.checkInStatusInOut?.outboundCheckInStatus != null) {
        if (currentItem
                .checkInStatusInOut?.outboundCheckInStatus?.checkInStatus ==
            'Open for check-in') {
          return true;
        }
      }

      if (currentItem.checkInStatusInOut?.inboundCheckInStatus != null) {
        if (currentItem
                .checkInStatusInOut?.inboundCheckInStatus?.checkInStatus ==
            'Open for check-in') {
          return true;
        }
      }
    }

    return false;
  }

  bool get showCheckInButton {
    for (PassengersWithSSR currentItem
        in state.manageBookingResponse?.result?.passengersWithSSR ?? []) {
      if (currentItem.checkInStatusInOut?.outboundCheckInStatus != null) {
        if (currentItem
                .checkInStatusInOut?.outboundCheckInStatus?.checkInStatus ==
            'Checked In') {
          return true;
        }
      }

      if (currentItem.checkInStatusInOut?.inboundCheckInStatus != null) {
        if (currentItem
                .checkInStatusInOut?.inboundCheckInStatus?.checkInStatus ==
            'Checked In') {
          return true;
        }
      }
    }

    return false;
  }

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

  bool get anyPersonChecked {
    for (PassengersWithSSR currentItem
        in state.manageBookingResponse?.result?.passengersWithSSR ?? []) {
      if (currentItem.paxSelected == true) {
        return true;
      }
    }

    return false;
  }

  bool get showCheckIn {
    if (anyPersonChecked == false) {
      return false;
    }
    if (state.checkReturn == true || state.checkedDeparture == true) {
      return true;
    }

    return false;
  }

  Future<void> setPerson(bool value, int index) async {
    var tmpValue = state.manageBookingResponse;
    tmpValue?.result?.passengersWithSSR?[index].paxSelected = value;

    emit(
      state.copyWith(
        manageBookingResponse: tmpValue,
        checkReturn: state.checkReturn,
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

  Future<String?> getBoardingPassPassengers(bool outbound) async {
    var request = GetBoardingPassPassengerRequest(
        pNR: state.pnrEntered,
        lastName: state.lastName,
        getInboundPassenger: false,
        getOutboundPassenger: true);

    BoardingPassRequest request2 = BoardingPassRequest();
    request2.pNR = state.pnrEntered;
    request2.lastName = state.lastName;
    request2.getBoardingPassBy = 'Download';
    request2.boardingPassPax = [];

    /*
    var boardItem = BoardingPassPax(
        lastName: currentPass.lastName,
        logicalFlightKey: currentPass.logicalFlightKey,
        personOrgId: currentPass.personOrgId);

    request2.boardingPassPax?.add(boardItem);*/

    if (outbound) {
      for (BoardingPassPassenger currentOne
          in state.outboundBoardingPassPassenger ?? []) {
        var boardItem = BoardingPassPax(
            lastName: currentOne.lastName,
            logicalFlightKey: currentOne.logicalFlightKey,
            personOrgId: currentOne.personOrgId);
        request2.boardingPassPax?.add(boardItem);

        var filesResponse = await _checkInRepository.getBoardingPass(request2);

        await FileUtils.downloadFile(
            filesResponse.boardingPassURLs?.first ?? '',
            makeFileName(state.pnrEntered ?? '',
                (currentOne.fullName ?? '').replaceAll(' ', '')));

      }
    } else {
      for (BoardingPassPassenger currentOne
          in state.inboundBoardingPassPassenger ?? []) {
        var boardItem = BoardingPassPax(
            lastName: currentOne.lastName,
            logicalFlightKey: currentOne.logicalFlightKey,
            personOrgId: currentOne.personOrgId);
        request2.boardingPassPax?.add(boardItem);

        var filesResponse = await _checkInRepository.getBoardingPass(request2);


        await FileUtils.downloadFile(
            filesResponse.boardingPassURLs?.first ?? '',
            makeFileName(state.pnrEntered ?? '',
                (currentOne.fullName ?? '').replaceAll(' ', '')));

      }
    }


  }

  String makeFileName(String pnr, String name) {
    return '${pnr}_$name.pdf';
  }

  Future<void> checkInFlight() async {
    var request = CheckInRequest();
    try {
      emit(
        state.copyWith(
          checkingInFlight: true,
        ),
      );

      request.lastName = state.lastName;
      request.pNR = state.pnrEntered;
      request.superPNRNo =
          state.manageBookingResponse?.result?.superPNR?.superPNRNo ?? '';
      request.superPNRID =
          state.manageBookingResponse?.result?.superPNR?.superPNRID?.toInt();

      if (state.checkedDeparture) {
        request.outboundCheckInPassengerDetails = [];

        for (PassengersWithSSR currentItem
            in state.manageBookingResponse?.result?.passengersWithSSR ?? []) {


          var currentOne = OutboundCheckInPassengerDetails(
              flightNumber: currentItem.checkInStatusInOut
                      ?.outboundCheckInStatus?.flightNumber ??
                  '',
              departureStationCode: currentItem.checkInStatusInOut
                      ?.outboundCheckInStatus?.departureStationCode ??
                  '',
              inkPaxID: currentItem
                      .checkInStatusInOut?.outboundCheckInStatus?.inkPaxID ??
                  '',
              passportNumber: '',
              passportExpiryDate: '',
              memberID: currentItem.passengers?.myRewardMemberId ?? '');

          if(currentItem.paxSelected == true){
            request.outboundCheckInPassengerDetails?.add(currentOne);

          }



        }
      } else if (state.checkReturn) {
        request.inboundCheckInPassengerDetails = [];

        for (PassengersWithSSR currentItem
            in state.manageBookingResponse?.result?.passengersWithSSR ?? []) {
          var currentOne = OutboundCheckInPassengerDetails(
              flightNumber: currentItem
                      .checkInStatusInOut?.inboundCheckInStatus?.flightNumber ??
                  '',
              departureStationCode: currentItem.checkInStatusInOut
                      ?.inboundCheckInStatus?.departureStationCode ??
                  '',
              inkPaxID: currentItem
                      .checkInStatusInOut?.inboundCheckInStatus?.inkPaxID ??
                  '',
              passportNumber: '',
              passportExpiryDate: '',
              memberID: currentItem.passengers?.myRewardMemberId ?? '');
          request.inboundCheckInPassengerDetails?.add(currentOne);
        }
      }

      CheckInResponse? verifyResponse =
          await _checkInRepository.checkInPassenger(request);

      if (verifyResponse.success == false) {
        emit(
          state.copyWith(
              message:
                  ErrorUtils.showErrorMessage(verifyResponse.errorMessages),
              blocState: BlocState.failed,
              checkingInFlight: false),
        );
      }

      return;
    } catch (e, st) {
      emit(
        state.copyWith(
            message: ErrorUtils.getErrorMessage(
              e,
              st,
            ),
            blocState: BlocState.failed,
            checkingInFlight: false),
      );
      return;
    }
  }

  Future<bool?> getBookingsListing() async {
    emit(
      state.copyWith(
        isLoadingInfo: true,
        message: '',
        listToCall: true,
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
          message: ErrorUtils.getErrorMessage(
            e,
            st,
          ),
          blocState: BlocState.failed,
          isLoadingInfo: false,
          listToCall: false,
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
        bookingSelected: bookSelected,
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
          message: ErrorUtils.getErrorMessage(e, st, dontShowError: false),
          blocState: BlocState.failed,
          loadingListDetailItem: false,
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

  void loadBoardingDate() async {
    if (state.inboundBoardingPassPassenger != null ||
        state.outboundBoardingPassPassenger != null) {
      return;
    }
    emit(
      state.copyWith(
        loadBoardingDate: true,
      ),
    );

    try {
      var request = GetBoardingPassPassengerRequest(
          pNR: state.pnrEntered,
          lastName: state.lastName,
          getInboundPassenger: inBoundCheckInDoneForAnyUser,
          getOutboundPassenger: outBoundCheckInDoneForAnyUser);

      BoardingpassPassengerResponse? response =
          await _checkInRepository.getBoardingpassPassenger(request);

      emit(
        state.copyWith(
            loadBoardingDate: false,
            inboundBoardingPassPassenger: response.inboundBoardingPassPassenger,
            outboundBoardingPassPassenger:
                response.outboundBoardingPassPassenger),
      );
    } catch (e, st) {
      emit(
        state.copyWith(
          message: ErrorUtils.getErrorMessage(
            e,
            st,
          ),
          blocState: BlocState.failed,
          loadBoardingDate: false,
        ),
      );
      return;
    }
  }

/*
  bool get isReturn {
    return state.manageBookingResponse?.result?.isReturn ?? false;
  }*/

}
