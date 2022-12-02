import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/data/requests/update_password_request.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<GenericState> {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  ForgetPasswordCubit() : super(const GenericState());

  sendEmailRequest(String email) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final UpdatePasswordRequest updatePasswordRequest =
          UpdatePasswordRequest(email: email);
      await _authenticationRepository.requestReset(updatePasswordRequest);
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
