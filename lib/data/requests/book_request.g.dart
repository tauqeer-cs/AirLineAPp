// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookRequest _$BookRequestFromJson(Map<String, dynamic> json) => BookRequest(
      token: json['token'] as String?,
      flightSummaryPNRRequest: json['flightSummaryPNRRequest'] == null
          ? null
          : FlightSummaryPnrRequest.fromJson(
              json['flightSummaryPNRRequest'] as Map<String, dynamic>),
      paymentDetail: json['PaymentDetail'] == null
          ? null
          : PaymentDetail.fromJson(
              json['PaymentDetail'] as Map<String, dynamic>),
      superPNRNo: json['SuperPNRNo'] as String?,
    );

Map<String, dynamic> _$BookRequestToJson(BookRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('token', instance.token);
  writeNotNull('flightSummaryPNRRequest', instance.flightSummaryPNRRequest);
  writeNotNull('PaymentDetail', instance.paymentDetail);
  writeNotNull('SuperPNRNo', instance.superPNRNo);
  return val;
}

PaymentDetail _$PaymentDetailFromJson(Map<String, dynamic> json) =>
    PaymentDetail(
      paymentMethod: json['PaymentMethod'] as String? ?? "UPAY",
      currency: json['Currency'] as String? ?? "MYR",
      totalAmount: json['TotalAmount'] as num?,
      totalAmountNeedToPay: json['TotalAmountNeedToPay'] as num?,
      myRewardPoints: json['MyRewardPoints'] as num? ?? 0,
      promoCode: json['PromoCode'],
      frontendUrl: json['FrontendURL'] as String? ??
          "https://mya-booking.alphareds.com/booked",
    );

Map<String, dynamic> _$PaymentDetailToJson(PaymentDetail instance) =>
    <String, dynamic>{
      'PaymentMethod': instance.paymentMethod,
      'Currency': instance.currency,
      'TotalAmount': instance.totalAmount,
      'TotalAmountNeedToPay': instance.totalAmountNeedToPay,
      'MyRewardPoints': instance.myRewardPoints,
      'PromoCode': instance.promoCode,
      'FrontendURL': instance.frontendUrl,
    };
