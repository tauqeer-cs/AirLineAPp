import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cms_flight.g.dart';

@JsonSerializable()
class CMSFlight extends Equatable {
  final int? id;
  final String? name;
  final List<SharedSetting>? items;

  const CMSFlight({this.id, this.name, this.items});

  @override
  List<Object?> get props => [id, name, items];

  factory CMSFlight.fromJson(Map<String, dynamic> json) =>
      _$CMSFlightFromJson(json);

  Map<String, dynamic> toJson() => _$CMSFlightToJson(this);
}

@JsonSerializable()
class SharedSetting extends Equatable {
  final int? id;
  final String? name;
  final List<SSRItem>? items;
  final String? content;

  const SharedSetting({this.id, this.name, this.items, this.content});

  @override
  List<Object?> get props => [id, name, items, content];

  factory SharedSetting.fromJson(Map<String, dynamic> json) =>
      _$SharedSettingFromJson(json);

  Map<String, dynamic> toJson() => _$SharedSettingToJson(this);
}

@JsonSerializable()
class SSRItem extends Equatable {
  final int? id;
  final String? name;
  final List<SSRItemType>? items;
  final String? content;

  const SSRItem({this.id, this.name, this.items, this.content});

  @override
  List<Object?> get props => [id, name, items, content];

  factory SSRItem.fromJson(Map<String, dynamic> json) =>
      _$SSRItemFromJson(json);

  Map<String, dynamic> toJson() => _$SSRItemToJson(this);
}

@JsonSerializable()
class SSRItemType extends Equatable {
  final String? code;
  final String? image;
  final int? id;
  final String? name;
  final String? description;

  final String? content;

  const SSRItemType({
    this.code,
    this.image,
    this.id,
    this.name,
    this.content,
    this.description,
  });

  @override
  List<Object?> get props => [code, image, id, name, content,description];

  factory SSRItemType.fromJson(Map<String, dynamic> json) =>
      _$SSRItemTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SSRItemTypeToJson(this);
}
