class Token {
  String? token;

  String? redemptionName;


  Token({this.token,this.redemptionName});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['Token'];
    redemptionName = json['redemptionName'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Token'] = token;
    if(redemptionName != null) {
      data['RedemptionName'] = redemptionName;
    }
    return data;
  }
}

class RedeemPointsResponse {
  Value? value;

  int? statusCode;

  RedeemPointsResponse(
      {this.value,  this.statusCode});

  RedeemPointsResponse.fromJson(Map<String, dynamic> json) {
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


class Result {
  Value? value;

  int? statusCode;

  Result({this.value, this.statusCode});

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

  Value({this.success});

  Value.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    return data;
  }
}