import 'package:app/blocs/settings/settings_cubit.dart';
import 'package:app/models/switch_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsWrapper extends StatelessWidget {
  final Widget child;
  final AvailableSetting settingType;
  const SettingsWrapper({
    Key? key,
    required this.child, required this.settingType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final setting = context.watch<SettingsCubit>().state.switchSetting;
    switch (settingType){
      case AvailableSetting.myReward:
        return childOrSizedBox(setting.myReward ?? false);
      case AvailableSetting.insurance:
        return childOrSizedBox(setting.insurance ?? false);
      default:
        return const SizedBox.shrink();
    }
  }

  childOrSizedBox(bool isShow){
    return isShow ? child : SizedBox.shrink();
  }
}
