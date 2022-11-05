import 'package:app/models/home_content.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse extends Equatable {
  final int? id;
  final String? name;
  final String? urlSegment;
  final List<HomeContent>? items;

  const HomeResponse({
    this.id,
    this.name,
    this.urlSegment,
    this.items,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        urlSegment,
        items,
      ];
}
