import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/flight_repository.dart';
import 'package:app/models/confirmation_model.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'confirmation_state.dart';

class ConfirmationCubit extends Cubit<ConfirmationState> {
  final _repository = FlightRepository();

  ConfirmationCubit() : super(const ConfirmationState());

  getConfirmation(String id) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final response = await _repository.bookingDetail(id);
      emit(
        state.copyWith(
          blocState: BlocState.finished,
          confirmationModel: response,
        ),
      );
    } catch (e, st) {
      emit(
        state.copyWith(
          message: ErrorUtils.getErrorMessage(e, st),
          blocState: BlocState.failed,
        ),
      );
    }
  }
}
