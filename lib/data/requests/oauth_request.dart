import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/models/home_content.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'oauth_request.g.dart';

@JsonSerializable()
class OauthRequest extends Equatable {
  OauthRequest({
    this.platform,
    this.token,
    this.fcmToken,
  });

  factory OauthRequest.fromJson(Map<String, dynamic> json) =>
      _$OauthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OauthRequestToJson(this);

  final String? platform;
  final String? token;
  final String? fcmToken;

  OauthRequest copyWith({
    String? platform,
    String? token,
    String? fcmToken,
  }) =>
      OauthRequest(
        platform: platform ?? this.platform,
        token: token ?? this.token,
        fcmToken: fcmToken ?? this.fcmToken,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.platform,
        this.token,
        this.fcmToken,
      ];
}
