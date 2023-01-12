class DeleteCardReuquest {
  String? expiryDate;
  String? countryCode;
  String? token;

  DeleteCardReuquest({this.expiryDate, this.countryCode, this.token});

  DeleteCardReuquest.fromJson(Map<String, dynamic> json) {
    expiryDate = json['ExpiryDate'];
    countryCode = json['CountryCode'];
    token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ExpiryDate'] = expiryDate;
    data['CountryCode'] = countryCode ?? '';
    data['Token'] = token;
    return data;
  }
}