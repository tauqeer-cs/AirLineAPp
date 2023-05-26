// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cms_flight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CMSFlight _$CMSFlightFromJson(Map<String, dynamic> json) => CMSFlight(
      id: json['id'] as int?,
      name: json['name'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => SharedSetting.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CMSFlightToJson(CMSFlight instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('items', instance.items);
  return val;
}

SharedSetting _$SharedSettingFromJson(Map<String, dynamic> json) =>
    SharedSetting(
      id: json['id'] as int?,
      name: json['name'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => SSRItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      content: json['content'] as String?,
    );

Map<String, dynamic> _$SharedSettingToJson(SharedSetting instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('items', instance.items);
  writeNotNull('content', instance.content);
  return val;
}

SSRItem _$SSRItemFromJson(Map<String, dynamic> json) => SSRItem(
      id: json['id'] as int?,
      name: json['name'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => SSRItemType.fromJson(e as Map<String, dynamic>))
          .toList(),
      content: json['content'] as String?,
      banner: json['banner'] as String?,
      bannerUrl: json['bannerUrl'] as String?,
    );

Map<String, dynamic> _$SSRItemToJson(SSRItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('items', instance.items);
  writeNotNull('content', instance.content);
  writeNotNull('banner', instance.banner);
  writeNotNull('bannerUrl', instance.bannerUrl);
  return val;
}

SSRItemType _$SSRItemTypeFromJson(Map<String, dynamic> json) => SSRItemType(
      code: json['code'] as String?,
      image: json['image'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      content: json['content'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$SSRItemTypeToJson(SSRItemType instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  writeNotNull('image', instance.image);
  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('description', instance.description);
  writeNotNull('content', instance.content);
  return val;
}
