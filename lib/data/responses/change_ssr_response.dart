class ChangeSsrResponse {
  AssignFlightAddOnResponse? assignFlightAddOnResponse;


  int? orderID;
  String? token;
  String? newSkiesToken;
  String? verifyExpiredDateTime;
  bool? success;
  bool? isInvalidMemberID;
  bool? fromCache;
  bool? isVisaCampaign;
  bool? isInternational;

  ChangeSsrResponse(
      {this.orderID,
        this.token,
        this.newSkiesToken,
        this.verifyExpiredDateTime,
        this.success,
        this.isInvalidMemberID,
        this.fromCache,
        this.isVisaCampaign,
        this.isInternational});

  ChangeSsrResponse.fromJson(Map<String, dynamic> json) {
    orderID = json['orderID'];
    token = json['token'];
    newSkiesToken = json['newSkiesToken'];
    verifyExpiredDateTime = json['verifyExpiredDateTime'];
    success = json['success'];
    isInvalidMemberID = json['isInvalidMemberID'];
    fromCache = json['fromCache'];
    isVisaCampaign = json['isVisaCampaign'];
    isInternational = json['isInternational'];
    assignFlightAddOnResponse = json['assignFlightAddOnResponse'] != null
        ? new AssignFlightAddOnResponse.fromJson(
        json['assignFlightAddOnResponse'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderID'] = this.orderID;
    data['token'] = this.token;
    data['newSkiesToken'] = this.newSkiesToken;
    data['verifyExpiredDateTime'] = this.verifyExpiredDateTime;
    data['success'] = this.success;
    data['isInvalidMemberID'] = this.isInvalidMemberID;
    data['fromCache'] = this.fromCache;
    data['isVisaCampaign'] = this.isVisaCampaign;
    data['isInternational'] = this.isInternational;

    if (this.assignFlightAddOnResponse != null) {
      data['assignFlightAddOnResponse'] =
          this.assignFlightAddOnResponse!.toJson();
    }

    return data;
  }
}

class AssignFlightAddOnResponse {
  bool? success;
  num? totalReservationAmount;
  String? currency;

  AssignFlightAddOnResponse(
      {this.success, this.totalReservationAmount, this.currency});

  AssignFlightAddOnResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalReservationAmount = json['totalReservationAmount'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['totalReservationAmount'] = this.totalReservationAmount;
    data['currency'] = this.currency;
    return data;
  }
}
