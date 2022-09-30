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

Map<String, dynamic> _$CMSRouteToJson(CMSRoute instance) => <String, dynamic>{
      'contentType': instance.contentType,
      'key': instance.key,
      'id': instance.id,
      'name': instance.name,
      'urlSegment': instance.urlSegment,
      'items': instance.items,
    };

RouteContentType _$RouteContentTypeFromJson(Map<String, dynamic> json) =>
    RouteContentType(
      key: json['key'] as String?,
      id: json['id'] as int?,
      alias: json['alias'] as String?,
    );

Map<String, dynamic> _$RouteContentTypeToJson(RouteContentType instance) =>
    <String, dynamic>{
      'key': instance.key,
      'id': instance.id,
      'alias': instance.alias,
    };

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

Map<String, dynamic> _$RouteItemsToJson(RouteItems instance) =>
    <String, dynamic>{
      'contentType': instance.contentType,
      'key': instance.key,
      'id': instance.id,
      'name': instance.name,
      'urlSegment': instance.urlSegment,
      'items': instance.items,
    };
