import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/data/requests/update_password_request.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class DeleteAccountCubit extends Cubit<GenericState> {
  final AuthenticationRepository _authenticationRepository =
  AuthenticationRepository();

  DeleteAccountCubit() : super(GenericState());

  deleteAccount(String email, String password) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final UpdatePasswordRequest updatePasswordRequest =
      UpdatePasswordRequest(email: email, password: password);
      await _authenticationRepository.closeAccount(updatePasswordRequest);
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
