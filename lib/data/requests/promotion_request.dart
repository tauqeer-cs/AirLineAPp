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
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;

    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }

    data['statusCode'] = this.statusCode;
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
        ? new LmsRedemptionOption.fromJson(json['lmsRedemptionOption'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.lmsRedemptionOption != null) {
      data['lmsRedemptionOption'] = this.lmsRedemptionOption!.toJson();
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
        availableOptions!.add(new AvailableOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    if (this.availableOptions != null) {
      data['availableOptions'] =
          this.availableOptions!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['redemptionName'] = this.redemptionName;
    data['redemptionPoint'] = this.redemptionPoint;
    data['redemptionAmount'] = this.redemptionAmount;
    data['redemptionCode'] = this.redemptionCode;
    return data;
  }
}