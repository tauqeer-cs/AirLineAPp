import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_insurance_request.g.dart';

@CopyWith(copyWithNull: true)
@JsonSerializable()
class InsuranceRequest extends Equatable {
  const InsuranceRequest({
    this.token,
    this.updateInsuranceRequest,
  });

  @JsonKey(name: 'Token')
  final String? token;
  @JsonKey(name: 'UpdateInsuranceRequest')
  final UpdateInsuranceRequest? updateInsuranceRequest;

  @override
  // TODO: implement props
  List<Object?> get props => [
        token,
        updateInsuranceRequest,
      ];

  factory InsuranceRequest.fromJson(Map<String, dynamic> json) =>
      _$InsuranceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$InsuranceRequestToJson(this);
}

@CopyWith(copyWithNull: true)
@JsonSerializable()
class UpdateInsuranceRequest extends Equatable {
  const UpdateInsuranceRequest({
    this.isRemoveInsurance = false,
    this.passengers,
  });

  @JsonKey(name: 'IsRemoveInsurance')
  final bool? isRemoveInsurance;
  @JsonKey(name: 'Passengers')
  final List<Passenger>? passengers;

  @override
  // TODO: implement props
  List<Object?> get props => [
        isRemoveInsurance,
        passengers,
      ];

  factory UpdateInsuranceRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateInsuranceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateInsuranceRequestToJson(this);
}
