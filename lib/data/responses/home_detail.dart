import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_detail.g.dart';

@JsonSerializable()
class HomeDetail extends Equatable {
  @override
  List<Object?> get props => [data];
  const HomeDetail({
    this.data,
  });
  final Data? data;

  factory HomeDetail.fromJson(Map<String, dynamic> json) =>
      _$HomeDetailFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDetailToJson(this);
}

@JsonSerializable()
class Data extends Equatable {
  @override
  List<Object?> get props => [current];
  const Data({
    this.current,
  });
  final Current? current;
  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Current extends Equatable {
  const Current({
    this.content,
    this.showBookNow,
    this.id,
    this.name,
  });

  final String? content;
  final bool? showBookNow;
  final int? id;
  final String? name;

  @override
  List<Object?> get props => [
        content,
        showBookNow,
        id,
        name,
      ];
  factory Current.fromJson(Map<String, dynamic> json) =>
      _$CurrentFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentToJson(this);
}
