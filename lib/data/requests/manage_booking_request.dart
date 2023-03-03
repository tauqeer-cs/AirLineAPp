import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manage_booking_request.g.dart';

@JsonSerializable()
class ManageBookingRequest extends Equatable {
  const ManageBookingRequest({
    this.pnr,
    this.lastname,
    this.email,
  });

  factory ManageBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$ManageBookingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ManageBookingRequestToJson(this);

  @JsonKey(name: "pnr")
  final String? pnr;

  @JsonKey(name: "lastname")
  final String? lastname;

  final String? email;

  ManageBookingRequest copyWith({
    String? pnr,
    String? lastname,
    String? email,
  }) =>
      ManageBookingRequest(
          pnr: pnr ?? this.pnr,
          lastname: lastname ?? this.lastname,
          email: email ?? this.email);

  @override
  // TODO: implement props
  List<Object?> get props => [pnr, lastname, email];
}
