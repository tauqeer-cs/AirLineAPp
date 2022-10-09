// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cms_route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CMSRoute _$CMSRouteFromJson(Map<String, dynamic> json) => CMSRoute(
      contentType: json['contentType'] == null
          ? null
          : RouteContentType.fromJson(
              json['contentType'] as Map<String, dynamic>),
      key: json['key'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      urlSegment: json['urlSegment'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => RouteItems.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CMSRouteToJson(CMSRoute instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('contentType', instance.contentType);
  writeNotNull('key', instance.key);
  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('urlSegment', instance.urlSegment);
  writeNotNull('items', instance.items);
  return val;
}

RouteContentType _$RouteContentTypeFromJson(Map<String, dynamic> json) =>
    RouteContentType(
      key: json['key'] as String?,
      id: json['id'] as int?,
      alias: json['alias'] as String?,
    );

Map<String, dynamic> _$RouteContentTypeToJson(RouteContentType instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('key', instance.key);
  writeNotNull('id', instance.id);
  writeNotNull('alias', instance.alias);
  return val;
}

RouteItems _$RouteItemsFromJson(Map<String, dynamic> json) => RouteItems(
      contentType: json['contentType'] == null
          ? null
          : RouteContentType.fromJson(
              json['contentType'] as Map<String, dynamic>),
      key: json['key'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
      urlSegment: json['urlSegment'] as String?,
      items: json['items'] as List<dynamic>?,
    );

Map<String, dynamic> _$RouteItemsToJson(RouteItems instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('contentType', instance.contentType);
  writeNotNull('key', instance.key);
  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('urlSegment', instance.urlSegment);
  writeNotNull('items', instance.items);
  return val;
}
