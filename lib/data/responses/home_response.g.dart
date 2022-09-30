// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
      urlSegment: json['urlSegment'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => HomeContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'urlSegment': instance.urlSegment,
      'items': instance.items,
    };
