// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlightResponse _$FlightResponseFromJson(Map<String, dynamic> json) =>
    FlightResponse(
      searchFlightRequest: json['searchFlightRequest'] == null
          ? null
          : CommonFlightRequest.fromJson(
              json['searchFlightRequest'] as Map<String, dynamic>),
      searchFlightResponse: json['searchFlightResponse'] == null
          ? null
          : SearchFlightResponse.fromJson(
              json['searchFlightResponse'] as Map<String, dynamic>),
      orderID: json['orderID'] as num?,
      isVisaCampaign: json['isVisaCampaign'] as bool?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$FlightResponseToJson(FlightResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('searchFlightRequest', instance.searchFlightRequest);
  writeNotNull('searchFlightResponse', instance.searchFlightResponse);
  writeNotNull('orderID', instance.orderID);
  writeNotNull('success', instance.success);
  writeNotNull('isVisaCampaign', instance.isVisaCampaign);
  return val;
}

SearchFlightResponse _$SearchFlightResponseFromJson(
        Map<String, dynamic> json) =>
    SearchFlightResponse(
      errors: json['errors'] as List<dynamic>?,
      flightResult: json['flightResult'] == null
          ? null
          : FlightResult.fromJson(json['flightResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchFlightResponseToJson(
    SearchFlightResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('errors', instance.errors);
  writeNotNull('flightResult', instance.flightResult);
  return val;
}

FlightResult _$FlightResultFromJson(Map<String, dynamic> json) => FlightResult(
      inboundSegment: (json['inboundSegment'] as List<dynamic>?)
          ?.map(
              (e) => InboundOutboundSegment.fromJson(e as Map<String, dynamic>))
          .toList(),
      outboundSegment: (json['outboundSegment'] as List<dynamic>?)
          ?.map(
              (e) => InboundOutboundSegment.fromJson(e as Map<String, dynamic>))
          .toList(),
      commissionIncluded: json['commissionIncluded'] as bool?,
      legDetails: (json['legDetails'] as List<dynamic>?)
          ?.map((e) => LegDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      requestReservationChannel: json['requestReservationChannel'] as num?,
      requestedCorporationID: json['requestedCorporationID'] as num?,
      requestedCurrencyOfFareQuote:
          json['requestedCurrencyOfFareQuote'] as String?,
      requestedFareFilterMethod: json['requestedFareFilterMethod'] as num?,
      requestedGroupMethod: json['requestedGroupMethod'] as num?,
      requestedIataNumber: json['requestedIataNumber'] as String?,
      requestedInventoryFilterMethod:
          json['requestedInventoryFilterMethod'] as num?,
      taxDetails: (json['taxDetails'] as List<dynamic>?)
          ?.map((e) => TaxDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      requestedPromotionalCode: json['requestedPromotionalCode'] as String?,
    );

Map<String, dynamic> _$FlightResultToJson(FlightResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('inboundSegment', instance.inboundSegment);
  writeNotNull('outboundSegment', instance.outboundSegment);
  writeNotNull('commissionIncluded', instance.commissionIncluded);
  writeNotNull('legDetails', instance.legDetails);
  writeNotNull('requestReservationChannel', instance.requestReservationChannel);
  writeNotNull('requestedCorporationID', instance.requestedCorporationID);
  writeNotNull(
      'requestedCurrencyOfFareQuote', instance.requestedCurrencyOfFareQuote);
  writeNotNull('requestedFareFilterMethod', instance.requestedFareFilterMethod);
  writeNotNull('requestedGroupMethod', instance.requestedGroupMethod);
  writeNotNull('requestedIataNumber', instance.requestedIataNumber);
  writeNotNull('requestedPromotionalCode', instance.requestedPromotionalCode);
  writeNotNull('requestedInventoryFilterMethod',
      instance.requestedInventoryFilterMethod);
  writeNotNull('taxDetails', instance.taxDetails);
  return val;
}

InboundOutboundSegment _$InboundOutboundSegmentFromJson(
        Map<String, dynamic> json) =>
    InboundOutboundSegment(
      totalSegmentFareAmtWithInfantSSR:
          json['totalSegmentFareAmtWithInfantSSR'] as num?,
      beforeDiscountTotalAmt: json['beforeDiscountTotalAmt'] as num?,
      beforeDiscountTotalAmtWithInfantSSR:
          json['beforeDiscountTotalAmtWithInfantSSR'] as num?,
      fbCode: json['fbCode'] as String?,
      segmentDetail: json['segmentDetail'] == null
          ? null
          : SegmentDetail.fromJson(
              json['segmentDetail'] as Map<String, dynamic>),
      minInboundTotalPrice: json['minInboundTotalPrice'] as num?,
      totalSegmentFareAmt: json['totalSegmentFareAmt'] as num?,
      adultPricePerPax: json['adultPricePerPax'] as num?,
      discountPCT: json['discountPCT'] as num?,
      adultPriceTotal: json['adultPriceTotal'] as num? ?? 0,
      childPricePerPax: json['childPricePerPax'] as num?,
      childPriceTotal: json['childPriceTotal'] as num? ?? 0,
      infantPricePerPax: json['infantPricePerPax'] as num?,
      infantPriceTotal: json['infantPriceTotal'] as num? ?? 0,
      fareTypeWithTaxDetails: (json['fareTypeWithTaxDetails'] as List<dynamic>?)
          ?.map(
              (e) => FareTypeWithTaxDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      lfid: json['lfid'] as num?,
      departureDate: json['departureDate'] == null
          ? null
          : DateTime.parse(json['departureDate'] as String),
      arrivalDate: json['arrivalDate'] == null
          ? null
          : DateTime.parse(json['arrivalDate'] as String),
      legCount: json['legCount'] as num?,
      international: json['international'] as bool?,
      flightLegDetails: (json['flightLegDetails'] as List<dynamic>?)
          ?.map((e) => FlightLegDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      changeFlightAmount: json['changeFlightAmount'] as num?,
    );

Map<String, dynamic> _$InboundOutboundSegmentToJson(
    InboundOutboundSegment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('segmentDetail', instance.segmentDetail);
  writeNotNull('minInboundTotalPrice', instance.minInboundTotalPrice);
  writeNotNull('totalSegmentFareAmt', instance.totalSegmentFareAmt);
  writeNotNull('adultPricePerPax', instance.adultPricePerPax);
  val['adultPriceTotal'] = instance.adultPriceTotal;
  writeNotNull('childPricePerPax', instance.childPricePerPax);
  val['childPriceTotal'] = instance.childPriceTotal;
  writeNotNull('infantPricePerPax', instance.infantPricePerPax);
  val['infantPriceTotal'] = instance.infantPriceTotal;
  writeNotNull('fareTypeWithTaxDetails', instance.fareTypeWithTaxDetails);
  writeNotNull('lfid', instance.lfid);
  writeNotNull('departureDate', instance.departureDate?.toIso8601String());
  writeNotNull('arrivalDate', instance.arrivalDate?.toIso8601String());
  writeNotNull('legCount', instance.legCount);
  writeNotNull('international', instance.international);
  writeNotNull('flightLegDetails', instance.flightLegDetails);
  writeNotNull('totalSegmentFareAmtWithInfantSSR',
      instance.totalSegmentFareAmtWithInfantSSR);
  writeNotNull('beforeDiscountTotalAmt', instance.beforeDiscountTotalAmt);
  writeNotNull('beforeDiscountTotalAmtWithInfantSSR',
      instance.beforeDiscountTotalAmtWithInfantSSR);
  writeNotNull('discountPCT', instance.discountPCT);
  writeNotNull('changeFlightAmount', instance.changeFlightAmount);
  writeNotNull('fbCode', instance.fbCode);
  return val;
}

SegmentDetail _$SegmentDetailFromJson(Map<String, dynamic> json) =>
    SegmentDetail(
      lfid: json['lfid'] as num?,
      origin: json['origin'] as String?,
      destination: json['destination'] as String?,
      departureDate: json['departureDate'] == null
          ? null
          : DateTime.parse(json['departureDate'] as String),
      carrierCode: json['carrierCode'] as String?,
      arrivalDate: json['arrivalDate'] == null
          ? null
          : DateTime.parse(json['arrivalDate'] as String),
      stops: json['stops'] as num?,
      flightTime: json['flightTime'] as num?,
      aircraftType: json['aircraftType'] as String?,
      sellingCarrier: json['sellingCarrier'] as String?,
      flightNum: json['flightNum'] as String?,
      operatingCarrier: json['operatingCarrier'] as String?,
      operatingFlightNum: json['operatingFlightNum'] as String?,
      flyMonday: json['flyMonday'] as bool?,
      flyTuesday: json['flyTuesday'] as bool?,
      flyWednesday: json['flyWednesday'] as bool?,
      flyThursday: json['flyThursday'] as bool?,
      flyFriday: json['flyFriday'] as bool?,
      flySaturday: json['flySaturday'] as bool?,
      flySunday: json['flySunday'] as bool?,
      aircraftDescription: json['aircraftDescription'] as String?,
      deiDisclosure: json['deiDisclosure'] as String?,
    );

Map<String, dynamic> _$SegmentDetailToJson(SegmentDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('lfid', instance.lfid);
  writeNotNull('origin', instance.origin);
  writeNotNull('destination', instance.destination);
  writeNotNull('departureDate', instance.departureDate?.toIso8601String());
  writeNotNull('carrierCode', instance.carrierCode);
  writeNotNull('arrivalDate', instance.arrivalDate?.toIso8601String());
  writeNotNull('stops', instance.stops);
  writeNotNull('flightTime', instance.flightTime);
  writeNotNull('aircraftType', instance.aircraftType);
  writeNotNull('sellingCarrier', instance.sellingCarrier);
  writeNotNull('flightNum', instance.flightNum);
  writeNotNull('operatingCarrier', instance.operatingCarrier);
  writeNotNull('operatingFlightNum', instance.operatingFlightNum);
  writeNotNull('flyMonday', instance.flyMonday);
  writeNotNull('flyTuesday', instance.flyTuesday);
  writeNotNull('flyWednesday', instance.flyWednesday);
  writeNotNull('flyThursday', instance.flyThursday);
  writeNotNull('flyFriday', instance.flyFriday);
  writeNotNull('flySaturday', instance.flySaturday);
  writeNotNull('flySunday', instance.flySunday);
  writeNotNull('aircraftDescription', instance.aircraftDescription);
  writeNotNull('deiDisclosure', instance.deiDisclosure);
  return val;
}

FareTypeWithTaxDetails _$FareTypeWithTaxDetailsFromJson(
        Map<String, dynamic> json) =>
    FareTypeWithTaxDetails(
      fareInfoWithTaxDetails: (json['fareInfoWithTaxDetails'] as List<dynamic>?)
          ?.map(
              (e) => FareInfoWithTaxDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      fareTypeID: json['fareTypeID'] as num?,
      fareTypeName: json['fareTypeName'] as String?,
      filterRemove: json['filterRemove'] as bool?,
    );

Map<String, dynamic> _$FareTypeWithTaxDetailsToJson(
    FareTypeWithTaxDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fareInfoWithTaxDetails', instance.fareInfoWithTaxDetails);
  writeNotNull('fareTypeID', instance.fareTypeID);
  writeNotNull('fareTypeName', instance.fareTypeName);
  writeNotNull('filterRemove', instance.filterRemove);
  return val;
}

FareInfoWithTaxDetails _$FareInfoWithTaxDetailsFromJson(
        Map<String, dynamic> json) =>
    FareInfoWithTaxDetails(
      applicationTaxDetailBinds:
          (json['applicationTaxDetailBinds'] as List<dynamic>?)
              ?.map((e) =>
                  ApplicationTaxDetailBinds.fromJson(e as Map<String, dynamic>))
              .toList(),
      returnFlightSegmentDetails:
          json['returnFlightSegmentDetails'] as List<dynamic>?,
      fareID: json['fareID'] as num?,
      fcCode: json['fcCode'] as String?,
      fbCode: json['fbCode'] as String?,
      baseFareAmtNoTaxes: json['baseFareAmtNoTaxes'] as num?,
      baseFareAmt: json['baseFareAmt'] as num?,
      fareAmtNoTaxes: json['fareAmtNoTaxes'] as num?,
      fareAmt: json['fareAmt'] as num?,
      baseFareAmtInclTax: json['baseFareAmtInclTax'] as num?,
      fareAmtInclTax: json['fareAmtInclTax'] as num?,
      pvtFare: json['pvtFare'] as bool?,
      ptcid: json['ptcid'] as num?,
      cabin: json['cabin'] as String?,
      seatsAvailable: json['seatsAvailable'] as num?,
      infantSeatsAvailable: json['infantSeatsAvailable'] as num?,
      fareScheduleID: json['fareScheduleID'] as num?,
      promotionID: json['promotionID'] as num?,
      roundTrip: json['roundTrip'] as num?,
      displayFareAmt: json['displayFareAmt'] as num?,
      displayTaxSum: json['displayTaxSum'] as num?,
      specialMarketed: json['specialMarketed'] as bool?,
      waitList: json['waitList'] as bool?,
      spaceAvailable: json['spaceAvailable'] as bool?,
      positiveSpace: json['positiveSpace'] as bool?,
      promotionCatID: json['promotionCatID'] as num?,
      commissionAmount: json['commissionAmount'] as num?,
      promotionAmount: json['promotionAmount'] as num?,
      bundleCode: json['bundleCode'] as String?,
      originalCurrency: json['originalCurrency'] as String?,
      exchangeRate: json['exchangeRate'] as num?,
      exchangeDate: json['exchangeDate'] == null
          ? null
          : DateTime.parse(json['exchangeDate'] as String),
    );

Map<String, dynamic> _$FareInfoWithTaxDetailsToJson(
    FareInfoWithTaxDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('applicationTaxDetailBinds', instance.applicationTaxDetailBinds);
  writeNotNull(
      'returnFlightSegmentDetails', instance.returnFlightSegmentDetails);
  writeNotNull('fareID', instance.fareID);
  writeNotNull('fcCode', instance.fcCode);
  writeNotNull('fbCode', instance.fbCode);
  writeNotNull('baseFareAmtNoTaxes', instance.baseFareAmtNoTaxes);
  writeNotNull('baseFareAmt', instance.baseFareAmt);
  writeNotNull('fareAmtNoTaxes', instance.fareAmtNoTaxes);
  writeNotNull('fareAmt', instance.fareAmt);
  writeNotNull('baseFareAmtInclTax', instance.baseFareAmtInclTax);
  writeNotNull('fareAmtInclTax', instance.fareAmtInclTax);
  writeNotNull('pvtFare', instance.pvtFare);
  writeNotNull('ptcid', instance.ptcid);
  writeNotNull('cabin', instance.cabin);
  writeNotNull('seatsAvailable', instance.seatsAvailable);
  writeNotNull('infantSeatsAvailable', instance.infantSeatsAvailable);
  writeNotNull('fareScheduleID', instance.fareScheduleID);
  writeNotNull('promotionID', instance.promotionID);
  writeNotNull('roundTrip', instance.roundTrip);
  writeNotNull('displayFareAmt', instance.displayFareAmt);
  writeNotNull('displayTaxSum', instance.displayTaxSum);
  writeNotNull('specialMarketed', instance.specialMarketed);
  writeNotNull('waitList', instance.waitList);
  writeNotNull('spaceAvailable', instance.spaceAvailable);
  writeNotNull('positiveSpace', instance.positiveSpace);
  writeNotNull('promotionCatID', instance.promotionCatID);
  writeNotNull('commissionAmount', instance.commissionAmount);
  writeNotNull('promotionAmount', instance.promotionAmount);
  writeNotNull('bundleCode', instance.bundleCode);
  writeNotNull('originalCurrency', instance.originalCurrency);
  writeNotNull('exchangeRate', instance.exchangeRate);
  writeNotNull('exchangeDate', instance.exchangeDate?.toIso8601String());
  return val;
}

ApplicationTaxDetailBinds _$ApplicationTaxDetailBindsFromJson(
        Map<String, dynamic> json) =>
    ApplicationTaxDetailBinds(
      taxDetail: json['taxDetail'] == null
          ? null
          : TaxDetail.fromJson(json['taxDetail'] as Map<String, dynamic>),
      taxID: json['taxID'] as num?,
      amt: json['amt'] as num?,
      initiatingTaxID: json['initiatingTaxID'] as num?,
      commissionAmount: json['commissionAmount'] as num?,
    );

Map<String, dynamic> _$ApplicationTaxDetailBindsToJson(
    ApplicationTaxDetailBinds instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('taxDetail', instance.taxDetail);
  writeNotNull('taxID', instance.taxID);
  writeNotNull('amt', instance.amt);
  writeNotNull('initiatingTaxID', instance.initiatingTaxID);
  writeNotNull('commissionAmount', instance.commissionAmount);
  return val;
}

TaxDetail _$TaxDetailFromJson(Map<String, dynamic> json) => TaxDetail(
      taxID: json['taxID'] as num?,
      taxCode: json['taxCode'] as String?,
      codeType: json['codeType'] as String?,
      taxCurr: json['taxCurr'] as String?,
      taxDesc: json['taxDesc'] as String?,
      taxType: json['taxType'] as num?,
      isVat: json['isVat'] as bool?,
      includedInFare: json['includedInFare'] as bool?,
      originalCurrency: json['originalCurrency'] as String?,
      exchangeRate: json['exchangeRate'] as num?,
      exchangeDate: json['exchangeDate'] == null
          ? null
          : DateTime.parse(json['exchangeDate'] as String),
      commissionable: json['commissionable'] as bool?,
    );

Map<String, dynamic> _$TaxDetailToJson(TaxDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('taxID', instance.taxID);
  writeNotNull('taxCode', instance.taxCode);
  writeNotNull('codeType', instance.codeType);
  writeNotNull('taxCurr', instance.taxCurr);
  writeNotNull('taxDesc', instance.taxDesc);
  writeNotNull('taxType', instance.taxType);
  writeNotNull('isVat', instance.isVat);
  writeNotNull('includedInFare', instance.includedInFare);
  writeNotNull('originalCurrency', instance.originalCurrency);
  writeNotNull('exchangeRate', instance.exchangeRate);
  writeNotNull('exchangeDate', instance.exchangeDate?.toIso8601String());
  writeNotNull('commissionable', instance.commissionable);
  return val;
}

FlightLegDetails _$FlightLegDetailsFromJson(Map<String, dynamic> json) =>
    FlightLegDetails(
      pfid: json['pfid'] as num?,
      departureDate: json['departureDate'] == null
          ? null
          : DateTime.parse(json['departureDate'] as String),
    );

Map<String, dynamic> _$FlightLegDetailsToJson(FlightLegDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('pfid', instance.pfid);
  writeNotNull('departureDate', instance.departureDate?.toIso8601String());
  return val;
}

LegDetails _$LegDetailsFromJson(Map<String, dynamic> json) => LegDetails(
      pfid: json['pfid'] as num?,
      departureDate: json['departureDate'] == null
          ? null
          : DateTime.parse(json['departureDate'] as String),
      origin: json['origin'] as String?,
      destination: json['destination'] as String?,
      flightNum: json['flightNum'] as String?,
      international: json['international'] as bool?,
      arrivalDate: json['arrivalDate'] == null
          ? null
          : DateTime.parse(json['arrivalDate'] as String),
      flightTime: json['flightTime'] as num?,
      operatingCarrier: json['operatingCarrier'] as String?,
      fromTerminal: json['fromTerminal'] as String?,
      toTerminal: json['toTerminal'] as String?,
      aircraftType: json['aircraftType'] as String?,
      aircraftDescription: json['aircraftDescription'] as String?,
      deiDisclosure: json['deiDisclosure'] as String?,
      aircraftLayoutName: json['aircraftLayoutName'] as String?,
      serviceType: json['serviceType'] as String?,
    );

Map<String, dynamic> _$LegDetailsToJson(LegDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('pfid', instance.pfid);
  writeNotNull('departureDate', instance.departureDate?.toIso8601String());
  writeNotNull('origin', instance.origin);
  writeNotNull('destination', instance.destination);
  writeNotNull('flightNum', instance.flightNum);
  writeNotNull('international', instance.international);
  writeNotNull('arrivalDate', instance.arrivalDate?.toIso8601String());
  writeNotNull('flightTime', instance.flightTime);
  writeNotNull('operatingCarrier', instance.operatingCarrier);
  writeNotNull('fromTerminal', instance.fromTerminal);
  writeNotNull('toTerminal', instance.toTerminal);
  writeNotNull('aircraftType', instance.aircraftType);
  writeNotNull('aircraftDescription', instance.aircraftDescription);
  writeNotNull('deiDisclosure', instance.deiDisclosure);
  writeNotNull('aircraftLayoutName', instance.aircraftLayoutName);
  writeNotNull('serviceType', instance.serviceType);
  return val;
}
