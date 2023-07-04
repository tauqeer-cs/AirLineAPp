class GetFlightAddonRequest {
  String? pNR;
  String? lastName;
  bool? isInternational;

  GetFlightAddonRequest({this.pNR, this.lastName, this.isInternational});

  GetFlightAddonRequest.fromJson(Map<String, dynamic> json) {
    pNR = json['PNR'];
    lastName = json['LastName'];
    isInternational = json['IsInternational'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PNR'] = this.pNR;
    data['LastName'] = this.lastName;
    data['IsInternational'] = this.isInternational;
    return data;
  }
}