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
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$FlightResponseToJson(FlightResponse instance) =>
    <String, dynamic>{
      'searchFlightRequest': instance.searchFlightRequest,
      'searchFlightResponse': instance.searchFlightResponse,
      'orderID': instance.orderID,
      'success': instance.success,
    };

SearchFlightResponse _$SearchFlightResponseFromJson(
        Map<String, dynamic> json) =>
    SearchFlightResponse(
      errors: json['errors'] as List<dynamic>?,
      flightResult: json['flightResult'] == null
          ? null
          : FlightResult.fromJson(json['flightResult'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchFlightResponseToJson(
        SearchFlightResponse instance) =>
    <String, dynamic>{
      'errors': instance.errors,
      'flightResult': instance.flightResult,
    };

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
    );

Map<String, dynamic> _$FlightResultToJson(FlightResult instance) =>
    <String, dynamic>{
      'inboundSegment': instance.inboundSegment,
      'outboundSegment': instance.outboundSegment,
      'commissionIncluded': instance.commissionIncluded,
      'legDetails': instance.legDetails,
      'requestReservationChannel': instance.requestReservationChannel,
      'requestedCorporationID': instance.requestedCorporationID,
      'requestedCurrencyOfFareQuote': instance.requestedCurrencyOfFareQuote,
      'requestedFareFilterMethod': instance.requestedFareFilterMethod,
      'requestedGroupMethod': instance.requestedGroupMethod,
      'requestedIataNumber': instance.requestedIataNumber,
      'requestedInventoryFilterMethod': instance.requestedInventoryFilterMethod,
      'taxDetails': instance.taxDetails,
    };

InboundOutboundSegment _$InboundOutboundSegmentFromJson(
        Map<String, dynamic> json) =>
    InboundOutboundSegment(
      segmentDetail: json['segmentDetail'] == null
          ? null
          : SegmentDetail.fromJson(
              json['segmentDetail'] as Map<String, dynamic>),
      minInboundTotalPrice: json['minInboundTotalPrice'] as num?,
      totalSegmentFareAmt: json['totalSegmentFareAmt'] as num?,
      adultPricePerPax: json['adultPricePerPax'] as num?,
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
    );

Map<String, dynamic> _$InboundOutboundSegmentToJson(
        InboundOutboundSegment instance) =>
    <String, dynamic>{
      'segmentDetail': instance.segmentDetail,
      'minInboundTotalPrice': instance.minInboundTotalPrice,
      'totalSegmentFareAmt': instance.totalSegmentFareAmt,
      'adultPricePerPax': instance.adultPricePerPax,
      'adultPriceTotal': instance.adultPriceTotal,
      'childPricePerPax': instance.childPricePerPax,
      'childPriceTotal': instance.childPriceTotal,
      'infantPricePerPax': instance.infantPricePerPax,
      'infantPriceTotal': instance.infantPriceTotal,
      'fareTypeWithTaxDetails': instance.fareTypeWithTaxDetails,
      'lfid': instance.lfid,
      'departureDate': instance.departureDate?.toIso8601String(),
      'arrivalDate': instance.arrivalDate?.toIso8601String(),
      'legCount': instance.legCount,
      'international': instance.international,
      'flightLegDetails': instance.flightLegDetails,
    };

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

Map<String, dynamic> _$SegmentDetailToJson(SegmentDetail instance) =>
    <String, dynamic>{
      'lfid': instance.lfid,
      'origin': instance.origin,
      'destination': instance.destination,
      'departureDate': instance.departureDate?.toIso8601String(),
      'carrierCode': instance.carrierCode,
      'arrivalDate': instance.arrivalDate?.toIso8601String(),
      'stops': instance.stops,
      'flightTime': instance.flightTime,
      'aircraftType': instance.aircraftType,
      'sellingCarrier': instance.sellingCarrier,
      'flightNum': instance.flightNum,
      'operatingCarrier': instance.operatingCarrier,
      'operatingFlightNum': instance.operatingFlightNum,
      'flyMonday': instance.flyMonday,
      'flyTuesday': instance.flyTuesday,
      'flyWednesday': instance.flyWednesday,
      'flyThursday': instance.flyThursday,
      'flyFriday': instance.flyFriday,
      'flySaturday': instance.flySaturday,
      'flySunday': instance.flySunday,
      'aircraftDescription': instance.aircraftDescription,
      'deiDisclosure': instance.deiDisclosure,
    };

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
        FareTypeWithTaxDetails instance) =>
    <String, dynamic>{
      'fareInfoWithTaxDetails': instance.fareInfoWithTaxDetails,
      'fareTypeID': instance.fareTypeID,
      'fareTypeName': instance.fareTypeName,
      'filterRemove': instance.filterRemove,
    };

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
        FareInfoWithTaxDetails instance) =>
    <String, dynamic>{
      'applicationTaxDetailBinds': instance.applicationTaxDetailBinds,
      'returnFlightSegmentDetails': instance.returnFlightSegmentDetails,
      'fareID': instance.fareID,
      'fcCode': instance.fcCode,
      'fbCode': instance.fbCode,
      'baseFareAmtNoTaxes': instance.baseFareAmtNoTaxes,
      'baseFareAmt': instance.baseFareAmt,
      'fareAmtNoTaxes': instance.fareAmtNoTaxes,
      'fareAmt': instance.fareAmt,
      'baseFareAmtInclTax': instance.baseFareAmtInclTax,
      'fareAmtInclTax': instance.fareAmtInclTax,
      'pvtFare': instance.pvtFare,
      'ptcid': instance.ptcid,
      'cabin': instance.cabin,
      'seatsAvailable': instance.seatsAvailable,
      'infantSeatsAvailable': instance.infantSeatsAvailable,
      'fareScheduleID': instance.fareScheduleID,
      'promotionID': instance.promotionID,
      'roundTrip': instance.roundTrip,
      'displayFareAmt': instance.displayFareAmt,
      'displayTaxSum': instance.displayTaxSum,
      'specialMarketed': instance.specialMarketed,
      'waitList': instance.waitList,
      'spaceAvailable': instance.spaceAvailable,
      'positiveSpace': instance.positiveSpace,
      'promotionCatID': instance.promotionCatID,
      'commissionAmount': instance.commissionAmount,
      'promotionAmount': instance.promotionAmount,
      'bundleCode': instance.bundleCode,
      'originalCurrency': instance.originalCurrency,
      'exchangeRate': instance.exchangeRate,
      'exchangeDate': instance.exchangeDate?.toIso8601String(),
    };

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
        ApplicationTaxDetailBinds instance) =>
    <String, dynamic>{
      'taxDetail': instance.taxDetail,
      'taxID': instance.taxID,
      'amt': instance.amt,
      'initiatingTaxID': instance.initiatingTaxID,
      'commissionAmount': instance.commissionAmount,
    };

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

