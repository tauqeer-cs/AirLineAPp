class GetBoardingPassPassengerRequest {
  String? pNR;
  String? lastName;
  bool? getOutboundPassenger;
  bool? getInboundPassenger;

  GetBoardingPassPassengerRequest(
      {this.pNR,
        this.lastName,
        this.getOutboundPassenger,
        this.getInboundPassenger});

  GetBoardingPassPassengerRequest.fromJson(Map<String, dynamic> json) {
    pNR = json['PNR'];
    lastName = json['LastName'];
    getOutboundPassenger = json['GetOutboundPassenger'];
    getInboundPassenger = json['GetInboundPassenger'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PNR'] = pNR;
    data['LastName'] = lastName;
    data['GetOutboundPassenger'] = getOutboundPassenger;
    data['GetInboundPassenger'] = getInboundPassenger;
    return data;
  }
}