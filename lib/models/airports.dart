import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'airports.g.dart';

@JsonSerializable()
@HiveType(typeId: 7)
class Airports extends HiveObject with EquatableMixin{
  final List<Airports>? connections;
  final String? code;
  final String? name;
  final String? contryCode;
  final String? currency;

  Airports(
      {this.connections, this.code, this.name, this.contryCode, this.currency});

  factory Airports.fromJson(Map<String, dynamic> json) => _$AirportsFromJson(json);
  Map<String, dynamic> toJson() => _$AirportsToJson(this);

  @override
  List<Object?> get props => [code];

  @override
  String toString() {
    return name ?? code ?? "No name";
  }
}
