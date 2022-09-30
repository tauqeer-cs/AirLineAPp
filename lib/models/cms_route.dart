import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cms_route.g.dart';

@JsonSerializable()
class CMSRoute extends Equatable {
  final RouteContentType? contentType;
  final String? key;
  final int? id;
  final String? name;
  final String? urlSegment;
  final List<RouteItems>? items;

  CMSRoute({
    this.contentType,
    this.key,
    this.id,
    this.name,
    this.urlSegment,
    this.items,
  });

  factory CMSRoute.fromJson(Map<String, dynamic> json) =>
      _$CMSRouteFromJson(json);

  Map<String, dynamic> toJson() => _$CMSRouteToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.contentType,
        this.key,
        this.id,
        this.name,
        this.urlSegment,
        this.items,
      ];
}

@JsonSerializable()
class RouteContentType extends Equatable {
  String? key;
  int? id;
  String? alias;

  RouteContentType({this.key, this.id, this.alias});

  factory RouteContentType.fromJson(Map<String, dynamic> json) =>
      _$RouteContentTypeFromJson(json);

  Map<String, dynamic> toJson() => _$RouteContentTypeToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [this.key, this.id, this.alias];
}

@JsonSerializable()
class RouteItems extends Equatable {
  RouteContentType? contentType;
  String? key;
  int? id;
  String? name;
  String? urlSegment;
  List<dynamic>? items;

  RouteItems({
    this.contentType,
    this.key,
    this.id,
    this.name,
    this.urlSegment,
    this.items,
  });

  factory RouteItems.fromJson(Map<String, dynamic> json) =>
      _$RouteItemsFromJson(json);

  Map<String, dynamic> toJson() => _$RouteItemsToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.contentType,
        this.key,
        this.id,
        this.name,
        this.urlSegment,
        this.items,
      ];
}
