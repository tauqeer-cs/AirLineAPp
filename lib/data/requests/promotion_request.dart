class PromotionsData {
  Result? result;
  bool? success;
  String? message;

  PromotionsData({this.result, this.success, this.message});

  PromotionsData.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}

class Result {
  Value? value;
  List<Null>? formatters;
  List<Null>? contentTypes;
  int? statusCode;

  Result({this.value, this.formatters, this.contentTypes, this.statusCode});

  Result.fromJson(Map<String, dynamic> json) {
    value = json['value'] != null ? Value.fromJson(json['value']) : null;

    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (value != null) {
      data['value'] = value!.toJson();
    }

    data['statusCode'] = statusCode;
    return data;
  }
}

class Value {
  bool? success;
  LmsRedemptionOption? lmsRedemptionOption;

  Value({this.success, this.lmsRedemptionOption});

  Value.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    lmsRedemptionOption = json['lmsRedemptionOption'] != null
        ? LmsRedemptionOption.fromJson(json['lmsRedemptionOption'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (lmsRedemptionOption != null) {
      data['lmsRedemptionOption'] = lmsRedemptionOption!.toJson();
    }
    return data;
  }
}

class LmsRedemptionOption {
  String? pid;
  List<AvailableOptions>? availableOptions;

  LmsRedemptionOption({this.pid, this.availableOptions});

  LmsRedemptionOption.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    if (json['availableOptions'] != null) {
      availableOptions = <AvailableOptions>[];
      json['availableOptions'].forEach((v) {
        availableOptions!.add(AvailableOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pid'] = pid;
    if (availableOptions != null) {
      data['availableOptions'] =
          availableOptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvailableOptions {
  String? redemptionName;
  int? redemptionPoint;
  int? redemptionAmount;
  String? redemptionCode;

  AvailableOptions(
      {this.redemptionName,
        this.redemptionPoint,
        this.redemptionAmount,
        this.redemptionCode});

  AvailableOptions.fromJson(Map<String, dynamic> json) {
    redemptionName = json['redemptionName'];
    redemptionPoint = json['redemptionPoint'];
    redemptionAmount = json['redemptionAmount'];
    redemptionCode = json['redemptionCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['redemptionName'] = redemptionName;
    data['redemptionPoint'] = redemptionPoint;
    data['redemptionAmount'] = redemptionAmount;
    data['redemptionCode'] = redemptionCode;
    return data;
  }
}