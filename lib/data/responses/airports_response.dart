import 'package:app/models/airports.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'airports_response.g.dart';

@JsonSerializable()
class AirportsResponse extends Equatable{
  final List<Airports>? airports;

  const AirportsResponse(
      {this.airports});

  factory AirportsResponse.fromJson(Map<String, dynamic> json) => _$AirportsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AirportsResponseToJson(this);

  @override
  List<Object?> get props => [airports];

}
