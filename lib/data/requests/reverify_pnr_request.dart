import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reverify_pnr_request.g.dart';

@CopyWith(copyWithNull: true)
@JsonSerializable(includeIfNull: false)
class ReverifyPnrRequest extends Equatable {
  const ReverifyPnrRequest({
    this.superPNRNo,
  });

  @JsonKey(name: 'SuperPNRNo')
  final String? superPNRNo;

  factory ReverifyPnrRequest.fromJson(Map<String, dynamic> json) =>
      _$ReverifyPnrRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ReverifyPnrRequestToJson(this);

  @override
  List<Object?> get props => [superPNRNo];
}
