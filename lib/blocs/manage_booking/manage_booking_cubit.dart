import 'package:bloc/bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:paged_vertical_calendar/utils/date_utils.dart';
import '../../app/app_bloc_helper.dart';
import '../../app/app_flavor.dart';
import '../../data/repositories/manage_book_repository.dart';
import '../../data/requests/book_request.dart';
import '../../data/requests/change_flight_request.dart';
import '../../data/requests/manage_booking_request.dart';
import '../../data/requests/mmb_checkout_request.dart';
import '../../data/requests/search_change_flight_request.dart';
import '../../data/responses/flight_response.dart';
import '../../data/responses/manage_booking_response.dart';
import '../../models/pay_redirection.dart';
import '../../utils/error_utils.dart';
import '../../data/responses/change_flight_response.dart';

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
                  const Duration(days: 1),
                ) ??
            DateTime.now();
      }
    }
    return DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day)
        .removeTime();
  }

  DateTime get maxDate {
    var ccc = state.manageBookingResponse;
    if (ccc?.isTwoWay ?? false) {
      if (state.checkedDeparture == true && state.checkReturn == false) {
        return ccc?.currentEndDate?.removeTime().add(
                  const Duration(days: -1),
                ) ??
            DateTime.now();
      } else if (state.checkedDeparture == false && state.checkReturn == true) {
        return DateTime.now().add(const Duration(days: 365)).removeTime();
      }
    }
    return DateTime.now().add(const Duration(days: 365)).removeTime();
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

  double? get totalAmountToShowInChangeFlight {
    num totalChange = 0.0;

    var currentIterter = state.manageBookingResponse?.result?.passengersWithSSR;

    int multiplier = 0;

    for (PassengersWithSSR currentItem in currentIterter ?? []) {
      if(!isWithinTwoYears(currentItem.passengers?.dob ?? DateTime.now())){
        multiplier++;

      }

    }

    if (state.selectedDepartureFlight != null) {
      totalChange =
          (state.selectedDepartureFlight?.changeFlightAmountToShow ?? 0.0) *
              multiplier;
    }

    if (state.selectedReturnFlight != null) {
      totalChange =
          totalChange + (state.selectedReturnFlight?.changeFlightAmountToShow ?? 0.0) *
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

  Future<void> reloadDataForConfirmation() async {
    emit(
      state.copyWith(
          loadingSummary: true, message: '', blocState: BlocState.initial),
    );

    try {
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

//getAvailableFlights

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
    emit(state.copyWith(
      isLoadingInfo: true,
      message: '',
    ));

    //   var tempKey = 'EAT6GA';
    //var tempKey = 'STY1VX';
    //var tempKey = 'SS5G2M';
    //var tempKey = 'MWJC8Q';

    //  var tempKey = '4H1I6Q';

    try {
      final verifyResponse = await _repository.getBookingInfo(
        ManageBookingRequest(pnr: bookingReference, lastname: lastName),
      );

      emit(
        state.copyWith(
            blocState: BlocState.finished,
            dataLoaded: true,
            manageBookingResponse: verifyResponse,
            isLoadingInfo: false,
            checkedDeparture: false,
            checkReturn: false,
            pnrEntered: bookingReference,
            lastName: lastName),
      );
      return true;
    } catch (e, st) {
      emit(
        state.copyWith(
            message: ErrorUtils.getErrorMessage(e, st),
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
    //state.copyWithN;
    //emit(state.copyWithNull(selectedDeparture: true));

    emit(
      state.copyWithNull(selectedDepartureFlight: true),
    );

    //
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
              lFID: state.selectedReturnFlight?.lfid?.toInt() ?? 0,
              fBCode: state.selectedReturnFlight?.fbCode ?? '',
            ),
          ],
          outboundFares: [
            OutboundFares(
              lFID: state.selectedDepartureFlight?.lfid?.toInt() ?? 0,
              fBCode: state.selectedDepartureFlight?.fbCode ?? '',
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
                lFID: state.selectedDepartureFlight?.lfid?.toInt() ?? 0,
                fBCode: state.selectedDepartureFlight?.fbCode ?? '',
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
                lFID: state.selectedDepartureFlight?.lfid?.toInt() ?? 0,
                fBCode: state.selectedDepartureFlight?.fbCode ?? '',
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
                lFID: state.selectedReturnFlight?.lfid?.toInt() ?? 0,
                fBCode: state.selectedReturnFlight?.fbCode ?? '',
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
      //
      emit(
        state.copyWith(loadingCheckoutPayment: true, message: ''),
      );

      var request = MmbCheckoutRequest(
        superPNRNo: '',
        insertVoucher: voucher ?? '',
        paymentDetail: PaymentDetail(
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
        ),
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
    //: true);
    //
    emit(
      state.copyWith(
        message: '',
        manageBookingResponse: newBookingObject,
      ),
    );
  }
}
