import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manage_booking_request.g.dart';

@JsonSerializable()
class ManageBookingRequest extends Equatable {
  const ManageBookingRequest({
    this.pnr,
    this.lastname
  });

  factory ManageBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$ManageBookingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ManageBookingRequestToJson(this);

  @JsonKey(name: "pnr")
  final String? pnr;

  @JsonKey(name: "lastname")
  final String? lastname;

  ManageBookingRequest copyWith({
    String? pnr,
    String? lastname,
  }) =>
      ManageBookingRequest(
        pnr: pnr ?? this.pnr,
        lastname : lastname ?? this.lastname,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
    pnr,
    lastname,
  ];
}
