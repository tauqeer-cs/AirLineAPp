import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/public_repository.dart';
import 'package:app/models/switch_setting.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsState());
  final _repository = PublicRepository();

  getSettings() async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final settings = await _repository.getSettings();
      emit(state.copyWith(
        blocState: BlocState.finished,
        switchSetting: settings,
      ));
    } catch (e, st) {
      ErrorUtils.getErrorMessage(e, st);
      emit(
        state.copyWith(
          message: ErrorUtils.getErrorMessage(e, st),
          blocState: BlocState.failed,
        ),
      );
    }
  }
}
