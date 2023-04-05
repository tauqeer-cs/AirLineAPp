class CheckInResponse {
  bool? haveOutboundCheckIn;
  bool? haveInboundCheckIn;
  bool? outboundCheckInSuccess;
  bool? inboundCheckInSuccess;
  bool? success;

  CheckInResponse(
      {this.haveOutboundCheckIn,
        this.haveInboundCheckIn,
        this.outboundCheckInSuccess,
        this.inboundCheckInSuccess,
        this.success});

  CheckInResponse.fromJson(Map<String, dynamic> json) {
    haveOutboundCheckIn = json['haveOutboundCheckIn'];
    haveInboundCheckIn = json['haveInboundCheckIn'];
    outboundCheckInSuccess = json['outboundCheckInSuccess'];
    inboundCheckInSuccess = json['inboundCheckInSuccess'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['haveOutboundCheckIn'] = haveOutboundCheckIn;
    data['haveInboundCheckIn'] = haveInboundCheckIn;
    data['outboundCheckInSuccess'] = outboundCheckInSuccess;
    data['inboundCheckInSuccess'] = inboundCheckInSuccess;
    data['success'] = success;
    return data;
  }
}
