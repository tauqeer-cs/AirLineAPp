class BoardingpassPassengerResponse {
  List<BoardingPassPassenger>? outboundBoardingPassPassenger;
  List<BoardingPassPassenger>? inboundBoardingPassPassenger;
  bool? success;

  BoardingpassPassengerResponse(
      {this.outboundBoardingPassPassenger,
        this.inboundBoardingPassPassenger,
        this.success});

  BoardingpassPassengerResponse.fromJson(Map<String, dynamic> json) {
    if (json['outboundBoardingPassPassenger'] != null) {
      outboundBoardingPassPassenger = <BoardingPassPassenger>[];
      json['outboundBoardingPassPassenger'].forEach((v) {
        outboundBoardingPassPassenger!
            .add( BoardingPassPassenger.fromJson(v));
      });
    }
    if (json['inboundBoardingPassPassenger'] != null) {
      inboundBoardingPassPassenger = <BoardingPassPassenger>[];
      json['inboundBoardingPassPassenger'].forEach((v) {
        inboundBoardingPassPassenger!
            .add( BoardingPassPassenger.fromJson(v));
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

class BoardingPassPassenger {
  String? fullName;
  String? title;
  String? firstName;
  String? lastName;
  String? pnr;
  int? logicalFlightKey;
  int? personOrgId;
  bool? checkedToDownload;

  BoardingPassPassenger(
      {this.fullName,
        this.title,
        this.firstName,
        this.lastName,
        this.pnr,
        this.logicalFlightKey,
        this.personOrgId,
      this.checkedToDownload = false
      });

  BoardingPassPassenger.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    title = json['title'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    pnr = json['pnr'];
    logicalFlightKey = json['logicalFlightKey'];
    personOrgId = json['personOrgId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullName'] = fullName;
    data['title'] = title;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['pnr'] = pnr;
    data['logicalFlightKey'] = logicalFlightKey;
    data['personOrgId'] = personOrgId;
    return data;
  }
}