class PromotionsResponse {
  Value? value;

  int? statusCode;

  PromotionsResponse(
      {this.value, this.statusCode});

  PromotionsResponse.fromJson(Map<String, dynamic> json) {
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
  RedemptionOption? lmsRedemptionOption;

  Value({this.success, this.lmsRedemptionOption});

  Value.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    lmsRedemptionOption = json['lmsRedemptionOption'] != null
        ? RedemptionOption.fromJson(json['lmsRedemptionOption'])
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

class RedemptionOption {
  String? pid;
  List<AvailableRedeemOptions>? availableOptions;

  RedemptionOption({this.pid, this.availableOptions});

  RedemptionOption.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    if (json['availableOptions'] != null) {
      availableOptions = <AvailableRedeemOptions>[];
      json['availableOptions'].forEach((v) {
        availableOptions!.add( AvailableRedeemOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    if (availableOptions != null) {
      data['availableOptions'] =
          availableOptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvailableRedeemOptions {
  String? redemptionName;
  int? redemptionPoint;
  int? redemptionAmount;
  String? redemptionCode;

  AvailableRedeemOptions(
      {this.redemptionName,
        this.redemptionPoint,
        this.redemptionAmount,
        this.redemptionCode});

  AvailableRedeemOptions.fromJson(Map<String, dynamic> json) {
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