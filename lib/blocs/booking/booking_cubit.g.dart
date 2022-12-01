// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_cubit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BookingStateCWProxy {
  BookingState blocState(BlocState blocState);

  BookingState departureColorMapping(Map<num?, Color>? departureColorMapping);

  BookingState isVerify(bool isVerify);

  BookingState message(String message);

  BookingState returnColorMapping(Map<num?, Color>? returnColorMapping);

  BookingState selectedDeparture(InboundOutboundSegment? selectedDeparture);

  BookingState selectedReturn(InboundOutboundSegment? selectedReturn);

  BookingState summaryRequest(SummaryRequest? summaryRequest);

  BookingState superPnrNo(String? superPnrNo);

  BookingState verifyResponse(VerifyResponse? verifyResponse);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BookingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BookingState(...).copyWith(id: 12, name: "My name")
  /// ````
  BookingState call({
    BlocState? blocState,
    Map<num?, Color>? departureColorMapping,
    bool? isVerify,
    String? message,
    Map<num?, Color>? returnColorMapping,
    InboundOutboundSegment? selectedDeparture,
    InboundOutboundSegment? selectedReturn,
    SummaryRequest? summaryRequest,
    String? superPnrNo,
    VerifyResponse? verifyResponse,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBookingState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBookingState.copyWith.fieldName(...)`
class _$BookingStateCWProxyImpl implements _$BookingStateCWProxy {
  final BookingState _value;

  const _$BookingStateCWProxyImpl(this._value);

  @override
  BookingState blocState(BlocState blocState) => this(blocState: blocState);

  @override
  BookingState departureColorMapping(Map<num?, Color>? departureColorMapping) =>
      this(departureColorMapping: departureColorMapping);

  @override
  BookingState isVerify(bool isVerify) => this(isVerify: isVerify);

  @override
  BookingState message(String message) => this(message: message);

  @override
  BookingState returnColorMapping(Map<num?, Color>? returnColorMapping) =>
      this(returnColorMapping: returnColorMapping);

  @override
  BookingState selectedDeparture(InboundOutboundSegment? selectedDeparture) =>
      this(selectedDeparture: selectedDeparture);

  @override
  BookingState selectedReturn(InboundOutboundSegment? selectedReturn) =>
      this(selectedReturn: selectedReturn);

  @override
  BookingState summaryRequest(SummaryRequest? summaryRequest) =>
      this(summaryRequest: summaryRequest);

  @override
  BookingState superPnrNo(String? superPnrNo) => this(superPnrNo: superPnrNo);

  @override
  BookingState verifyResponse(VerifyResponse? verifyResponse) =>
      this(verifyResponse: verifyResponse);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `BookingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BookingState(...).copyWith(id: 12, name: "My name")
  /// ````
  BookingState call({
    Object? blocState = const $CopyWithPlaceholder(),
    Object? departureColorMapping = const $CopyWithPlaceholder(),
    Object? isVerify = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
    Object? returnColorMapping = const $CopyWithPlaceholder(),
    Object? selectedDeparture = const $CopyWithPlaceholder(),
    Object? selectedReturn = const $CopyWithPlaceholder(),
    Object? summaryRequest = const $CopyWithPlaceholder(),
    Object? superPnrNo = const $CopyWithPlaceholder(),
    Object? verifyResponse = const $CopyWithPlaceholder(),
  }) {
    return BookingState(
      blocState: blocState == const $CopyWithPlaceholder() || blocState == null
          ? _value.blocState
          // ignore: cast_nullable_to_non_nullable
          : blocState as BlocState,
      departureColorMapping:
          departureColorMapping == const $CopyWithPlaceholder()
              ? _value.departureColorMapping
              // ignore: cast_nullable_to_non_nullable
              : departureColorMapping as Map<num?, Color>?,
      isVerify: isVerify == const $CopyWithPlaceholder() || isVerify == null
          ? _value.isVerify
          // ignore: cast_nullable_to_non_nullable
          : isVerify as bool,
      message: message == const $CopyWithPlaceholder() || message == null
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String,
      returnColorMapping: returnColorMapping == const $CopyWithPlaceholder()
          ? _value.returnColorMapping
          // ignore: cast_nullable_to_non_nullable
          : returnColorMapping as Map<num?, Color>?,
      selectedDeparture: selectedDeparture == const $CopyWithPlaceholder()
          ? _value.selectedDeparture
          // ignore: cast_nullable_to_non_nullable
          : selectedDeparture as InboundOutboundSegment?,
      selectedReturn: selectedReturn == const $CopyWithPlaceholder()
          ? _value.selectedReturn
          // ignore: cast_nullable_to_non_nullable
          : selectedReturn as InboundOutboundSegment?,
      summaryRequest: summaryRequest == const $CopyWithPlaceholder()
          ? _value.summaryRequest
          // ignore: cast_nullable_to_non_nullable
          : summaryRequest as SummaryRequest?,
      superPnrNo: superPnrNo == const $CopyWithPlaceholder()
          ? _value.superPnrNo
          // ignore: cast_nullable_to_non_nullable
          : superPnrNo as String?,
      verifyResponse: verifyResponse == const $CopyWithPlaceholder()
          ? _value.verifyResponse
          // ignore: cast_nullable_to_non_nullable
          : verifyResponse as VerifyResponse?,
    );
  }
}

extension $BookingStateCopyWith on BookingState {
  /// Returns a callable class that can be used as follows: `instanceOfBookingState.copyWith(...)` or like so:`instanceOfBookingState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$BookingStateCWProxy get copyWith => _$BookingStateCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `BookingState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// BookingState(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  BookingState copyWithNull({
    bool departureColorMapping = false,
    bool returnColorMapping = false,
    bool selectedDeparture = false,
    bool selectedReturn = false,
    bool summaryRequest = false,
    bool superPnrNo = false,
    bool verifyResponse = false,
  }) {
    return BookingState(
      blocState: blocState,
      departureColorMapping:
          departureColorMapping == true ? null : this.departureColorMapping,
      isVerify: isVerify,
      message: message,
      returnColorMapping:
          returnColorMapping == true ? null : this.returnColorMapping,
      selectedDeparture:
          selectedDeparture == true ? null : this.selectedDeparture,
      selectedReturn: selectedReturn == true ? null : this.selectedReturn,
      summaryRequest: summaryRequest == true ? null : this.summaryRequest,
      superPnrNo: superPnrNo == true ? null : this.superPnrNo,
      verifyResponse: verifyResponse == true ? null : this.verifyResponse,
    );
  }
}