Map<String, dynamic> _$TaxDetailToJson(TaxDetail instance) => <String, dynamic>{
      'taxID': instance.taxID,
      'taxCode': instance.taxCode,
      'codeType': instance.codeType,
      'taxCurr': instance.taxCurr,
      'taxDesc': instance.taxDesc,
      'taxType': instance.taxType,
      'isVat': instance.isVat,
      'includedInFare': instance.includedInFare,
      'originalCurrency': instance.originalCurrency,
      'exchangeRate': instance.exchangeRate,
      'exchangeDate': instance.exchangeDate?.toIso8601String(),
      'commissionable': instance.commissionable,
    };

FlightLegDetails _$FlightLegDetailsFromJson(Map<String, dynamic> json) =>
    FlightLegDetails(
      pfid: json['pfid'] as num?,
      departureDate: json['departureDate'] == null
          ? null
          : DateTime.parse(json['departureDate'] as String),
    );

Map<String, dynamic> _$FlightLegDetailsToJson(FlightLegDetails instance) =>
    <String, dynamic>{
      'pfid': instance.pfid,
      'departureDate': instance.departureDate?.toIso8601String(),
    };

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

Map<String, dynamic> _$LegDetailsToJson(LegDetails instance) =>
    <String, dynamic>{
      'pfid': instance.pfid,
      'departureDate': instance.departureDate?.toIso8601String(),
      'origin': instance.origin,
      'destination': instance.destination,
      'flightNum': instance.flightNum,
      'international': instance.international,
      'arrivalDate': instance.arrivalDate?.toIso8601String(),
      'flightTime': instance.flightTime,
      'operatingCarrier': instance.operatingCarrier,
      'fromTerminal': instance.fromTerminal,
      'toTerminal': instance.toTerminal,
      'aircraftType': instance.aircraftType,
      'aircraftDescription': instance.aircraftDescription,
      'deiDisclosure': instance.deiDisclosure,
      'aircraftLayoutName': instance.aircraftLayoutName,
      'serviceType': instance.serviceType,
    };
