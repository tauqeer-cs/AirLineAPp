import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'switch_setting.g.dart';

enum AvailableSetting {
  myReward,
  insurance,
}

@CopyWith(copyWithNull: true)
@JsonSerializable(explicitToJson: true)
class SwitchSetting extends Equatable {
  const SwitchSetting({
    this.myReward,
    this.insurance,
    this.passwordMinLength = 8,
    this.passwordMaxLength = 30,
    this.passwordRegex = '^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}\$',
    this.passwordRegexErrorMessage,
  });

  final bool? myReward;
  final bool? insurance;
  final int passwordMinLength;
  final int passwordMaxLength;
  final String passwordRegex;
  final String? passwordRegexErrorMessage;

  factory SwitchSetting.fromJson(Map<String, dynamic> json) =>
      _$SwitchSettingFromJson(json);

  Map<String, dynamic> toJson() => _$SwitchSettingToJson(this);

  static const empty = SwitchSetting(insurance: false, myReward: false);

  @override
  List<Object?> get props => [
        myReward,
        insurance,
      ];
}
