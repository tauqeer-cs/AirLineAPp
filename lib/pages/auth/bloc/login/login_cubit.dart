import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/data/requests/login_request.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  onChangedRememberMe(bool isRememberMe) {
    emit(state.copyWith(isRememberMe: isRememberMe));
  }

  Future<void> logInWithCredentials(String userName, String password) async {
    emit(state.copyWith(blocState: BlocState.loading, ));
    try {
      final loginRequest = LoginRequest(userName: userName, password: password);
      await _authenticationRepository.loginWithEmailRepo(loginRequest);

    } catch (e, st) {
      emit(
        state.copyWith(
            message: ErrorUtils.getErrorMessage(e, st),
            blocState: BlocState.failed,
            ),
      );
    }
  }

  Future<bool?> logInWithCredentialsFromPopUp(
      String userName, String password,Function() completionHandler) async {
    emit(state.copyWith(blocState: BlocState.loading,
    ));
    try {
      final loginRequest = LoginRequest(userName: userName, password: password);
      User? reply = await _authenticationRepository.loginWithEmailRepo(loginRequest);

      if(reply?.requiredResetPassword == true) {

        completionHandler();

      }
      return true;
    } catch (e, st) {
      emit(
        state.copyWith(
          message: ErrorUtils.getErrorMessage(e, st),
          blocState: BlocState.failed,
        ),
      );
      return false;
    }
  }

  Future<void> logInWithGoogle() async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      await _authenticationRepository.logInWithGoogle();
      emit(state.copyWith(blocState: BlocState.finished));
    } catch (e, st) {
      _authenticationRepository.disconnectGoogleAccount();
      emit(
        state.copyWith(
          message: ErrorUtils.getErrorMessage(e, st),
          blocState: BlocState.failed,
        ),
      );
    }
  }

  Future<void> loginWithApple() async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      await _authenticationRepository.loginWithApple();
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

  logout() async {
    _authenticationRepository.logout();
  }



  changeStatus() {
    emit(state.copyWith(blocState: BlocState.finished));
  }


}
