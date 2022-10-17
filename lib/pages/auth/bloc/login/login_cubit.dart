import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();

  onChangedRememberMe(bool isRememberMe) {
    emit(state.copyWith(isRememberMe: isRememberMe));
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      await _authenticationRepository.logInWithGoogle();
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
