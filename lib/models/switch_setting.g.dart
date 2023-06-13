// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'switch_setting.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SwitchSettingCWProxy {
  SwitchSetting insurance(bool? insurance);

  SwitchSetting myReward(bool? myReward);

  SwitchSetting passwordMaxLength(int passwordMaxLength);

  SwitchSetting passwordMinLength(int passwordMinLength);

  SwitchSetting passwordRegex(String passwordRegex);

  SwitchSetting passwordRegexErrorMessage(String? passwordRegexErrorMessage);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SwitchSetting(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SwitchSetting(...).copyWith(id: 12, name: "My name")
  /// ````
  SwitchSetting call({
    bool? insurance,
    bool? myReward,
    int? passwordMaxLength,
    int? passwordMinLength,
    String? passwordRegex,
    String? passwordRegexErrorMessage,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSwitchSetting.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSwitchSetting.copyWith.fieldName(...)`
class _$SwitchSettingCWProxyImpl implements _$SwitchSettingCWProxy {
  final SwitchSetting _value;

  const _$SwitchSettingCWProxyImpl(this._value);

  @override
  SwitchSetting insurance(bool? insurance) => this(insurance: insurance);

  @override
  SwitchSetting myReward(bool? myReward) => this(myReward: myReward);

  @override
  SwitchSetting passwordMaxLength(int passwordMaxLength) =>
      this(passwordMaxLength: passwordMaxLength);

  @override
  SwitchSetting passwordMinLength(int passwordMinLength) =>
      this(passwordMinLength: passwordMinLength);

  @override
  SwitchSetting passwordRegex(String passwordRegex) =>
      this(passwordRegex: passwordRegex);

  @override
  SwitchSetting passwordRegexErrorMessage(String? passwordRegexErrorMessage) =>
      this(passwordRegexErrorMessage: passwordRegexErrorMessage);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SwitchSetting(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SwitchSetting(...).copyWith(id: 12, name: "My name")
  /// ````
  SwitchSetting call({
    Object? insurance = const $CopyWithPlaceholder(),
    Object? myReward = const $CopyWithPlaceholder(),
    Object? passwordMaxLength = const $CopyWithPlaceholder(),
    Object? passwordMinLength = const $CopyWithPlaceholder(),
    Object? passwordRegex = const $CopyWithPlaceholder(),
    Object? passwordRegexErrorMessage = const $CopyWithPlaceholder(),
  }) {
    return SwitchSetting(
      insurance: insurance == const $CopyWithPlaceholder()
          ? _value.insurance
          // ignore: cast_nullable_to_non_nullable
          : insurance as bool?,
      myReward: myReward == const $CopyWithPlaceholder()
          ? _value.myReward
          // ignore: cast_nullable_to_non_nullable
          : myReward as bool?,
      passwordMaxLength: passwordMaxLength == const $CopyWithPlaceholder() ||
              passwordMaxLength == null
          ? _value.passwordMaxLength
          // ignore: cast_nullable_to_non_nullable
          : passwordMaxLength as int,
      passwordMinLength: passwordMinLength == const $CopyWithPlaceholder() ||
              passwordMinLength == null
          ? _value.passwordMinLength
          // ignore: cast_nullable_to_non_nullable
          : passwordMinLength as int,
      passwordRegex:
          passwordRegex == const $CopyWithPlaceholder() || passwordRegex == null
              ? _value.passwordRegex
              // ignore: cast_nullable_to_non_nullable
              : passwordRegex as String,
      passwordRegexErrorMessage:
          passwordRegexErrorMessage == const $CopyWithPlaceholder()
              ? _value.passwordRegexErrorMessage
              // ignore: cast_nullable_to_non_nullable
              : passwordRegexErrorMessage as String?,
    );
  }
}

extension $SwitchSettingCopyWith on SwitchSetting {
  /// Returns a callable class that can be used as follows: `instanceOfSwitchSetting.copyWith(...)` or like so:`instanceOfSwitchSetting.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SwitchSettingCWProxy get copyWith => _$SwitchSettingCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `SwitchSetting(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SwitchSetting(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  SwitchSetting copyWithNull({
    bool insurance = false,
    bool myReward = false,
    bool passwordRegexErrorMessage = false,
  }) {
    return SwitchSetting(
      insurance: insurance == true ? null : this.insurance,
      myReward: myReward == true ? null : this.myReward,
      passwordMaxLength: passwordMaxLength,
      passwordMinLength: passwordMinLength,
      passwordRegex: passwordRegex,
      passwordRegexErrorMessage: passwordRegexErrorMessage == true
          ? null
          : this.passwordRegexErrorMessage,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SwitchSetting _$SwitchSettingFromJson(Map<String, dynamic> json) =>
    SwitchSetting(
      myReward: json['myReward'] as bool?,
      insurance: json['insurance'] as bool?,
      passwordMinLength: json['passwordMinLength'] as int? ?? 8,
      passwordMaxLength: json['passwordMaxLength'] as int? ?? 30,
      passwordRegex: json['passwordRegex'] as String? ??
          '^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}\$',
      passwordRegexErrorMessage: json['passwordRegexErrorMessage'] as String?,
    );

Map<String, dynamic> _$SwitchSettingToJson(SwitchSetting instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('myReward', instance.myReward);
  writeNotNull('insurance', instance.insurance);
  val['passwordMinLength'] = instance.passwordMinLength;
  val['passwordMaxLength'] = instance.passwordMaxLength;
  val['passwordRegex'] = instance.passwordRegex;
  writeNotNull('passwordRegexErrorMessage', instance.passwordRegexErrorMessage);
  return val;
}
