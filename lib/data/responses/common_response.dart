import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'common_response.g.dart';

@JsonSerializable()
class CommonResponse extends Equatable{
  final bool? success;
  final String? message;
  final String? response;

  const CommonResponse({this.success, this.message,this.response});

  factory CommonResponse.fromJson(Map<String, dynamic> json) =>
      _$CommonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommonResponseToJson(this);

  @override
  List<Object?> get props => [success, message,response];
}