import 'package:app/models/home_content.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flight_summary_pnr_request.g.dart';

@JsonSerializable()
class FlightSummaryPnrRequest extends Equatable {
  @override
  List<Object?> get props => [
        contactEmail,
        displayCurrency,
        preferredContactMethod,
        comment,
        promoCode,
        companyTaxInvoice,
        emergencyContact,
        passengers,
      ];

  const FlightSummaryPnrRequest({
    this.contactEmail,
    this.displayCurrency = "MYR",
    this.preferredContactMethod = "email",
    this.comment = "No",
    this.promoCode,
    this.companyTaxInvoice,
    this.emergencyContact,
    this.passengers,
  });

  @JsonKey(name: 'ContactEmail')
  final String? contactEmail;
  @JsonKey(name: 'DisplayCurrency')
  final String? displayCurrency;
  @JsonKey(name: 'PreferredContactMethod')
  final String? preferredContactMethod;
  @JsonKey(name: 'Comment')
  final String? comment;
  @JsonKey(name: 'PromoCode')
  final String? promoCode;
  @JsonKey(name: 'CompanyTaxInvoice')
  final CompanyTaxInvoice? companyTaxInvoice;
  @JsonKey(name: 'EmergencyContact')
  final EmergencyContact? emergencyContact;
  @JsonKey(name: 'Passengers')
  final List<Passenger>? passengers;

  FlightSummaryPnrRequest copyWith({
    String? contactEmail,
    String? displayCurrency,
    String? preferredContactMethod,
    String? comment,
    String? promoCode,
    CompanyTaxInvoice? companyTaxInvoice,
    EmergencyContact? emergencyContact,
    List<Passenger>? passengers,
  }) =>
      FlightSummaryPnrRequest(
        contactEmail: contactEmail ?? this.contactEmail,
        displayCurrency: displayCurrency ?? this.displayCurrency,
        preferredContactMethod:
            preferredContactMethod ?? this.preferredContactMethod,
        comment: comment ?? this.comment,
        promoCode: promoCode ?? this.promoCode,
        companyTaxInvoice: companyTaxInvoice ?? this.companyTaxInvoice,
        emergencyContact: emergencyContact ?? this.emergencyContact,
        passengers: passengers ?? this.passengers,
      );

  factory FlightSummaryPnrRequest.fromJson(Map<String, dynamic> json) =>
      _$FlightSummaryPnrRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FlightSummaryPnrRequestToJson(this);
}

@JsonSerializable()
class CompanyTaxInvoice extends Equatable {
  @override
  List<Object?> get props => [
        companyName,
        companyAddress,
        country,
        state,
        city,
        emailAddress,
      ];

  factory CompanyTaxInvoice.fromJson(Map<String, dynamic> json) =>
      _$CompanyTaxInvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyTaxInvoiceToJson(this);

  const CompanyTaxInvoice({
    this.companyName,
    this.companyAddress,
    this.country,
    this.state,
    this.city,
    this.emailAddress,
  });

  @JsonKey(name: 'CompanyName')
  final String? companyName;
  @JsonKey(name: 'CompanyAddress')
  final String? companyAddress;
  @JsonKey(name: 'Country')
  final String? country;
  @JsonKey(name: 'State')
  final String? state;
  @JsonKey(name: 'City')
  final String? city;
  @JsonKey(name: 'EmailAddress')
  final String? emailAddress;

  CompanyTaxInvoice copyWith({
    String? companyName,
    String? companyAddress,
    String? country,
    String? state,
    String? city,
    String? emailAddress,
  }) =>
      CompanyTaxInvoice(
        companyName: companyName ?? this.companyName,
        companyAddress: companyAddress ?? this.companyAddress,
        country: country ?? this.country,
        state: state ?? this.state,
        city: city ?? this.city,
        emailAddress: emailAddress ?? this.emailAddress,
      );
}

@JsonSerializable()
class EmergencyContact extends Equatable {
  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phoneCode,
        phoneNumber,
        relationship,
      ];

  factory EmergencyContact.fromJson(Map<String, dynamic> json) =>
      _$EmergencyContactFromJson(json);

  Map<String, dynamic> toJson() => _$EmergencyContactToJson(this);

  const EmergencyContact({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneCode,
    this.phoneNumber,
    this.relationship,
  });

  @JsonKey(name: 'FirstName')
  final String? firstName;
  @JsonKey(name: 'LastName')
  final String? lastName;
  @JsonKey(name: 'Email')
  final String? email;
  @JsonKey(name: 'PhoneCode')
  final String? phoneCode;
  @JsonKey(name: 'PhoneNumber')
  final String? phoneNumber;
  @JsonKey(name: 'Relationship')
  final String? relationship;

  EmergencyContact copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneCode,
    String? phoneNumber,
    String? relationship,
  }) =>
      EmergencyContact(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        phoneCode: phoneCode ?? this.phoneCode,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        relationship: relationship ?? this.relationship,
      );
}

