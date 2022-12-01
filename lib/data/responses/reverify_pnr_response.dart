import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reverify_pnr_response.g.dart';

@CopyWith(copyWithNull: true)
@JsonSerializable(includeIfNull: false)
class ReverifyPnrResponse extends Equatable {
  ReverifyPnrResponse({
    this.result,
    this.success,
    this.message,
  });

  factory ReverifyPnrResponse.fromJson(Map<String, dynamic> json) =>
      _$ReverifyPnrResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReverifyPnrResponseToJson(this);

  final Result? result;
  final bool? success;
  final String? message;

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.result,
        this.success,
        this.message,
      ];
}

@CopyWith(copyWithNull: true)
@JsonSerializable(includeIfNull: false)
class Result extends Equatable {
  Result({
    this.value,
    this.formatters,
    this.contentTypes,
    this.statusCode,
  });

  factory Result.fromJson(Map<String, dynamic> json) =>
      _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  final Value? value;
  final List<dynamic>? formatters;
  final List<dynamic>? contentTypes;
  final int? statusCode;

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.value,
        this.formatters,
        this.contentTypes,
        this.statusCode,
      ];
}

@CopyWith(copyWithNull: true)
@JsonSerializable(includeIfNull: false)
class Value extends Equatable {
  Value({
    this.superPnrNo,
    this.orderId,
    this.verifyExpiredDateTime,
    this.success,
    this.isInvalidMemberId,
    this.fromCache,
  });

  factory Value.fromJson(Map<String, dynamic> json) =>
      _$ValueFromJson(json);

  Map<String, dynamic> toJson() => _$ValueToJson(this);

  final String? superPnrNo;
  final int? orderId;
  final DateTime? verifyExpiredDateTime;
  final bool? success;
  final bool? isInvalidMemberId;
  final bool? fromCache;

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.superPnrNo,
        this.orderId,
        this.verifyExpiredDateTime,
        this.success,
        this.isInvalidMemberId,
        this.fromCache,
      ];
}
