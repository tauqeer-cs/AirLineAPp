import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:hive/hive.dart';

part 'booking_local.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class BookingLocal extends HiveObject with EquatableMixin {
  @override
  List<Object?> get props => [
        this.bookingId,
        this.departureDate,
        this.returnDate,
        this.departureString,
        this.returnString,
      ];

  BookingLocal({
    this.bookingId,
    this.departureDate,
    this.returnDate,
    this.departureString,
    this.returnString,
  });

  @HiveField(0)
  final String? bookingId;
  @HiveField(1)
  final DateTime? departureDate;
  @HiveField(2)
  final DateTime? returnDate;
  @HiveField(3)
  final String? departureString;
  @HiveField(4)
  final String? returnString;

  BookingLocal copyWith({
    String? bookingId,
    DateTime? departureDate,
    DateTime? returnDate,
    String? departureString,
    String? returnString,
  }) =>
      BookingLocal(
        bookingId: bookingId ?? this.bookingId,
        departureDate: departureDate ?? this.departureDate,
        returnDate: returnDate ?? this.returnDate,
        departureString: departureString ?? this.departureString,
        returnString: returnString ?? this.returnString,
      );

  factory BookingLocal.fromJson(Map<String, dynamic> json) =>
      _$BookingLocalFromJson(json);

  Map<String, dynamic> toJson() => _$BookingLocalToJson(this);
}
