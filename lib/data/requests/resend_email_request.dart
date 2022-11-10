import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resend_email_request.g.dart';

@JsonSerializable()
class ResendEmailRequest extends Equatable {
  const ResendEmailRequest({
    this.email,
  });

  factory ResendEmailRequest.fromJson(Map<String, dynamic> json) =>
      _$ResendEmailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResendEmailRequestToJson(this);

  @JsonKey(name: "Email")
  final String? email;

  ResendEmailRequest copyWith({
    String? email,
  }) =>
      ResendEmailRequest(
        email: email ?? this.email,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
    email,
  ];
}
