import 'package:app/data/requests/search_flight_request.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_password_request.g.dart';

@JsonSerializable(includeIfNull: false)
class UpdatePasswordRequest extends Equatable {
  const UpdatePasswordRequest({
    this.email,
    this.previousPassword,
    this.newPassword,
    this.passphrase,
    this.password,
  });

  @JsonKey(name: 'Email')
  final String? email;
  @JsonKey(name: 'PreviousPassword')
  final String? previousPassword;
  @JsonKey(name: 'NewPassword')
  final String? newPassword;
  @JsonKey(name: 'Passphrase')
  final String? passphrase;
  @JsonKey(name: 'Password')
  final String? password;

  factory UpdatePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdatePasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePasswordRequestToJson(this);

  @override
  List<Object?> get props => [
        this.email,
        this.previousPassword,
        this.newPassword,
    this.newPassword,
    this.passphrase,
    this.password,
      ];
}
