part of 'settings_cubit.dart';


class SettingsState extends Equatable {
  final SwitchSetting switchSetting;
  final BlocState blocState;
  final String message;

  const SettingsState({
    this.switchSetting = SwitchSetting.empty,
    this.blocState = BlocState.initial,
    this.message = '',
  });

  SettingsState copyWith({
    BlocState? blocState,
    String? message,
    SwitchSetting? switchSetting,
  }) {
    return SettingsState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      switchSetting: switchSetting ?? this.switchSetting,
    );
  }

  @override
  List<Object?> get props => [switchSetting, blocState, message];
}

