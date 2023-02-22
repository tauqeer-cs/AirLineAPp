import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../app/app_bloc_helper.dart';
import '../../data/repositories/manage_book_repository.dart';
import '../../data/requests/manage_booking_request.dart';
import '../../data/responses/manage_booking_response.dart';
import '../../utils/error_utils.dart';

part 'manage_booking_state.dart';

class ManageBookingCubit extends Cubit<ManageBookingState> {
  ManageBookingCubit()
      : super(
          const ManageBookingState(),
        );

  final _repository = ManageBookingRepository();

  getBookingInformation(String lastName, String bookingReference) async {
    emit(state.copyWith(isLoadingInfo: true));

    try {
      final verifyResponse = await _repository.getBookingInfo(
        ManageBookingRequest(pnr: 1 == 1 ? 'ZV9LE8' : bookingReference, lastname: 1 == 1 ? 'Ahmed' : lastName),
      );

      emit(
        state.copyWith(
            blocState: BlocState.finished,
            dataLoaded: true,
            manageBookingResponse: verifyResponse,
            isLoadingInfo: false,
            pnrEntered: bookingReference),
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
      state.copyWith(
        checkedDeparture: value
      ),
    );
  }

  void setCheckReturn(bool value) {

    emit(
      state.copyWith(
          checkReturn: value
      ),
    );
  }

}
