import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/data/requests/update_password_request.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';


class ValidateEmailCubit extends Cubit<GenericState> {
  ValidateEmailCubit() : super(const GenericState());
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  validateEmail(String email) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final UpdatePasswordRequest updatePasswordRequest =
          UpdatePasswordRequest(email: email);
      final commonResponse = await _authenticationRepository.validateEmail(updatePasswordRequest);
      if(commonResponse.success ?? false){
        emit(state.copyWith(blocState: BlocState.finished));
      }else{
        emit(state.copyWith(blocState: BlocState.failed, message: commonResponse.message));
      }
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
