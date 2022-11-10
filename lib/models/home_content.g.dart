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

Map<String, dynamic> _$HomeContentToJson(HomeContent instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('buttonText', instance.buttonText);
  writeNotNull('cardSectionTitleBold', instance.cardSectionTitleBold);
  writeNotNull('cardSectionTitleNoBold', instance.cardSectionTitleNoBold);
  writeNotNull('description', instance.description);
  writeNotNull('link', instance.link);
  writeNotNull('subtitle', instance.subtitle);
  writeNotNull('title', instance.title);
  writeNotNull('titleBold', instance.titleBold);
  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('items', instance.items);
  return val;
}

HomeItems _$HomeItemsFromJson(Map<String, dynamic> json) => HomeItems(
      description: json['description'] as String?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      image: json['image'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      img: json['img'] as String?,
      style: json['style'] as String?,
      title: json['title'] as String?,
      id: json['id'] as int?,
      link: json['link'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$HomeItemsToJson(HomeItems instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('description', instance.description);
  writeNotNull('image', instance.image);
  writeNotNull('from', instance.from);
  writeNotNull('to', instance.to);
  writeNotNull('img', instance.img);
  writeNotNull('style', instance.style);
  writeNotNull('title', instance.title);
  writeNotNull('id', instance.id);
  writeNotNull('price', instance.price);
  writeNotNull('name', instance.name);
  writeNotNull('link', instance.link);
  return val;
}
