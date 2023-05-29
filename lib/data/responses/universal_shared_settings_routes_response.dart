import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:universal_html/html.dart';

class UniversalSharedSettingsRoutesResponse {
  int? id;
  String? name;
  String? content;
  String? title;




  List<Items>? items;
  String? responseTime;

  UniversalSharedSettingsRoutesResponse(
      {this.id, this.name, this.items, this.responseTime});

  UniversalSharedSettingsRoutesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    title = json['title'];
    content = json['content'];

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

  String? banner;// "https://mya-ibe-prod-bucket.s3.ap-southeast-1.amazonaws.com/uboogsfi/website-zurich-travel-insurance-desktop.jpg",
  String? bannerUrl;
  String? content;
  String? title;

  Items(
      {this.code,
        this.description,
        this.image,
        this.id,
        this.name,
        this.ssrName,
      this.banner,
        this.bannerUrl
      });

  String get contentHtmlString {

    return extractTextFromHtml(content ?? '');
  }

  String get titleContent {
    return '${title ?? ''}\n\n$contentHtmlString';
  }
  String extractTextFromHtml(String html) {

    RegExp exp = RegExp(r"<[^>]*>",multiLine: true,caseSensitive: true);
    String parsedstring1 = html.replaceAll(exp, '');

    String parsedstring2 = html.replaceAll(exp, ' ');
    return parsedstring2;
  }


  Items.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
    image = json['image'];
    id = json['id'];
    name = json['name'];
    ssrName = json['ssrName'];
    banner = json['banner'];
    bannerUrl = json['bannerUrl'];
    items = <Items>[];

    title = json['title'];
    content = json['content'];



    if (json['items'] != null) {
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }


  }


}