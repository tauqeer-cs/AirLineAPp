class CheckInResponse {
  bool? haveOutboundCheckIn;
  bool? haveInboundCheckIn;
  bool? outboundCheckInSuccess;
  bool? inboundCheckInSuccess;
  bool? success;
  String? outboundCheckInErrorMessage;
  String? inboundCheckInErrorMessage;

  String get errorMessages {
    if((outboundCheckInErrorMessage ?? '').isNotEmpty && (inboundCheckInErrorMessage ?? '').isNotEmpty) {

      return '${outboundCheckInErrorMessage ?? ''}\n${inboundCheckInErrorMessage ?? ''}';
    }
    if((outboundCheckInErrorMessage ?? '').isNotEmpty){
      return outboundCheckInErrorMessage ?? '';
    }

    if((inboundCheckInErrorMessage ?? '').isNotEmpty){
      return inboundCheckInErrorMessage ?? '';
    }
    return '';
  }

  CheckInResponse(
      {this.haveOutboundCheckIn,
        this.haveInboundCheckIn,
        this.outboundCheckInSuccess,
        this.inboundCheckInSuccess,
        this.outboundCheckInErrorMessage,
        this.inboundCheckInErrorMessage,
        this.success});

  CheckInResponse.fromJson(Map<String, dynamic> json) {
    haveOutboundCheckIn = json['haveOutboundCheckIn'];
    haveInboundCheckIn = json['haveInboundCheckIn'];
    outboundCheckInSuccess = json['outboundCheckInSuccess'];
    inboundCheckInSuccess = json['inboundCheckInSuccess'];
    outboundCheckInErrorMessage = json['outboundCheckInErrorMessage'];
    inboundCheckInErrorMessage = json['inboundCheckInErrorMessage'];

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
