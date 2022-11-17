import 'package:app/models/airports.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'airports_response.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
class AirportsResponse extends HiveObject with EquatableMixin{
  final List<Airports>? airports;

  AirportsResponse(
      {this.airports});

  factory AirportsResponse.fromJson(Map<String, dynamic> json) => _$AirportsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AirportsResponseToJson(this);

  @override
  List<Object?> get props => [airports];

}