@JsonSerializable()
class Passenger extends Equatable {
  @override
  List<Object?> get props => [
        dob,
        firstName,
        lastName,
        middleName,
        title,
        gender,
        infantAssociateIndex,
        isPrimaryPassenger,
        knownTravelerNumber,
        nationality,
        nationalityLanguageId,
        passport,
        paxType,
        personOrgId,
        profileId,
        redressNumber,
        relation,
        suffix,
        ssr,
        seat,
      ];

  factory Passenger.fromJson(Map<String, dynamic> json) =>
      _$PassengerFromJson(json);

  Map<String, dynamic> toJson() => _$PassengerToJson(this);

  const Passenger({
    this.dob,
    this.firstName,
    this.lastName,
    this.middleName,
    this.title,
    this.gender,
    this.infantAssociateIndex,
    this.isPrimaryPassenger,
    this.knownTravelerNumber,
    this.nationality,
    this.nationalityLanguageId,
    this.passport,
    this.paxType,
    this.personOrgId,
    this.profileId,
    this.redressNumber,
    this.relation,
    this.suffix,
    this.ssr,
    this.seat,
  });

  @JsonKey(name: 'DOB')
  final DateTime? dob;
  @JsonKey(name: 'FirstName')
  final String? firstName;
  @JsonKey(name: 'LastName')
  final String? lastName;
  @JsonKey(name: 'MiddleName')
  final String? middleName;
  @JsonKey(name: 'Title')
  final String? title;
  @JsonKey(name: 'Gender')
  final String? gender;
  @JsonKey(name: 'InfantAssociateIndex')
  final num? infantAssociateIndex;
  @JsonKey(name: 'IsPrimaryPassenger')
  final bool? isPrimaryPassenger;
  @JsonKey(name: 'KnownTravelerNumber')
  final String? knownTravelerNumber;
  @JsonKey(name: 'Nationality')
  final String? nationality;
  @JsonKey(name: 'NationalityLanguageID')
  final num? nationalityLanguageId;
  @JsonKey(name: 'Passport')
  final String? passport;
  @JsonKey(name: 'PaxType')
  final String? paxType;
  @JsonKey(name: 'PersonOrgID')
  final num? personOrgId;
  @JsonKey(name: 'ProfileId')
  final num? profileId;
  @JsonKey(name: 'RedressNumber')
  final String? redressNumber;
  @JsonKey(name: 'Relation')
  final String? relation;
  @JsonKey(name: 'Suffix')
  final String? suffix;
  @JsonKey(name: 'SSR')
  final Ssr? ssr;
  @JsonKey(name: 'Seat')
  final Seat? seat;

  Passenger copyWith({
    DateTime? dob,
    String? firstName,
    String? lastName,
    String? middleName,
    String? title,
    String? gender,
    num? infantAssociateIndex,
    bool? isPrimaryPassenger,
    String? knownTravelerNumber,
    String? nationality,
    num? nationalityLanguageId,
    String? passport,
    String? paxType,
    num? personOrgId,
    num? profileId,
    String? redressNumber,
    String? relation,
    String? suffix,
    Ssr? ssr,
    Seat? seat,
  }) =>
      Passenger(
        dob: dob ?? this.dob,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        middleName: middleName ?? this.middleName,
        title: title ?? this.title,
        gender: gender ?? this.gender,
        infantAssociateIndex: infantAssociateIndex ?? this.infantAssociateIndex,
        isPrimaryPassenger: isPrimaryPassenger ?? this.isPrimaryPassenger,
        knownTravelerNumber: knownTravelerNumber ?? this.knownTravelerNumber,
        nationality: nationality ?? this.nationality,
        nationalityLanguageId:
            nationalityLanguageId ?? this.nationalityLanguageId,
        passport: passport ?? this.passport,
        paxType: paxType ?? this.paxType,
        personOrgId: personOrgId ?? this.personOrgId,
        profileId: profileId ?? this.profileId,
        redressNumber: redressNumber ?? this.redressNumber,
        relation: relation ?? this.relation,
        suffix: suffix ?? this.suffix,
        ssr: ssr ?? this.ssr,
        seat: seat ?? this.seat,
      );
}

@JsonSerializable()
class Seat extends Equatable {
  @override
  List<Object?> get props => [
        outbound,
        inbound,
      ];

