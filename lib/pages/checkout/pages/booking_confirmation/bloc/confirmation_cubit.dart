import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/flight_repository.dart';
import 'package:app/models/confirmation_model.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import '../../../../../data/repositories/manage_book_repository.dart';
import '../../../../../data/requests/manage_booking_request.dart';

part 'confirmation_state.dart';

class ConfirmationCubit extends Cubit<ConfirmationState> {
  final _repository = FlightRepository();
  final _repositoryManage = ManageBookingRepository();

  ConfirmationCubit() : super(const ConfirmationState());

  String get bookingViewHeading {

    if (state.bookingStatus.isEmpty) {
      return 'confirmation'.tr();
    } else if (state.bookingStatus == 'PPB' || state.bookingStatus == 'BIP') {
      return 'confirmationView.statusPending'.tr();
    } else if (state.bookingStatus == 'EXP') {
      return 'confirmationView.statusExpired'.tr();
    }

    return 'confirmation'.tr();
  }

  getConfirmation(String id, String status) async {
    emit(state.copyWith(
      blocState: BlocState.loading,
      bookingStatus: status,
    ));
    try {
      ConfirmationModel response = await _repository.bookingDetail(id);

      if (status != 'CON') {
//        final manageRequest = ManageBookingRequest(pnr: id,lastname: false ? 'Ahmed' :response.value?.passengers?.first.surname ?? '');

        //      _repositoryManage.getBookingInfo(manageRequest,);

      }
      emit(
        state.copyWith(
            blocState: BlocState.finished,
            confirmationModel: response,
            bookingStatus: status,
            bookingId: id),
      );
    } catch (e, st) {
      emit(
        state.copyWith(
            message: ErrorUtils.getErrorMessage(e, st),
            blocState: BlocState.failed,
            bookingStatus: status,
            bookingId: id),
      );
    }
  }

  void refreshData() async {
    emit(state.copyWith(blocState: BlocState.loading));
    ConfirmationModel response =
        await _repository.bookingDetail(false ? 'D5ZUO0P' : state.bookingId);

    if (response.value == null) {
      emit(
        state.copyWith(
          blocState: BlocState.finished,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        blocState: BlocState.finished,
        confirmationModel: response,
        bookingStatus: response.value?.superPNROrder?.bookingStatusCode,

      ),
    );
  }

  void refreshData2() async {
    emit(state.copyWith(blocState: BlocState.loading));


    await Future.delayed(const Duration(seconds: 6));

    emit(state.copyWith(blocState: BlocState.finished));


  }
}
