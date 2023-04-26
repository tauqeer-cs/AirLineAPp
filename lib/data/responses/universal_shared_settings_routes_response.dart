class UniversalSharedSettingsRoutesResponse {
  int? id;
  String? name;
  List<Items>? items;
  String? responseTime;

  UniversalSharedSettingsRoutesResponse(
      {this.id, this.name, this.items, this.responseTime});

  UniversalSharedSettingsRoutesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    responseTime = json['ResponseTime'];
  }


}


class Items {
  String? code;
  String? description;
  String? image;
  int? id;
  String? name;
  String? ssrName;
  List<Items>? items;

  Items(
      {this.code,
        this.description,
        this.image,
        this.id,
        this.name,
        this.ssrName});

  Items.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
    image = json['image'];
    id = json['id'];
    name = json['name'];
    ssrName = json['ssrName'];
    items = <Items>[];

    if (json['items'] != null) {
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }


  }


}