  factory Seat.fromJson(Map<String, dynamic> json) => _$SeatFromJson(json);

  Map<String, dynamic> toJson() => _$SeatToJson(this);

  const Seat({
    this.outbound,
    this.inbound,
  });

  @JsonKey(name: 'Outbound')
  final Outbound? outbound;
  @JsonKey(name: 'Inbound')
  final Outbound? inbound;

  Seat copyWith({
    Outbound? outbound,
    Outbound? inbound,
  }) =>
      Seat(
        outbound: outbound ?? this.outbound,
        inbound: inbound ?? this.inbound,
      );
}

@JsonSerializable()
class Outbound extends Equatable {
  @override
  List<Object?> get props => [
        seatRow,
        seatColumn,
        physicalFlightId,
        price,
      ];

  factory Outbound.fromJson(Map<String, dynamic> json) =>
      _$OutboundFromJson(json);

  Map<String, dynamic> toJson() => _$OutboundToJson(this);

  const Outbound({
    this.seatRow,
    this.seatColumn,
    this.physicalFlightId,
    this.price,
  });

  @JsonKey(name: 'SeatRow')
  final num? seatRow;
  @JsonKey(name: 'SeatColumn')
  final String? seatColumn;
  @JsonKey(name: 'PhysicalFlightID')
  final num? physicalFlightId;
  @JsonKey(name: 'price')
  final List<Price>? price;

  Outbound copyWith({
    num? seatRow,
    String? seatColumn,
    num? physicalFlightId,
    List<Price>? price,
  }) =>
      Outbound(
        seatRow: seatRow ?? this.seatRow,
        seatColumn: seatColumn ?? this.seatColumn,
        physicalFlightId: physicalFlightId ?? this.physicalFlightId,
        price: price ?? this.price,
      );
}

@JsonSerializable()
class Price extends Equatable {
  @override
  List<Object?> get props => [
        amount,
        currency,
        isBundleOffer,
      ];

  factory Price.fromJson(Map<String, dynamic> json) => _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);

  const Price({
    this.amount,
    this.currency,
    this.isBundleOffer,
  });

  @JsonKey(name: 'amount')
  final num? amount;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'isBundleOffer')
  final bool? isBundleOffer;

  Price copyWith({
    num? amount,
    String? currency,
    bool? isBundleOffer,
  }) =>
      Price(
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        isBundleOffer: isBundleOffer ?? this.isBundleOffer,
      );
}

@JsonSerializable()
class Ssr extends Equatable {
  @override
  List<Object?> get props => [
        outbound,
        inbound,
      ];

  factory Ssr.fromJson(Map<String, dynamic> json) => _$SsrFromJson(json);

  Map<String, dynamic> toJson() => _$SsrToJson(this);

  const Ssr({
    this.outbound,
    this.inbound,
  });

  @JsonKey(name: 'Outbound')
  final List<Bound>? outbound;
  @JsonKey(name: 'Inbound')
  final List<Bound>? inbound;

  Ssr copyWith({
    List<Bound>? outbound,
    List<Bound>? inbound,
  }) =>
      Ssr(
        outbound: outbound ?? this.outbound,
        inbound: inbound ?? this.inbound,
      );
}

@JsonSerializable()
class Bound extends Equatable {
  @override
  List<Object?> get props => [
        logicalFlightId,
        serviceId,
        servicesType,
        quantity,
        price,
        name,
      ];

  factory Bound.fromJson(Map<String, dynamic> json) => _$BoundFromJson(json);

  Map<String, dynamic> toJson() => _$BoundToJson(this);

  const Bound({
    this.logicalFlightId,
    this.serviceId,
    this.servicesType,
    this.quantity,
    this.price,
    this.name,
  });

  @JsonKey(name: 'LogicalFlightID')
  final num? logicalFlightId;
  @JsonKey(name: 'ServiceID')
  final num? serviceId;
  @JsonKey(name: 'ServicesType')
  final String? servicesType;
  @JsonKey(name: 'Quantity')
  final num? quantity;
  @JsonKey(name: 'Price')
  final num? price;
  @JsonKey(name: 'Name')
  final String? name;

  Bound copyWith({
    num? logicalFlightId,
    num? serviceId,
    String? servicesType,
    num? quantity,
    num? price,
    String? name,
  }) =>
      Bound(
        logicalFlightId: logicalFlightId ?? this.logicalFlightId,
        serviceId: serviceId ?? this.serviceId,
        servicesType: servicesType ?? this.servicesType,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        name: name ?? this.name,
      );
}
