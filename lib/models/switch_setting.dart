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
  });

  final bool? myReward;
  final bool? insurance;

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
