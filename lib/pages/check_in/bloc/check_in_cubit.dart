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

    if (tmpValue?.result?.passengersWithSSR?[index].haveInfant == true) {
      tmpValue?.result?.passengersWithSSR
          ?.firstWhere((element) =>
              element.passengers?.givenName ==
                  tmpValue.result?.passengersWithSSR?[index].infantGivenName &&
              element.passengers?.surname ==
                  tmpValue.result?.passengersWithSSR?[index].infantSurname &&
              element.passengers?.passengerType == 'INF')
          .paxSelected = value;
    }
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

  Future<bool?> getBoardingPassPassengers(
    bool outbound, {
    bool onlySelected = false,
    var boodSides = false,
    bool email = false,
    String? emailText,
  }) async {
    try {
      BoardingPassRequest request2 = BoardingPassRequest();
      request2.pNR = state.pnrEntered;
      request2.lastName = state.lastName;
      request2.email = emailText;

      if (email == true) {
        request2.getBoardingPassBy = 'Email';
      } else {
        request2.getBoardingPassBy = 'Download';
      }
      request2.boardingPassPax = [];

      emit(
        state.copyWith(isDownloading: true),
      );

      if (outbound || (boodSides == true)) {
        for (BoardingPassPassenger currentOne
            in state.outboundBoardingPassPassenger ?? []) {
          if (onlySelected == true && currentOne.checkedToDownload != true) {
          } else {
            var boardItem = BoardingPassPax(
                lastName: currentOne.lastName,
                logicalFlightKey: currentOne.logicalFlightKey,
                personOrgId: currentOne.personOrgId);

            if (email) {
              request2.boardingPassPax?.add(boardItem);
            }
            else {
              request2.boardingPassPax?.add(boardItem);

              var filesResponse =
                  await _checkInRepository.getBoardingPass(request2);

              if (email == false) {
                await FileUtils.downloadFile(
                  filesResponse.boardingPassURLs?.first ?? '',
                  makeFileName(
                    state.pnrEntered ?? '',
                    (currentOne.fullName ?? '').replaceAll(' ', ''),
                  ),
                );
              }
            }
          }
        }
      }

      if (outbound == false || (boodSides == true)) {
        for (BoardingPassPassenger currentOne
            in state.inboundBoardingPassPassenger ?? []) {
          if (onlySelected == true && currentOne.checkedToDownload != true) {
          } else {
            var boardItem = BoardingPassPax(
                lastName: currentOne.lastName,
                logicalFlightKey: currentOne.logicalFlightKey,
                personOrgId: currentOne.personOrgId);


            if (email) {
              request2.boardingPassPax?.add(boardItem);
            }
            else {
              request2.boardingPassPax?.add(boardItem);

              var filesResponse =
              await _checkInRepository.getBoardingPass(request2);

              if (email == false) {
                await FileUtils.downloadFile(
                  filesResponse.boardingPassURLs?.first ?? '',
                  makeFileName(
                    state.pnrEntered ?? '',
                    (currentOne.fullName ?? '').replaceAll(' ', ''),
                  ),
                );
              }

            }

          }
        }
      }

      var filesResponse =
      await _checkInRepository.getBoardingPass(request2);

      if (email == true) {
        emit(
          state.copyWith(isDownloading: false),
        );
      } else {
        emit(
          state.copyWith(isDownloading: false),
        );
      }

      return true;
    } catch (e, st) {
      emit(
        state.copyWith(
            message: ErrorUtils.getErrorMessage(
              e,
              st,
            ),
            isDownloading: false),
      );
      return false;
    }
  }

  String makeFileName(String pnr, String name) {
    return '${pnr}_$name.pdf';
  }

  Future<dynamic> checkInFlight() async {
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
              passportNumber: currentItem.checkInPassportNo ?? '',
              passportExpiryDate: currentItem.passExpdate ?? '',
              memberID: currentItem.checkInMemberID ?? '',
              passportIssueCountryCode: currentItem.passportCountry ?? '');

          if (currentItem
                  .checkInStatusInOut?.outboundCheckInStatus?.allowCheckIn ==
              true) {
            if (currentItem.paxSelected == true) {
              request.outboundCheckInPassengerDetails?.add(currentOne);
            }
          }
        }
      }

      if (state.checkReturn) {
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
              memberID: currentItem.checkInMemberID ?? '');

          if (currentItem
                  .checkInStatusInOut?.inboundCheckInStatus?.allowCheckIn ==
              true) {
            if (currentItem.paxSelected == true) {
              request.inboundCheckInPassengerDetails?.add(currentOne);
            }
          }
        }
      }

      CheckInResponse? verifyResponse =
          await _checkInRepository.checkInPassenger(request);

      if (verifyResponse.success == false) {
        ErrorUtils.showErrorMessage(verifyResponse.errorMessages);

        ///                                    bloc.resetStatesForBoarding();
        emit(
          state.copyWith(checkingInFlight: false,
            inboundBoardingPassPassenger: [],
            outboundBoardingPassPassenger: [],
          ),
        );

        return false;
      }

      emit(
        state.copyWith(listToCall: false, checkingInFlight: false),
      );

      //getBookingsListing
      return true;
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
      return false;
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
      {UpcomingBookings? bookSelected,Function(String error)? errorToShow}) async {
    emit(state.copyWithNull(
      inboundBoardingPassPassenger: false,
      outboundBoardingPassPassenger: false,
    ));

    emit(
      state.copyWith(
        loadingListDetailItem: true,
        isLoadingInfo: true,
        bookingSelected: bookSelected,
        message: '',
        inboundBoardingPassPassenger: [],
        outboundBoardingPassPassenger: [],
        checkedDeparture: false,
        checkReturn: false,
        checkingInFlight: false,
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
            isLoadingInfo: false,
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
          message: ErrorUtils.getErrorMessage(e, st, dontShowError: errorToShow != null),
          blocState: BlocState.failed,
          loadingListDetailItem: false,
          isLoadingInfo: false,
        ),
      );

      if(errorToShow != null) {

        errorToShow.call(ErrorUtils.getErrorMessage(e, st, dontShowError: true));


      }

      return false;
    }
  }

  bool get showPassport {
    return state.manageBookingResponse?.result?.isRequiredPassport ?? false;
  }

  bool get isReturn {
    return state.manageBookingResponse?.result?.isReturn ?? false;
  }

  void loadBoardingDate({bool inside = false,bool forceCall = false}) async {

    if(forceCall == true ){

    } else
    if ((state.inboundBoardingPassPassenger ?? []).isNotEmpty ||
        (state.outboundBoardingPassPassenger ?? []).isNotEmpty) {
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
          getInboundPassenger:
              inside ? state.checkReturn : inBoundCheckInDoneForAnyUser,
          getOutboundPassenger:
              inside ? state.checkedDeparture : outBoundCheckInDoneForAnyUser);


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

  void updateStatusOfOutBoundCheckUserForDownload(
      BoardingPassPassenger currentItem, bool value) {
    var outbound = state.outboundBoardingPassPassenger;

    int? index = outbound?.indexOf(currentItem);

    if (index != null) {
      BoardingPassPassenger? found = outbound?[index];
      if (found != null) {
        found.checkedToDownload = value;

        emit(
          state.copyWith(
              loadBoardingDate: false, outboundBoardingPassPassenger: outbound),
        );
      }
    }
    //BoardingPassPassenger? found = outbound?.firstWhere((element) => element.fullName == currentItem.fullName && element.personOrgId == currentItem.personOrgId);

    //
  }

  void updateStatusOfInBoundCheckUserForDownload(
      BoardingPassPassenger currentItem, bool value) {
    var inbound = state.inboundBoardingPassPassenger;

    int? index = inbound?.indexOf(currentItem);

    if (index != null) {
      BoardingPassPassenger? found = inbound?[index];
      if (found != null) {
        found.checkedToDownload = value;

        emit(
          state.copyWith(
              loadBoardingDate: false, inboundBoardingPassPassenger: inbound),
        );
      }
    }
  }

  void updateOutBoundtatusForDownload(
      BoardingPassPassenger currentItem, bool value) {
    var inbound = state.outboundBoardingPassPassenger;

    int? index = inbound?.indexOf(currentItem);

    if (index != null) {
      BoardingPassPassenger? found = inbound?[index];
      if (found != null) {
        found.checkedToDownload = value;

        emit(
          state.copyWith(
              loadBoardingDate: false, outboundBoardingPassPassenger: inbound),
        );
      }
    }


  }

  void resetList() {
    emit(state.copyWith(
      listToCall: false,
    ));
  }

  Future<void> resetStates() async {
    emit(state.copyWith(
      checkedDeparture: false,
      checkReturn: false,
      checkingInFlight: false,
    ));

    emit(state.copyWithNull(
      inboundBoardingPassPassenger: false,
      outboundBoardingPassPassenger: false,
    ));
  }

  Future<void> resetStatesForBoarding() async {


    state.copyWith(
      inboundBoardingPassPassenger: [],
      outboundBoardingPassPassenger: [],

    );

  }


/*
  bool get isReturn {
    return state.manageBookingResponse?.result?.isReturn ?? false;
  }*/

}
