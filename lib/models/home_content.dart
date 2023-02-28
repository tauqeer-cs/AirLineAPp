import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_content.g.dart';

@JsonSerializable()
class HomeContent extends Equatable {
  final String? buttonText;
  final String? cardSectionTitleBold;
  final String? cardSectionTitleNoBold;
  final String? description;
  final String? link;
  final String? subtitle;
  final String? title;
  final String? titleBold;
  final int? id;
  final String? name;
  final List<HomeItems>? items;

  const HomeContent(
      {this.buttonText,
      this.cardSectionTitleBold,
      this.cardSectionTitleNoBold,
      this.description,
      this.link,
      this.subtitle,
      this.title,
      this.titleBold,
      this.id,
      this.name,
      this.items});

  factory HomeContent.fromJson(Map<String, dynamic> json) =>
      _$HomeContentFromJson(json);

  Map<String, dynamic> toJson() => _$HomeContentToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        buttonText,
        cardSectionTitleBold,
        cardSectionTitleNoBold,
        description,
        link,
        subtitle,
        title,
        titleBold,
        id,
        name,
        items
      ];
}

@JsonSerializable()
class HomeItems extends Equatable {
  final String? description;
  final String? image;
  final String? from;
  final String? to;
  final String? img;
  final String? style;
  final String? title;
  final int? id;
  final dynamic? price;
  final String? name;
  final String? link;
  final String? key;

  const HomeItems({
    this.description,
    this.from,
    this.to,
    this.image,
    this.price,
    this.img,
    this.style,
    this.title,
    this.id,
    this.link,
    this.key,
    this.name,
  });

  factory HomeItems.fromJson(Map<String, dynamic> json) =>
      _$HomeItemsFromJson(json);

  Map<String, dynamic> toJson() => _$HomeItemsToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        description,
        image,
        price,
        img,
        style,
        title,
        key,
        id,
        name,
        link,
        from,
        to,
      ];
}
