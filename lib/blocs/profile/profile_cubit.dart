import 'package:app/data/repositories/profile_repository.dart';
import 'package:app/models/profile.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/cms_repository.dart';
import 'package:app/models/cms_route.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());
  final _repository = ProfileRepository();

  getProfile() async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final routes = await _repository.getProfile();
      emit(state.copyWith(
        blocState: BlocState.finished,
        profile: routes,
      ));
    } catch (e, st) {
      emit(
        state.copyWith(
            message: ErrorUtils.getErrorMessage(e, st),
            blocState: BlocState.failed),
      );
    }
  }
}
