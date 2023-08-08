class BoardingPassRequest {
  String? pNR;
  String? lastName;
  String? email;
  String? getBoardingPassBy;
  List<BoardingPassPax>? boardingPassPax;

  BoardingPassRequest(
      {this.pNR,
        this.lastName,
        this.email,
        this.getBoardingPassBy,
        this.boardingPassPax});

  BoardingPassRequest.fromJson(Map<String, dynamic> json) {
    pNR = json['PNR'];
    lastName = json['LastName'];
    email = json['Email'];
    getBoardingPassBy = json['GetBoardingPassBy'];
    if (json['BoardingPassPax'] != null) {
      boardingPassPax = <BoardingPassPax>[];
      json['BoardingPassPax'].forEach((v) {
        boardingPassPax!.add(BoardingPassPax.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PNR'] = pNR;
    data['LastName'] = lastName;
    data['Email'] = email;
    data['GetBoardingPassBy'] = getBoardingPassBy;
    if (boardingPassPax != null) {
      data['BoardingPassPax'] =
          boardingPassPax!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BoardingPassPax {
  String? lastName;
  String? logicalFlightKey;
  String? personOrgId;
  String? memberID;
  String? passport;
  String? passportExpiryDate;

  //             "": "asdsadad",
  //             "": "ASF99999",
  //             "PassportExpiryDate": "2024-04-18T00:00:00.000Z"


  BoardingPassPax({this.lastName, this.logicalFlightKey, this.personOrgId,this.memberID,this.passport,this.passportExpiryDate});

  BoardingPassPax.fromJson(Map<String, dynamic> json) {
    lastName = json['LastName'];
    logicalFlightKey = json['LogicalFlightKey'];
    personOrgId = json['PersonOrgId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['LastName'] = lastName;
    data['LogicalFlightKey'] = logicalFlightKey;
    data['PersonOrgId'] = personOrgId;

    data['MemberID'] = memberID;
    data['Passport'] = passport;
    data['PassportExpiryDate'] = passportExpiryDate;

    //

    return data;
  }
}