import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/data/requests/signup_request.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupState());
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  signup(SignupRequest signupRequest) async {
    final newRequest = state.signupRequest.copyWith(
      gender: signupRequest.gender,
      dob: signupRequest.dob,
      address: signupRequest.address,
      city: signupRequest.city,
      state: signupRequest.state,
      postCode: signupRequest.postCode,
      country: signupRequest.country,

    );
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      await _authenticationRepository.signUp(newRequest);
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

  addAccountDetail(SignupRequest signupRequest) {
    emit(
      state.copyWith(
          signupRequest: signupRequest, blocState: BlocState.initial),
    );
  }
}
