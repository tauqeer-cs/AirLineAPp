import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'airports.g.dart';

@JsonSerializable()
class Airports extends Equatable{
  final List<Airports>? connections;
  final String? code;
  final String? name;
  final String? contryCode;
  final String? currency;

  const Airports(
      {this.connections, this.code, this.name, this.contryCode, this.currency});

  factory Airports.fromJson(Map<String, dynamic> json) => _$AirportsFromJson(json);
  Map<String, dynamic> toJson() => _$AirportsToJson(this);

  @override
  List<Object?> get props => [connections, code, name, contryCode, currency];

  @override
  String toString() {
    return name ?? "";
  }
}
