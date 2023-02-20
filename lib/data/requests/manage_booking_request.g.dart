// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_booking_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageBookingRequest _$ManageBookingRequestFromJson(
        Map<String, dynamic> json) =>
    ManageBookingRequest(
      pnr: json['pnr'] as String?,
      lastname: json['lastname'] as String?,
    );

Map<String, dynamic> _$ManageBookingRequestToJson(
    ManageBookingRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('pnr', instance.pnr);
  writeNotNull('lastname', instance.lastname);
  return val;
}
