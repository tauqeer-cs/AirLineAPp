import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/models/home_content.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest extends Equatable {
  const LoginRequest({
    this.userName,
    this.password,
    this.role = "MEM",
  });

  @JsonKey(name: "UserName")
  final String? userName;
  @JsonKey(name: "Password")
  final String? password;
  @JsonKey(name: "Role")
  final String? role;

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  LoginRequest copyWith({
    String? userName,
    String? password,
    String? role,
  }) =>
      LoginRequest(
        userName: userName ?? this.userName,
        password: password ?? this.password,
        role: role ?? this.role,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.userName,
        this.password,
        this.role,
      ];
}
