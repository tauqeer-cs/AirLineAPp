import 'package:app/data/requests/search_flight_request.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:app/models/home_content.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_request.g.dart';

@CopyWith(copyWithNull: true)
@JsonSerializable(includeIfNull: false)
class VoucherRequest extends Equatable {
  const VoucherRequest({
    this.token,
    this.insertVoucher,
  });

  final String? token;
  @JsonKey(name: 'InsertVoucher')
  final String? insertVoucher;

  factory VoucherRequest.fromJson(Map<String, dynamic> json) =>
      _$VoucherRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherRequestToJson(this);

  @override
  List<Object?> get props => [this.token, this.insertVoucher];
}
