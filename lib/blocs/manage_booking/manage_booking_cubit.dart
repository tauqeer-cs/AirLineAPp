import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../app/app_bloc_helper.dart';
import '../../data/repositories/manage_book_repository.dart';
import '../../data/requests/manage_booking_request.dart';
import '../../utils/error_utils.dart';

part 'manage_booking_state.dart';

class ManageBookingCubit extends Cubit<ManageBookingState> {
  ManageBookingCubit()
      : super(
          const ManageBookingState(),
        );

  final _repository = ManageBookingRepository();

  getBookingInformation(String lastName, String bookingReference) async {
    //https://mya-api.alphareds.com/api/mobile/v1/checkout/managebookingdetail?pnr=DZQXPJ&lastname=Lee
    emit(state.copyWith(isLoadingInfo: true));

    try {
      final verifyResponse = await _repository.getBookingInfo(
        ManageBookingRequest(pnr: bookingReference, lastname: lastName),
      );
    }
    catch(e,st) {
      emit(
        state.copyWith(
            message: ErrorUtils.getErrorMessage(e, st),
            blocState: BlocState.failed),
      );

    }


  }
}
