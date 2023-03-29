class AgentSignUpCms {
  String? agreement;
  String? tnC;
  num? id;
  String? name;
  String? responseTime;

  AgentSignUpCms(
      {this.agreement, this.tnC, this.id, this.name, this.responseTime});

  AgentSignUpCms.fromJson(Map<String, dynamic> json) {
    agreement = json['agreement'];
    tnC = json['tnC'];
    id = json['id'];
    name = json['name'];
    responseTime = json['ResponseTime'];
  }

}