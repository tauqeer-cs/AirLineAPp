import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_request.g.dart';

@JsonSerializable()
class BookRequest extends Equatable {
  const BookRequest({
    this.token,
    this.flightSummaryPNRRequest,
    this.paymentDetail,
    this.superPNRNo,
  });

  factory BookRequest.fromJson(Map<String, dynamic> json) =>
      _$BookRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BookRequestToJson(this);

  final String? token;
  final FlightSummaryPnrRequest? flightSummaryPNRRequest;
  @JsonKey(name: 'PaymentDetail')
  final PaymentDetail? paymentDetail;
  @JsonKey(name: 'SuperPNRNo')
  final String? superPNRNo;

  BookRequest copyWith({
    String? token,
    FlightSummaryPnrRequest? flightSummaryPNRRequest,
    PaymentDetail? paymentDetail,
    String? superPNRNo,
  }) =>
      BookRequest(
        token: token ?? this.token,
        flightSummaryPNRRequest:
            flightSummaryPNRRequest ?? this.flightSummaryPNRRequest,
        paymentDetail: paymentDetail ?? this.paymentDetail,
        superPNRNo: superPNRNo ?? this.superPNRNo,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        token,
        flightSummaryPNRRequest,
        paymentDetail,
      ];
}

@JsonSerializable(includeIfNull: true)
class PaymentDetail extends Equatable {
  const PaymentDetail({
    this.paymentMethod = "UPAY",
    this.currency = "MYR",
    this.totalAmount,
    this.totalAmountNeedToPay,
    this.myRewardPoints = 0,
    this.promoCode,
    required this.frontendUrl,
    this.myRewardRedemptionName,
  });

  factory PaymentDetail.fromJson(Map<String, dynamic> json) =>
      _$PaymentDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentDetailToJson(this);

  @JsonKey(name: 'PaymentMethod')
  final String? paymentMethod;
  @JsonKey(name: 'Currency')
  final String? currency;
  @JsonKey(name: 'TotalAmount')
  final num? totalAmount;
  @JsonKey(name: 'TotalAmountNeedToPay')
  final num? totalAmountNeedToPay;
  @JsonKey(name: 'MyRewardPoints')
  final num? myRewardPoints;
  @JsonKey(name: 'PromoCode')
  final dynamic promoCode;
  @JsonKey(name: 'FrontendURL')
  final String frontendUrl;


  @JsonKey(name: 'MyRewardRedemptionName')
  final dynamic myRewardRedemptionName;


  PaymentDetail copyWith({
    String? paymentMethod,
    String? currency,
    num? totalAmount,
    num? totalAmountNeedToPay,
    num? myRewardPoints,
    String? promoCode,
    String? myRewardRedemptionName,

    String? frontendUrl,
  }) =>
      PaymentDetail(
        paymentMethod: paymentMethod ?? this.paymentMethod,
        currency: currency ?? this.currency,
        totalAmount: totalAmount ?? this.totalAmount,
        totalAmountNeedToPay: totalAmountNeedToPay ?? this.totalAmountNeedToPay,
        myRewardPoints: myRewardPoints ?? this.myRewardPoints,
        promoCode: promoCode ?? this.promoCode,
        myRewardRedemptionName: myRewardRedemptionName ?? this.myRewardRedemptionName,
        frontendUrl: frontendUrl ?? this.frontendUrl,
      );

  @override
  List<Object?> get props => [
        paymentMethod,
        currency,
        totalAmount,
        totalAmountNeedToPay,
        myRewardPoints,
        promoCode,
        frontendUrl,
    myRewardRedemptionName,
      ];
}
