// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cms_flight.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CMSFlight _$CMSFlightFromJson(Map<String, dynamic> json) => CMSFlight(
      id: json['id'] as int?,
      name: json['name'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => SSRItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CMSFlightToJson(CMSFlight instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'items': instance.items,
    };

SSRItem _$SSRItemFromJson(Map<String, dynamic> json) => SSRItem(
      id: json['id'] as int?,
      name: json['name'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => SSRItemType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SSRItemToJson(SSRItem instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'items': instance.items,
    };

SSRItemType _$SSRItemTypeFromJson(Map<String, dynamic> json) => SSRItemType(
      code: json['code'] as String?,
      image: json['image'] as String?,
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SSRItemTypeToJson(SSRItemType instance) =>
    <String, dynamic>{
      'code': instance.code,
      'image': instance.image,
      'id': instance.id,
      'name': instance.name,
    };
