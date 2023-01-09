class Token {
  String? token;

  String? redemptionName;

  //  "": "Redeem25"

  Token({this.token,this.redemptionName});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['Token'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Token'] = token;
    if(redemptionName != null) {
      data['RedemptionName'] = redemptionName;
    }
    return data;
  }
}