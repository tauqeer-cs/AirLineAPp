import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pay_redirection.g.dart';

@JsonSerializable(explicitToJson: true)
class PayRedirectionValue extends Equatable {
  const PayRedirectionValue({
    this.value,
  });

  @override
  List<Object?> get props => [
        value,
      ];

  final PayRedirection? value;

  factory PayRedirectionValue.fromJson(Map<String, dynamic> json) =>
      _$PayRedirectionValueFromJson(json);

  Map<String, dynamic> toJson() => _$PayRedirectionValueToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PayRedirection extends Equatable {
  const PayRedirection({
    this.paymentRedirectData,
    this.superPnrNo,
    this.orderId,
    this.verifyExpiredDateTime,
    this.success,
    this.isInvalidMemberID,
    this.fromCache,

  });

  @override
  List<Object?> get props => [
        paymentRedirectData,
        superPnrNo,
        orderId,
        verifyExpiredDateTime,
        success,
        isInvalidMemberID,
        fromCache
      ];

  final PaymentRedirectData? paymentRedirectData;
  @JsonKey(name: "superPNRNo")
  final String? superPnrNo;
  @JsonKey(name: "orderID")
  final int? orderId;
  final DateTime? verifyExpiredDateTime;
  final bool? success;

  final bool? isInvalidMemberID;
  final bool? fromCache;


  PayRedirection copyWith({
    PaymentRedirectData? paymentRedirectData,
    String? superPnrNo,
    int? orderId,
    DateTime? verifyExpiredDateTime,
    bool? success,
    bool? isPendingPayment,
    String? pendingPaymentMessage,
    bool? isInvalidMemberID,
    bool? fromCache,
  }) =>
      PayRedirection(
        paymentRedirectData: paymentRedirectData ?? this.paymentRedirectData,
        superPnrNo: superPnrNo ?? this.superPnrNo,
        orderId: orderId ?? this.orderId,
        verifyExpiredDateTime:
            verifyExpiredDateTime ?? this.verifyExpiredDateTime,
        success: success ?? this.success,
        isInvalidMemberID: isInvalidMemberID ?? this.isInvalidMemberID,
        fromCache: fromCache ?? this.fromCache,
      );

  factory PayRedirection.fromJson(Map<String, dynamic> json) =>
      _$PayRedirectionFromJson(json);

  Map<String, dynamic> toJson() => _$PayRedirectionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PaymentRedirectData extends Equatable {
  const PaymentRedirectData({
    this.paymentUrl,
    this.paymentRedirectValueList,
    this.isAlreadySuccessPayment,
    this.isPendingPayment,
    this.pendingPaymentMessage,
  });

  @override
  List<Object?> get props => [];
  @JsonKey(name: 'paymentURL')
  final String? paymentUrl;

  final bool? isPendingPayment;
  final String? pendingPaymentMessage;

  final bool? isAlreadySuccessPayment;
  final List<PaymentRedirectValueList>? paymentRedirectValueList;

  PaymentRedirectData copyWith({
    String? paymentUrl,
    bool? isAlreadySuccessPayment,
    List<PaymentRedirectValueList>? paymentRedirectValueList,
    bool? isPendingPayment,
    String? pendingPaymentMessage,
  }) =>
      PaymentRedirectData(
        paymentUrl: paymentUrl ?? this.paymentUrl,
        isPendingPayment: isPendingPayment ?? this.isPendingPayment,
        pendingPaymentMessage: pendingPaymentMessage ?? this.pendingPaymentMessage,
        isAlreadySuccessPayment:
            isAlreadySuccessPayment ?? this.isAlreadySuccessPayment,
        paymentRedirectValueList:
            paymentRedirectValueList ?? this.paymentRedirectValueList,

      );

  factory PaymentRedirectData.fromJson(Map<String, dynamic> json) =>
      _$PaymentRedirectDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentRedirectDataToJson(this);

  Map<String, dynamic> redirectMap() {
    if (paymentRedirectValueList == null) return {};
    Map<String, dynamic> map = {};
    for (PaymentRedirectValueList element in paymentRedirectValueList!) {
      map.putIfAbsent(
          element.key ?? "", () => element.value?.replaceAll(",", ""));
    }
    return map;
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentRedirectValueList extends Equatable {
  const PaymentRedirectValueList({
    this.key,
    this.value,
  });

  final String? key;
  final String? value;

  PaymentRedirectValueList copyWith({
    String? key,
    String? value,
  }) =>
      PaymentRedirectValueList(
        key: key ?? this.key,
        value: value ?? this.value,
      );

  factory PaymentRedirectValueList.fromJson(Map<String, dynamic> json) =>
      _$PaymentRedirectValueListFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentRedirectValueListToJson(this);

  @override
  List<Object?> get props => [];
}
