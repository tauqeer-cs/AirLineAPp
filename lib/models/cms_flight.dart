import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cms_flight.g.dart';

@JsonSerializable()
class CMSFlight extends Equatable{
  final int? id;
  final String? name;
  final List<SSRItem>? items;
  const CMSFlight({this.id, this.name, this.items});

  @override
  List<Object?> get props => [id, name, items];

  factory CMSFlight.fromJson(Map<String, dynamic> json) =>
      _$CMSFlightFromJson(json);

  Map<String, dynamic> toJson() => _$CMSFlightToJson(this);
}

@JsonSerializable()
class SSRItem  extends Equatable{
  final int? id;
  final String? name;
  final List<SSRItemType>? items;
  const SSRItem({this.id, this.name, this.items});

  @override
  List<Object?> get props => [id, name, items];

  factory SSRItem.fromJson(Map<String, dynamic> json) =>
      _$SSRItemFromJson(json);

  Map<String, dynamic> toJson() => _$SSRItemToJson(this);
}

@JsonSerializable()
class SSRItemType extends Equatable{
  final String? code;
  final String? image;
  final int? id;
  final String? name;

  const SSRItemType({this.code, this.image, this.id, this.name});

  @override
  List<Object?> get props => [code, image, id, name];

  factory SSRItemType.fromJson(Map<String, dynamic> json) =>
      _$SSRItemTypeFromJson(json);

  Map<String, dynamic> toJson() => _$SSRItemTypeToJson(this);
}
