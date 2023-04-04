import 'package:app/app/app_bloc_helper.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repositories/manage_book_repository.dart';
import '../../../data/requests/manage_booking_request.dart';
import '../../../data/responses/manage_booking_response.dart';
import '../../../models/my_bookings.dart';
import '../../../utils/error_utils.dart';

part 'check_in_state.dart';

class CheckInCubit extends Cubit<CheckInState> {
  CheckInCubit() : super(const CheckInState());

  final _manageBookingRepository = ManageBookingRepository();


  void showUpcoming(bool status){
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
            listToCall : true
        ),
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
      final verifyResponse = await _manageBookingRepository.getBookingInfoForCheckIn(
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
