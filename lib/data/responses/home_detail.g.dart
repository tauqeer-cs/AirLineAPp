// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDetail _$HomeDetailFromJson(Map<String, dynamic> json) => HomeDetail(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HomeDetailToJson(HomeDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  return val;
}

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      current: json['current'] == null
          ? null
          : Current.fromJson(json['current'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('current', instance.current);
  return val;
}

Current _$CurrentFromJson(Map<String, dynamic> json) => Current(
      content: json['content'] as String?,
      showBookNow: json['showBookNow'] as bool?,
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CurrentToJson(Current instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('content', instance.content);
  writeNotNull('showBookNow', instance.showBookNow);
  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  return val;
}
