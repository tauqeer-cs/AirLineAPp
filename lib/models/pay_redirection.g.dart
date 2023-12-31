// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_redirection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayRedirectionValue _$PayRedirectionValueFromJson(Map<String, dynamic> json) =>
    PayRedirectionValue(
      value: json['value'] == null
          ? null
          : PayRedirection.fromJson(json['value'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PayRedirectionValueToJson(PayRedirectionValue instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('value', instance.value?.toJson());
  return val;
}

PayRedirection _$PayRedirectionFromJson(Map<String, dynamic> json) =>
    PayRedirection(
      paymentRedirectData: json['paymentRedirectData'] == null
          ? null
          : PaymentRedirectData.fromJson(
              json['paymentRedirectData'] as Map<String, dynamic>),
      superPnrNo: json['superPNRNo'] as String?,
      orderId: json['orderID'] as int?,
      verifyExpiredDateTime: json['verifyExpiredDateTime'] == null
          ? null
          : DateTime.parse(json['verifyExpiredDateTime'] as String),
      success: json['success'] as bool?,
      isInvalidMemberID: json['isInvalidMemberID'] as bool?,
      fromCache: json['fromCache'] as bool?,
    );

Map<String, dynamic> _$PayRedirectionToJson(PayRedirection instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('paymentRedirectData', instance.paymentRedirectData?.toJson());
  writeNotNull('superPNRNo', instance.superPnrNo);
  writeNotNull('orderID', instance.orderId);
  writeNotNull('verifyExpiredDateTime',
      instance.verifyExpiredDateTime?.toIso8601String());
  writeNotNull('success', instance.success);
  writeNotNull('isInvalidMemberID', instance.isInvalidMemberID);
  writeNotNull('fromCache', instance.fromCache);
  return val;
}

PaymentRedirectData _$PaymentRedirectDataFromJson(Map<String, dynamic> json) =>
    PaymentRedirectData(
      paymentUrl: json['paymentURL'] as String?,
      isPendingPayment: json['isPendingPayment'] as bool?,
      pendingPaymentMessage: json['pendingPaymentMessage'] as String?,
      paymentRedirectValueList:
          (json['paymentRedirectValueList'] as List<dynamic>?)
              ?.map((e) =>
                  PaymentRedirectValueList.fromJson(e as Map<String, dynamic>))
              .toList(),
      isAlreadySuccessPayment: json['isAlreadySuccessPayment'] as bool?,
    );

Map<String, dynamic> _$PaymentRedirectDataToJson(PaymentRedirectData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('paymentURL', instance.paymentUrl);
  writeNotNull('isAlreadySuccessPayment', instance.isAlreadySuccessPayment);
  writeNotNull('paymentRedirectValueList',
      instance.paymentRedirectValueList?.map((e) => e.toJson()).toList());
  return val;
}

PaymentRedirectValueList _$PaymentRedirectValueListFromJson(
        Map<String, dynamic> json) =>
    PaymentRedirectValueList(
      key: json['key'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$PaymentRedirectValueListToJson(
    PaymentRedirectValueList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('key', instance.key);
  writeNotNull('value', instance.value);
  return val;
}
