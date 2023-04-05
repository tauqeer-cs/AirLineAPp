class GetBoardingPassResponse {
  Result? result;
  bool? success;
  String? message;

  GetBoardingPassResponse({this.result, this.success, this.message});

  GetBoardingPassResponse.fromJson(Map<String, dynamic> json) {
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
  List<OutboundBoardingPassPassenger>? outboundBoardingPassPassenger;
  List<OutboundBoardingPassPassenger>? inboundBoardingPassPassenger;
  bool? success;

  Result(
      {this.outboundBoardingPassPassenger,
        this.inboundBoardingPassPassenger,
        this.success});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['outboundBoardingPassPassenger'] != null) {
      outboundBoardingPassPassenger = <OutboundBoardingPassPassenger>[];
      json['outboundBoardingPassPassenger'].forEach((v) {
        outboundBoardingPassPassenger!
            .add(OutboundBoardingPassPassenger.fromJson(v));
      });
    }
    if (json['inboundBoardingPassPassenger'] != null) {
      inboundBoardingPassPassenger = <OutboundBoardingPassPassenger>[];
      json['inboundBoardingPassPassenger'].forEach((v) {
        inboundBoardingPassPassenger!.add(OutboundBoardingPassPassenger.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (outboundBoardingPassPassenger != null) {
      data['outboundBoardingPassPassenger'] =
          outboundBoardingPassPassenger!.map((v) => v.toJson()).toList();
    }
    if (inboundBoardingPassPassenger != null) {
      data['inboundBoardingPassPassenger'] =
          inboundBoardingPassPassenger!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }
}

class OutboundBoardingPassPassenger {
  String? fullName;
  String? firstName;
  String? lastName;
  String? pnr;
  int? logicalFlightKey;
  int? personOrgId;

  OutboundBoardingPassPassenger(
      {this.fullName,
        this.firstName,
        this.lastName,
        this.pnr,
        this.logicalFlightKey,
        this.personOrgId});

  OutboundBoardingPassPassenger.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    pnr = json['pnr'];
    logicalFlightKey = json['logicalFlightKey'];
    personOrgId = json['personOrgId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['pnr'] = pnr;
    data['logicalFlightKey'] = logicalFlightKey;
    data['personOrgId'] = personOrgId;
    return data;
  }
}