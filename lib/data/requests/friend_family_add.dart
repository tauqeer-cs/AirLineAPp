class FriendsFamilyAdd {
  String? dOB;
  String? firstName;
  String? lastName;
  int? memberID;
  String? nationality;
  String? title;

  FriendsFamilyAdd(
      {this.dOB,
        this.firstName,
        this.lastName,
        this.memberID,
        this.nationality,
        this.title});

  FriendsFamilyAdd.fromJson(Map<String, dynamic> json) {
    dOB = json['DOB'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    memberID = json['MemberID'];
    nationality = json['Nationality'];
    title = json['Title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DOB'] = dOB;
    data['FirstName'] = firstName;
    data['LastName'] = lastName;
    data['MemberID'] = memberID;
    data['Nationality'] = nationality;
    data['Title'] = title;
    return data;
  }
}






