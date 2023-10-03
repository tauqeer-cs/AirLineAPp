import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manage_booking_request.g.dart';

@JsonSerializable()
class ManageBookingRequest extends Equatable {
  const ManageBookingRequest({
    this.pnr,
    this.lastname,
    this.email,
    this.paxForCheckOut,
  });

  //passengers

  factory ManageBookingRequest.fromJson(Map<String, dynamic> json) =>
      _$ManageBookingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ManageBookingRequestToJson(this);

  @JsonKey(name: "pnr")
  final String? pnr;

  @JsonKey(name: "lastname")
  final String? lastname;

  final String? email;

  final List<PaxForMmbCheckout>? paxForCheckOut;


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
  List<Object?> get props => [pnr, lastname, email,paxForCheckOut];
}

class PaxForMmbCheckout {
  String? passengerKey;
  String? outboundLogicalFlightID;
  String? inboundLogicalFlightID;

  PaxForMmbCheckout(
      {this.passengerKey,
        this.outboundLogicalFlightID,
        this.inboundLogicalFlightID});

  PaxForMmbCheckout.fromJson(Map<String, dynamic> json) {
    passengerKey = json['PassengerKey'];
    outboundLogicalFlightID = json['OutboundLogicalFlightID'];
    inboundLogicalFlightID = json['InboundLogicalFlightID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PassengerKey'] = this.passengerKey;
    data['OutboundLogicalFlightID'] = this.outboundLogicalFlightID;
    data['InboundLogicalFlightID'] = this.inboundLogicalFlightID;
    return data;
  }
}
