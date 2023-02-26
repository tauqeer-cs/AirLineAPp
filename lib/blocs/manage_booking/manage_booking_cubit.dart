import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../app/app_bloc_helper.dart';
import '../../data/repositories/manage_book_repository.dart';
import '../../data/requests/manage_booking_request.dart';
import '../../data/requests/search_change_flight_request.dart';
import '../../data/responses/flight_response.dart';
import '../../data/responses/manage_booking_response.dart';
import '../../utils/error_utils.dart';

part 'manage_booking_state.dart';

class ManageBookingCubit extends Cubit<ManageBookingState> {
  ManageBookingCubit()
      : super(
          const ManageBookingState(),
        );

  final _repository = ManageBookingRepository();

  updateStartDate(DateTime date) async {
    var newBookingObject = state.manageBookingResponse;
    newBookingObject?.newReturnDateSelected = date;

    emit(
      state.copyWith(
          blocState: BlocState.finished,
          manageBookingResponse: newBookingObject),
    );
  }

//getAvailableFlights

  getAvailableFlights(DateTime? startDate, DateTime? endDate) async {
    try {
      var request = SearchChangeFlightRequest.makeRequestObject(
          pnr: state.pnrEntered ?? '',
          lastName: state.lastName ?? '',
          startDate: startDate ?? DateTime.now().add(const Duration(days: 10)),
          endDate: endDate ?? DateTime.now().add(const Duration(days: 17)));

      var response = await _repository.getAvailableFlights(request);

      //
      emit(
        state.copyWith(flightSearchResponse: response),
      );

    } catch (e, st) {
      print('');
      state.copyWith(
          message: ErrorUtils.getErrorMessage(e, st),
          );

    }

    print('object');
  }

  getBookingInformation(String lastName, String bookingReference) async {
    emit(state.copyWith(isLoadingInfo: true));

    try {
      final verifyResponse = await _repository.getBookingInfo(
        ManageBookingRequest(
            pnr: 1 == 1 ? 'OY8G3B' : bookingReference,
            lastname: 1 == 1 ? 'Ahmed' : lastName),
      );

      //
      emit(
        state.copyWith(
            blocState: BlocState.finished,
            dataLoaded: true,
            manageBookingResponse: verifyResponse,
            isLoadingInfo: false,
            pnrEntered: 1 == 1 ? 'OY8G3B' : bookingReference,
            lastName: 1 == 1 ? 'Ahmed' : lastName),
      );
    } catch (e, st) {
      emit(
        state.copyWith(
            message: ErrorUtils.getErrorMessage(e, st),
            blocState: BlocState.failed,
            isLoadingInfo: false),
      );
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
}
