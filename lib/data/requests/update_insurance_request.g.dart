// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_insurance_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$InsuranceRequestCWProxy {
  InsuranceRequest token(String? token);

  InsuranceRequest updateInsuranceRequest(
      UpdateInsuranceRequest? updateInsuranceRequest);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsuranceRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsuranceRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  InsuranceRequest call({
    String? token,
    UpdateInsuranceRequest? updateInsuranceRequest,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInsuranceRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInsuranceRequest.copyWith.fieldName(...)`
class _$InsuranceRequestCWProxyImpl implements _$InsuranceRequestCWProxy {
  final InsuranceRequest _value;

  const _$InsuranceRequestCWProxyImpl(this._value);

  @override
  InsuranceRequest token(String? token) => this(token: token);

  @override
  InsuranceRequest updateInsuranceRequest(
          UpdateInsuranceRequest? updateInsuranceRequest) =>
      this(updateInsuranceRequest: updateInsuranceRequest);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsuranceRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsuranceRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  InsuranceRequest call({
    Object? token = const $CopyWithPlaceholder(),
    Object? updateInsuranceRequest = const $CopyWithPlaceholder(),
  }) {
    return InsuranceRequest(
      token: token == const $CopyWithPlaceholder()
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String?,
      updateInsuranceRequest:
          updateInsuranceRequest == const $CopyWithPlaceholder()
              ? _value.updateInsuranceRequest
              // ignore: cast_nullable_to_non_nullable
              : updateInsuranceRequest as UpdateInsuranceRequest?,
    );
  }
}

extension $InsuranceRequestCopyWith on InsuranceRequest {
  /// Returns a callable class that can be used as follows: `instanceOfInsuranceRequest.copyWith(...)` or like so:`instanceOfInsuranceRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsuranceRequestCWProxy get copyWith => _$InsuranceRequestCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `InsuranceRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsuranceRequest(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  InsuranceRequest copyWithNull({
    bool token = false,
    bool updateInsuranceRequest = false,
  }) {
    return InsuranceRequest(
      token: token == true ? null : this.token,
      updateInsuranceRequest:
          updateInsuranceRequest == true ? null : this.updateInsuranceRequest,
    );
  }
}

abstract class _$UpdateInsuranceRequestCWProxy {
  UpdateInsuranceRequest isRemoveInsurance(bool? isRemoveInsurance);

  UpdateInsuranceRequest passengers(List<Passenger>? passengers);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateInsuranceRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateInsuranceRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateInsuranceRequest call({
    bool? isRemoveInsurance,
    List<Passenger>? passengers,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateInsuranceRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateInsuranceRequest.copyWith.fieldName(...)`
class _$UpdateInsuranceRequestCWProxyImpl
    implements _$UpdateInsuranceRequestCWProxy {
  final UpdateInsuranceRequest _value;

  const _$UpdateInsuranceRequestCWProxyImpl(this._value);

  @override
  UpdateInsuranceRequest isRemoveInsurance(bool? isRemoveInsurance) =>
      this(isRemoveInsurance: isRemoveInsurance);

  @override
  UpdateInsuranceRequest passengers(List<Passenger>? passengers) =>
      this(passengers: passengers);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateInsuranceRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateInsuranceRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateInsuranceRequest call({
    Object? isRemoveInsurance = const $CopyWithPlaceholder(),
    Object? passengers = const $CopyWithPlaceholder(),
  }) {
    return UpdateInsuranceRequest(
      isRemoveInsurance: isRemoveInsurance == const $CopyWithPlaceholder()
          ? _value.isRemoveInsurance
          // ignore: cast_nullable_to_non_nullable
          : isRemoveInsurance as bool?,
      passengers: passengers == const $CopyWithPlaceholder()
          ? _value.passengers
          // ignore: cast_nullable_to_non_nullable
          : passengers as List<Passenger>?,
    );
  }
}

extension $UpdateInsuranceRequestCopyWith on UpdateInsuranceRequest {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateInsuranceRequest.copyWith(...)` or like so:`instanceOfUpdateInsuranceRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateInsuranceRequestCWProxy get copyWith =>
      _$UpdateInsuranceRequestCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `UpdateInsuranceRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateInsuranceRequest(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  UpdateInsuranceRequest copyWithNull({
    bool isRemoveInsurance = false,
    bool passengers = false,
  }) {
    return UpdateInsuranceRequest(
      isRemoveInsurance:
          isRemoveInsurance == true ? null : this.isRemoveInsurance,
      passengers: passengers == true ? null : this.passengers,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsuranceRequest _$InsuranceRequestFromJson(Map<String, dynamic> json) =>
    InsuranceRequest(
      token: json['Token'] as String?,
      updateInsuranceRequest: json['UpdateInsuranceRequest'] == null
          ? null
          : UpdateInsuranceRequest.fromJson(
              json['UpdateInsuranceRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InsuranceRequestToJson(InsuranceRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Token', instance.token);
  writeNotNull('UpdateInsuranceRequest', instance.updateInsuranceRequest);
  return val;
}

UpdateInsuranceRequest _$UpdateInsuranceRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateInsuranceRequest(
      isRemoveInsurance: json['IsRemoveInsurance'] as bool? ?? false,
      passengers: (json['Passengers'] as List<dynamic>?)
          ?.map((e) => Passenger.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpdateInsuranceRequestToJson(
    UpdateInsuranceRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('IsRemoveInsurance', instance.isRemoveInsurance);
  writeNotNull('Passengers', instance.passengers);
  return val;
}
