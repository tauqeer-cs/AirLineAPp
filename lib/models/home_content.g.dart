// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeContent _$HomeContentFromJson(Map<String, dynamic> json) => HomeContent(
      buttonText: json['buttonText'] as String?,
      cardSectionTitleBold: json['cardSectionTitleBold'] as String?,
      cardSectionTitleNoBold: json['cardSectionTitleNoBold'] as String?,
      description: json['description'] as String?,
      link: json['link'] as String?,
      subtitle: json['subtitle'] as String?,
      title: json['title'] as String?,
      titleBold: json['titleBold'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => HomeItems.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeContentToJson(HomeContent instance) =>
    <String, dynamic>{
      'buttonText': instance.buttonText,
      'cardSectionTitleBold': instance.cardSectionTitleBold,
      'cardSectionTitleNoBold': instance.cardSectionTitleNoBold,
      'description': instance.description,
      'link': instance.link,
      'subtitle': instance.subtitle,
      'title': instance.title,
      'titleBold': instance.titleBold,
      'id': instance.id,
      'name': instance.name,
      'items': instance.items,
    };

HomeItems _$HomeItemsFromJson(Map<String, dynamic> json) => HomeItems(
      description: json['description'] as String?,
      image: json['image'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      img: json['img'] as String?,
      style: json['style'] as String?,
      title: json['title'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$HomeItemsToJson(HomeItems instance) => <String, dynamic>{
      'description': instance.description,
      'image': instance.image,
      'img': instance.img,
      'style': instance.style,
      'title': instance.title,
      'id': instance.id,
      'price': instance.price,
      'name': instance.name,
    };
