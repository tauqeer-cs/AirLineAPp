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
  return val;
}

PaymentDetail _$PaymentDetailFromJson(Map<String, dynamic> json) =>
    PaymentDetail(
      paymentMethod: json['PaymentMethod'] as String? ?? "UPAY",
      currency: json['Currency'] as String? ?? "MYR",
      totalAmount: json['TotalAmount'] as num?,
      totalAmountNeedToPay: json['TotalAmountNeedToPay'] as num?,
      myRewardPoints: json['MyRewardPoints'] as num?,
      promoCode: json['PromoCode'],
      frontendUrl: json['FrontendURL'] as String? ??
          "https://mya-booking.alphareds.com/booked",
    );

Map<String, dynamic> _$PaymentDetailToJson(PaymentDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PaymentMethod', instance.paymentMethod);
  writeNotNull('Currency', instance.currency);
  writeNotNull('TotalAmount', instance.totalAmount);
  writeNotNull('TotalAmountNeedToPay', instance.totalAmountNeedToPay);
  writeNotNull('MyRewardPoints', instance.myRewardPoints);
  writeNotNull('PromoCode', instance.promoCode);
  writeNotNull('FrontendURL', instance.frontendUrl);
  return val;
}
