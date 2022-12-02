import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/data/requests/update_password_request.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<GenericState> {
  UpdatePasswordCubit() : super(const GenericState());
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  updatePassword(UpdatePasswordRequest updatePasswordRequest) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      await _authenticationRepository.updatePassword(updatePasswordRequest);
      emit(state.copyWith(blocState: BlocState.finished));
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
