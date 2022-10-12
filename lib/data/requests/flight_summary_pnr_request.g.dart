// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_summary_pnr_request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlightSummaryPnrRequestAdapter
    extends TypeAdapter<FlightSummaryPnrRequest> {
  @override
  final int typeId = 0;

  @override
  FlightSummaryPnrRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FlightSummaryPnrRequest(
      contactEmail: fields[0] as String,
      companyTaxInvoice: fields[1] as CompanyTaxInvoice?,
      emergencyContact: fields[2] as EmergencyContact?,
      passengers: (fields[3] as List).cast<Passenger>(),
    );
  }

  @override
  void write(BinaryWriter writer, FlightSummaryPnrRequest obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.contactEmail)
      ..writeByte(1)
      ..write(obj.companyTaxInvoice)
      ..writeByte(2)
      ..write(obj.emergencyContact)
      ..writeByte(3)
      ..write(obj.passengers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlightSummaryPnrRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CompanyTaxInvoiceAdapter extends TypeAdapter<CompanyTaxInvoice> {
  @override
  final int typeId = 1;

  @override
  CompanyTaxInvoice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompanyTaxInvoice(
      companyName: fields[0] as String?,
      companyAddress: fields[1] as String?,
      country: fields[2] as String?,
      state: fields[3] as String?,
      city: fields[4] as String?,
      emailAddress: fields[5] as String?,
      postCode: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CompanyTaxInvoice obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.companyName)
      ..writeByte(1)
      ..write(obj.companyAddress)
      ..writeByte(2)
      ..write(obj.country)
      ..writeByte(3)
      ..write(obj.state)
      ..writeByte(4)
      ..write(obj.city)
      ..writeByte(5)
      ..write(obj.emailAddress)
      ..writeByte(6)
      ..write(obj.postCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyTaxInvoiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EmergencyContactAdapter extends TypeAdapter<EmergencyContact> {
  @override
  final int typeId = 2;

  @override
  EmergencyContact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmergencyContact(
      firstName: fields[0] as String?,
      lastName: fields[1] as String?,
      email: fields[2] as String?,
      phoneCode: fields[3] as String?,
      phoneNumber: fields[4] as String?,
      relationship: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EmergencyContact obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.lastName)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phoneCode)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.relationship);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmergencyContactAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PassengerAdapter extends TypeAdapter<Passenger> {
  @override
  final int typeId = 3;

  @override
  Passenger read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Passenger(
      dob: fields[0] as DateTime?,
      firstName: fields[1] as String?,
      lastName: fields[2] as String?,
      title: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Passenger obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.dob)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PassengerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
    FlightSummaryPnrRequest instance) {
  final val = <String, dynamic>{
    'ContactEmail': instance.contactEmail,
    'DisplayCurrency': instance.displayCurrency,
    'PreferredContactMethod': instance.preferredContactMethod,
    'Comment': instance.comment,
    'PromoCode': instance.promoCode,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('CompanyTaxInvoice', instance.companyTaxInvoice);
  writeNotNull('EmergencyContact', instance.emergencyContact);
  val['Passengers'] = instance.passengers;
  return val;
}

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

Map<String, dynamic> _$CompanyTaxInvoiceToJson(CompanyTaxInvoice instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('CompanyName', instance.companyName);
  writeNotNull('CompanyAddress', instance.companyAddress);
  writeNotNull('Country', instance.country);
  writeNotNull('State', instance.state);
  writeNotNull('City', instance.city);
  writeNotNull('EmailAddress', instance.emailAddress);
  writeNotNull('Postcode', instance.postCode);
  return val;
}

EmergencyContact _$EmergencyContactFromJson(Map<String, dynamic> json) =>
    EmergencyContact(
      firstName: json['FirstName'] as String? ?? "",
      lastName: json['LastName'] as String? ?? "",
      email: json['Email'] as String? ?? "",
      phoneCode: json['PhoneCode'] as String? ?? "",
      phoneNumber: json['PhoneNumber'] as String? ?? "",
      relationship: json['Relationship'] as String? ?? "",
    );

Map<String, dynamic> _$EmergencyContactToJson(EmergencyContact instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('FirstName', instance.firstName);
  writeNotNull('LastName', instance.lastName);
  writeNotNull('Email', instance.email);
  writeNotNull('PhoneCode', instance.phoneCode);
  writeNotNull('PhoneNumber', instance.phoneNumber);
  writeNotNull('Relationship', instance.relationship);
  return val;
}

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

Map<String, dynamic> _$PassengerToJson(Passenger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('DOB', instance.dob?.toIso8601String());
  writeNotNull('FirstName', instance.firstName);
  writeNotNull('LastName', instance.lastName);
  writeNotNull('MiddleName', instance.middleName);
  writeNotNull('Title', instance.title);
  writeNotNull('Gender', instance.gender);
  writeNotNull('InfantAssociateIndex', instance.infantAssociateIndex);
  writeNotNull('IsPrimaryPassenger', instance.isPrimaryPassenger);
  writeNotNull('KnownTravelerNumber', instance.knownTravelerNumber);
  writeNotNull('Nationality', instance.nationality);
  writeNotNull('NationalityLanguageID', instance.nationalityLanguageId);
  writeNotNull('Passport', instance.passport);
  writeNotNull('PaxType', instance.paxType);
  writeNotNull('PersonOrgID', instance.personOrgId);
  writeNotNull('ProfileId', instance.profileId);
  writeNotNull('RedressNumber', instance.redressNumber);
  writeNotNull('Relation', instance.relation);
  writeNotNull('Suffix', instance.suffix);
  writeNotNull('SSR', instance.ssr);
  writeNotNull('Seat', instance.seat);
  return val;
}

Seat _$SeatFromJson(Map<String, dynamic> json) => Seat(
      outbound: json['Outbound'] == null
          ? null
          : Outbound.fromJson(json['Outbound'] as Map<String, dynamic>),
      inbound: json['Inbound'] == null
          ? null
          : Outbound.fromJson(json['Inbound'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeatToJson(Seat instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Outbound', instance.outbound);
  writeNotNull('Inbound', instance.inbound);
  return val;
}

Outbound _$OutboundFromJson(Map<String, dynamic> json) => Outbound(
      seatRow: json['SeatRow'] as num?,
      seatColumn: json['SeatColumn'] as String?,
      physicalFlightId: json['PhysicalFlightID'] as num?,
      price: (json['price'] as List<dynamic>?)
          ?.map((e) => Price.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OutboundToJson(Outbound instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('SeatRow', instance.seatRow);
  writeNotNull('SeatColumn', instance.seatColumn);
  writeNotNull('PhysicalFlightID', instance.physicalFlightId);
  writeNotNull('price', instance.price);
  return val;
}

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      amount: json['amount'] as num?,
      currency: json['currency'] as String?,
      isBundleOffer: json['isBundleOffer'] as bool?,
    );

Map<String, dynamic> _$PriceToJson(Price instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('amount', instance.amount);
  writeNotNull('currency', instance.currency);
  writeNotNull('isBundleOffer', instance.isBundleOffer);
  return val;
}

Ssr _$SsrFromJson(Map<String, dynamic> json) => Ssr(
      outbound: (json['Outbound'] as List<dynamic>?)
          ?.map((e) => Bound.fromJson(e as Map<String, dynamic>))
          .toList(),
      inbound: (json['Inbound'] as List<dynamic>?)
          ?.map((e) => Bound.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SsrToJson(Ssr instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('Outbound', instance.outbound);
  writeNotNull('Inbound', instance.inbound);
  return val;
}

Bound _$BoundFromJson(Map<String, dynamic> json) => Bound(
      logicalFlightId: json['LogicalFlightID'] as num?,
      serviceId: json['ServiceID'] as num?,
      servicesType: json['ServicesType'] as String?,
      quantity: json['Quantity'] as num?,
      price: json['Price'] as num?,
      name: json['Name'] as String?,
    );

Map<String, dynamic> _$BoundToJson(Bound instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('LogicalFlightID', instance.logicalFlightId);
  writeNotNull('ServiceID', instance.serviceId);
  writeNotNull('ServicesType', instance.servicesType);
  writeNotNull('Quantity', instance.quantity);
  writeNotNull('Price', instance.price);
  writeNotNull('Name', instance.name);
  return val;
}
