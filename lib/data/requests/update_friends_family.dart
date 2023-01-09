class UpdateFriendsFamily {
  int? friendsAndFamilyID;
  String? title;
  String? firstName;
  String? lastName;
  String? dob;
  String? nationality;
  int? memberID;

  UpdateFriendsFamily(
      {this.friendsAndFamilyID,
        this.title,
        this.firstName,
        this.lastName,
        this.dob,
        this.nationality,
        this.memberID});

  UpdateFriendsFamily.fromJson(Map<String, dynamic> json) {
    friendsAndFamilyID = json['friendsAndFamilyID'];
    title = json['title'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    dob = json['dob'];
    nationality = json['nationality'];
    memberID = json['memberID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['friendsAndFamilyID'] = friendsAndFamilyID;
    data['title'] = title;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['dob'] = dob;
    data['nationality'] = nationality;
    data['memberID'] = memberID;
    return data;
  }
}