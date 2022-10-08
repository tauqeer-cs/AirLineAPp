// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_summary_pnr_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightSummaryPnrRequest _$FlightSummaryPnrRequestFromJson(
        Map<String, dynamic> json) =>
    FlightSummaryPnrRequest(
      contactEmail: json['ContactEmail'] as String? ?? "",
      displayCurrency: json['DisplayCurrency'] as String? ?? "MYR",
      preferredContactMethod:
          json['PreferredContactMethod'] as String? ?? "email",
      comment: json['Comment'] as String? ?? "No",
      promoCode: json['PromoCode'] as String? ?? "",
      companyTaxInvoice: json['CompanyTaxInvoice'] == null
          ? null
          : CompanyTaxInvoice.fromJson(
              json['CompanyTaxInvoice'] as Map<String, dynamic>),
      emergencyContact: json['EmergencyContact'] == null
          ? null
          : EmergencyContact.fromJson(
              json['EmergencyContact'] as Map<String, dynamic>),
      passengers: (json['Passengers'] as List<dynamic>?)
              ?.map((e) => Passenger.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FlightSummaryPnrRequestToJson(
        FlightSummaryPnrRequest instance) =>
    <String, dynamic>{
      'ContactEmail': instance.contactEmail,
      'DisplayCurrency': instance.displayCurrency,
      'PreferredContactMethod': instance.preferredContactMethod,
      'Comment': instance.comment,
      'PromoCode': instance.promoCode,
      'CompanyTaxInvoice': instance.companyTaxInvoice,
      'EmergencyContact': instance.emergencyContact,
      'Passengers': instance.passengers,
    };

CompanyTaxInvoice _$CompanyTaxInvoiceFromJson(Map<String, dynamic> json) =>
    CompanyTaxInvoice(
      companyName: json['CompanyName'] as String? ?? "",
      companyAddress: json['CompanyAddress'] as String? ?? "",
      country: json['Country'] as String? ?? "",
      state: json['State'] as String? ?? "",
      city: json['City'] as String? ?? "",
      emailAddress: json['EmailAddress'] as String? ?? "",
      postCode: json['Postcode'] as String? ?? "",
    );

Map<String, dynamic> _$CompanyTaxInvoiceToJson(CompanyTaxInvoice instance) =>
    <String, dynamic>{
      'CompanyName': instance.companyName,
      'CompanyAddress': instance.companyAddress,
      'Country': instance.country,
      'State': instance.state,
      'City': instance.city,
      'EmailAddress': instance.emailAddress,
      'Postcode': instance.postCode,
    };

EmergencyContact _$EmergencyContactFromJson(Map<String, dynamic> json) =>
    EmergencyContact(
      firstName: json['FirstName'] as String? ?? "",
      lastName: json['LastName'] as String? ?? "",
      email: json['Email'] as String? ?? "",
      phoneCode: json['PhoneCode'] as String? ?? "",
      phoneNumber: json['PhoneNumber'] as String? ?? "",
      relationship: json['Relationship'] as String? ?? "",
    );

Map<String, dynamic> _$EmergencyContactToJson(EmergencyContact instance) =>
    <String, dynamic>{
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'Email': instance.email,
      'PhoneCode': instance.phoneCode,
      'PhoneNumber': instance.phoneNumber,
      'Relationship': instance.relationship,
    };

Passenger _$PassengerFromJson(Map<String, dynamic> json) => Passenger(
      dob: json['DOB'] == null ? null : DateTime.parse(json['DOB'] as String),
      firstName: json['FirstName'] as String? ?? "",
      lastName: json['LastName'] as String? ?? "",
      middleName: json['MiddleName'] as String? ?? "",
      title: json['Title'] as String? ?? "",
      gender: json['Gender'] as String? ?? "",
      infantAssociateIndex: json['InfantAssociateIndex'] as num? ?? 0,
      isPrimaryPassenger: json['IsPrimaryPassenger'] as bool? ?? true,
      knownTravelerNumber: json['KnownTravelerNumber'] as String? ?? "",
      nationality: json['Nationality'] as String? ?? "",
      nationalityLanguageId: json['NationalityLanguageID'] as num? ?? 0,
      passport: json['Passport'] as String? ?? "",
      paxType: json['PaxType'] as String? ?? "",
      personOrgId: json['PersonOrgID'] as num? ?? 1,
      profileId: json['ProfileId'] as num? ?? -1,
      redressNumber: json['RedressNumber'] as String? ?? "",
      relation: json['Relation'] as String? ?? "",
      suffix: json['Suffix'] as String? ?? "",
      ssr: json['SSR'] == null
          ? null
          : Ssr.fromJson(json['SSR'] as Map<String, dynamic>),
      seat: json['Seat'] == null
          ? null
          : Seat.fromJson(json['Seat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PassengerToJson(Passenger instance) => <String, dynamic>{
      'DOB': instance.dob?.toIso8601String(),
      'FirstName': instance.firstName,
      'LastName': instance.lastName,
      'MiddleName': instance.middleName,
      'Title': instance.title,
      'Gender': instance.gender,
      'InfantAssociateIndex': instance.infantAssociateIndex,
      'IsPrimaryPassenger': instance.isPrimaryPassenger,
      'KnownTravelerNumber': instance.knownTravelerNumber,
      'Nationality': instance.nationality,
      'NationalityLanguageID': instance.nationalityLanguageId,
      'Passport': instance.passport,
      'PaxType': instance.paxType,
      'PersonOrgID': instance.personOrgId,
      'ProfileId': instance.profileId,
      'RedressNumber': instance.redressNumber,
      'Relation': instance.relation,
      'Suffix': instance.suffix,
      'SSR': instance.ssr,
      'Seat': instance.seat,
    };

Seat _$SeatFromJson(Map<String, dynamic> json) => Seat(
      outbound: json['Outbound'] == null
          ? null
          : Outbound.fromJson(json['Outbound'] as Map<String, dynamic>),
      inbound: json['Inbound'] == null
          ? null
          : Outbound.fromJson(json['Inbound'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeatToJson(Seat instance) => <String, dynamic>{
      'Outbound': instance.outbound,
      'Inbound': instance.inbound,
    };

Outbound _$OutboundFromJson(Map<String, dynamic> json) => Outbound(
      seatRow: json['SeatRow'] as num?,
      seatColumn: json['SeatColumn'] as String?,
      physicalFlightId: json['PhysicalFlightID'] as num?,
      price: (json['price'] as List<dynamic>?)
          ?.map((e) => Price.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OutboundToJson(Outbound instance) => <String, dynamic>{
      'SeatRow': instance.seatRow,
      'SeatColumn': instance.seatColumn,
      'PhysicalFlightID': instance.physicalFlightId,
      'price': instance.price,
    };

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      amount: json['amount'] as num?,
      currency: json['currency'] as String?,
      isBundleOffer: json['isBundleOffer'] as bool?,
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency,
      'isBundleOffer': instance.isBundleOffer,
    };

Ssr _$SsrFromJson(Map<String, dynamic> json) => Ssr(
      outbound: (json['Outbound'] as List<dynamic>?)
          ?.map((e) => Bound.fromJson(e as Map<String, dynamic>))
          .toList(),
      inbound: (json['Inbound'] as List<dynamic>?)
          ?.map((e) => Bound.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SsrToJson(Ssr instance) => <String, dynamic>{
      'Outbound': instance.outbound,
      'Inbound': instance.inbound,
    };

Bound _$BoundFromJson(Map<String, dynamic> json) => Bound(
      logicalFlightId: json['LogicalFlightID'] as num?,
      serviceId: json['ServiceID'] as num?,
      servicesType: json['ServicesType'] as String?,
      quantity: json['Quantity'] as num?,
      price: json['Price'] as num?,
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$BoundToJson(Bound instance) => <String, dynamic>{
      'LogicalFlightID': instance.logicalFlightId,
      'ServiceID': instance.serviceId,
      'ServicesType': instance.servicesType,
      'Quantity': instance.quantity,
      'Price': instance.price,
      'Name': instance.name,
    };
