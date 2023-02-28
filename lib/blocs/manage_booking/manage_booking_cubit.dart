import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
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
import '../../data/responses/change_flight_response.dart' as CRP;

part 'manage_booking_state.dart';

class ManageBookingCubit extends Cubit<ManageBookingState> {
  ManageBookingCubit()
      : super(
          const ManageBookingState(),
        );

  final _repository = ManageBookingRepository();

  void selectedDepartureFlight(InboundOutboundSegment segment) {
    emit(
      state.copyWith(selectedDepartureFlight: segment),
    );
  }

  void selectedReturnFlight(InboundOutboundSegment segment) {
    emit(
      state.copyWith(selectedReturnFlight: segment),
    );
  }

  Future<void> reloadDataForConfirmation() async {
//https://mya-api.alphareds.com/api/mobile/v1/checkout/managebookingdetail?pnr=61USNM&lastname=TESTTWO
    emit(
      state.copyWith(
        loadingSummary: true,
      ),
    );

    try {
      final verifyResponse = await _repository.getBookingInfo(
        ManageBookingRequest(
            pnr: state.pnrEntered,
            lastname:  state.lastName),
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
    if(state.manageBookingResponse?.isTwoWay == true && state.checkedDeparture == false && state.checkReturn == true) {

      newBookingObject?.customSelected = true;

      newBookingObject?.newStartDateSelected = null;
      newBookingObject?.newReturnDateSelected = date;

      emit(
        state.copyWith(
            blocState: BlocState.finished,
            manageBookingResponse: newBookingObject),
      );

    }
    else if(state.manageBookingResponse?.isTwoWay == true && state.checkedDeparture == true && state.checkReturn == false) {
      newBookingObject?.customSelected = true;
      newBookingObject?.newReturnDateSelected = null;

      newBookingObject?.newStartDateSelected = date;

      emit(
        state.copyWith(
            blocState: BlocState.finished,
            manageBookingResponse: newBookingObject),
      );
      return;
    }
    else
      if(state.manageBookingResponse?.isOneWay ?? true ) {
      newBookingObject?.customSelected = true;
      newBookingObject?.newReturnDateSelected = null;

      newBookingObject?.newStartDateSelected = date;

      emit(
        state.copyWith(
            blocState: BlocState.finished,
            manageBookingResponse: newBookingObject),
      );
      return;

    }
    if (newBookingObject?.customSelected == true) {
      newBookingObject?.customSelected = false;
      newBookingObject?.newReturnDateSelected = date;

      emit(
        state.copyWith(
            blocState: BlocState.finished,
            manageBookingResponse: newBookingObject),
      );
      return;
    }
    newBookingObject?.customSelected = true;
    newBookingObject?.newReturnDateSelected = null;

    newBookingObject?.newStartDateSelected = date;

    emit(
      state.copyWith(
          blocState: BlocState.finished,
          manageBookingResponse: newBookingObject),
    );
  }

//getAvailableFlights

  Future<bool?> getAvailableFlights(
      DateTime? startDate, DateTime? endDate) async {
    try {
      var request = SearchChangeFlightRequest.makeRequestObject(
          pnr: state.pnrEntered ?? '',
          lastName: state.lastName ?? '',
          startDate: state.manageBookingResponse?.newStartDateSelected ??
              DateTime.now().add(const Duration(days: 7)),
          endDate: state.manageBookingResponse?.newReturnDateSelected ??
              DateTime.now().add(const Duration(days: 17)));

      if(state.checkedDeparture && state.checkReturn){

      }
      else if((state.manageBookingResponse!.isOneWay ?? false) || state.checkedDeparture) {
        request = SearchChangeFlightRequest.makeRequestObject(
            pnr: state.pnrEntered ?? '',
            lastName: state.lastName ?? '',
            startDate: state.manageBookingResponse?.newStartDateSelected ??
                DateTime.now().add(const Duration(days: 7)),
            endDate: null);
      }
      else if(state.checkReturn){
        request = SearchChangeFlightRequest.makeRequestObject(
            pnr: state.pnrEntered ?? '',
            lastName: state.lastName ?? '',
            startDate: null,
            endDate: state.manageBookingResponse?.newReturnDateSelected ??
                DateTime.now().add(const Duration(days: 17)));
      }

      emit(
        state.copyWith(
          loadingDatesData: true,
        ),
      );

      var response = await _repository.getAvailableFlights(request);

      emit(
        state.copyWith(
          flightSearchResponse: response,
          loadingDatesData: false,
        ),
      );

      return true;
    } catch (e, st) {
      state.copyWith(
        message: ErrorUtils.getErrorMessage(e, st),
        loadingDatesData: false,
      );
      return false;
    }
  }

  Future<bool?> getBookingInformation(
      String lastName, String bookingReference) async {
    emit(state.copyWith(isLoadingInfo: true));

    //   var tempKey = 'EAT6GA';
    //var tempKey = 'STY1VX';
    //var tempKey = 'SS5G2M';
    //var tempKey = 'MWJC8Q';

  //  var tempKey = '4H1I6Q';

    try {
      final verifyResponse = await _repository.getBookingInfo(
        ManageBookingRequest(
            pnr: bookingReference,
            lastname:  lastName),
      );

      emit(
        state.copyWith(
            blocState: BlocState.finished,
            dataLoaded: true,
            manageBookingResponse: verifyResponse,
            isLoadingInfo: false,
            pnrEntered:  bookingReference,
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
      state.copyWith(checkedDeparture: value),
    );
  }

  void setCheckReturn(bool value) {
    emit(
      state.copyWith(checkReturn: value),
    );
  }

  void setDepartureFlight(InboundOutboundSegment segment) {
    //emit(
    //       state.copyWith(
    //         selectedDepartureFlight: segment
    //       ),
    //     );

    state.copyWith(selectedDepartureFlight: segment);
    emit(
      state.copyWith(selectedDepartureFlight: segment),
    );
  }

  void setReturnFlight(InboundOutboundSegment segment) {
    state.copyWith(selectedReturnFlight: segment);
    emit(
      state.copyWith(selectedReturnFlight: segment),
    );
  }

  void removeDepartureFlight(InboundOutboundSegment segment) {
    state.copyWith(removeSelectedDeparture: true);
  }

  void removeReturnFlight(InboundOutboundSegment segment) {
    state.copyWith(removeSelectedReturn: true);
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


      if(state.manageBookingResponse?.isOneWay ?? false) {

        request = ChangeFlightRequest(
            pNR: state.pnrEntered,
            lastName: state.lastName,
            isReturn: false,
            departDate: departureDate,
            returnDate: null,
            inboundFares: [

            ],
            outboundFares: [
              OutboundFares(
                lFID: state.selectedDepartureFlight?.lfid?.toInt() ?? 0,
                fBCode: state.selectedDepartureFlight?.fbCode ?? '',
              ),
            ]);

      }
      else if(state.checkedDeparture == true && state.checkReturn == false){
        request = ChangeFlightRequest(
            pNR: state.pnrEntered,
            lastName: state.lastName,
            isReturn: true,
            departDate: departureDate,
            returnDate: null,
            inboundFares: [

            ],
            outboundFares: [
              OutboundFares(
                lFID: state.selectedDepartureFlight?.lfid?.toInt() ?? 0,
                fBCode: state.selectedDepartureFlight?.fbCode ?? '',
              ),
            ]);

      }
      else if(state.checkedDeparture == false && state.checkReturn == true){

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
            outboundFares: [

            ]);



      }


      emit(
        state.copyWith(
          loadingSelectingFlight: true,
        ),
      );

      var response = await _repository.changeFlight(
        ChangingFlightRequest(changeFlightRequest: request),
      );

      if(response.result?.changeFlightResponse == null && (response.message?.isNotEmpty ?? false)) {
        emit(
          state.copyWith(
            loadingSelectingFlight: false,

          ),
        );

        throw Exception(response.message);


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
        ),
      );
      return false;
    }
  }

  Future<String?> checkOutForPayment() async {
    try {
      //
      emit(
        state.copyWith(
          loadingCheckoutPayment: true,
        ),
      );

      var request = MmbCheckoutRequest(
        superPNRNo: '',
        insertVoucher: '',
        paymentDetail: PaymentDetail(
          frontendUrl: AppFlavor.paymentRedirectUrl,
          promoCode: '',
          totalAmountNeedToPay: state.changeFlightResponse?.result
              ?.changeFlightResponse?.totalReservationAmount,
          totalAmount: state.changeFlightResponse?.result?.changeFlightResponse
              ?.totalReservationAmount,
        ),
        token: state.changeFlightResponse?.result?.token,
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

    print('');

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

    print('');
  }

  void resetData() {


    emit(
      state.copyWith(
        checkedDeparture: false,
        checkReturn: false,

      ),
    );
  }
}
