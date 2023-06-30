// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyResponse _$VerifyResponseFromJson(Map<String, dynamic> json) =>
    VerifyResponse(
      flightVerifyRequest: json['flightVerifyRequest'] == null
          ? null
          : CommonFlightRequest.fromJson(
              json['flightVerifyRequest'] as Map<String, dynamic>),
      flightVerifyResponse: json['flightVerifyResponse'] == null
          ? null
          : FlightVerifyResponse.fromJson(
              json['flightVerifyResponse'] as Map<String, dynamic>),
      flightSummaryPNRRequest: json['flightSummaryPNRRequest'] == null
          ? null
          : FlightSummaryPnrRequest.fromJson(
              json['flightSummaryPNRRequest'] as Map<String, dynamic>),
      flightSSR: json['flightSSR'] == null
          ? null
          : FlightSSR.fromJson(json['flightSSR'] as Map<String, dynamic>),
      flightSeat: json['flightSeat'] == null
          ? null
          : FlightSeats.fromJson(json['flightSeat'] as Map<String, dynamic>),
      orderID: json['orderID'] as num?,
      success: json['success'] as bool?,
      token: json['token'] as String?,
      verifyExpiredDateTime: json['verifyExpiredDateTime'] == null
          ? null
          : DateTime.parse(json['verifyExpiredDateTime'] as String),
    );

Map<String, dynamic> _$VerifyResponseToJson(VerifyResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('flightVerifyRequest', instance.flightVerifyRequest);
  writeNotNull('flightVerifyResponse', instance.flightVerifyResponse);
  writeNotNull('flightSSR', instance.flightSSR);
  writeNotNull('flightSeat', instance.flightSeat);
  writeNotNull('flightSummaryPNRRequest', instance.flightSummaryPNRRequest);
  writeNotNull('orderID', instance.orderID);
  writeNotNull('success', instance.success);
  writeNotNull('token', instance.token);
  writeNotNull('verifyExpiredDateTime',
      instance.verifyExpiredDateTime?.toIso8601String());
  return val;
}

FlightVerifyRequest _$FlightVerifyRequestFromJson(Map<String, dynamic> json) =>
    FlightVerifyRequest(
      originAirport: json['originAirport'] as String?,
      destinationAirport: json['destinationAirport'] as String?,
      departDate: json['departDate'] as String?,
      returnDate: json['returnDate'] as String?,
      adults: json['adults'] as num?,
      childrens: json['childrens'] as num?,
      infants: json['infants'] as num?,
      isReturn: json['isReturn'] as bool?,
      currency: json['currency'] as String?,
      totalAmount: json['totalAmount'] as num?,
      outboundLFID: (json['outboundLFID'] as List<dynamic>?)
          ?.map((e) => e as num)
          .toList(),
      inboundLFID: (json['inboundLFID'] as List<dynamic>?)
          ?.map((e) => e as num)
          .toList(),
    );

Map<String, dynamic> _$FlightVerifyRequestToJson(FlightVerifyRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('originAirport', instance.originAirport);
  writeNotNull('destinationAirport', instance.destinationAirport);
  writeNotNull('departDate', instance.departDate);
  writeNotNull('returnDate', instance.returnDate);
  writeNotNull('adults', instance.adults);
  writeNotNull('childrens', instance.childrens);
  writeNotNull('infants', instance.infants);
  writeNotNull('isReturn', instance.isReturn);
  writeNotNull('currency', instance.currency);
  writeNotNull('totalAmount', instance.totalAmount);
  writeNotNull('outboundLFID', instance.outboundLFID);
  writeNotNull('inboundLFID', instance.inboundLFID);
  return val;
}

FlightVerifyResponse _$FlightVerifyResponseFromJson(
        Map<String, dynamic> json) =>
    FlightVerifyResponse(
      errors: json['errors'] as List<dynamic>?,
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      session: json['session'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$FlightVerifyResponseToJson(
    FlightVerifyResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('errors', instance.errors);
  writeNotNull('result', instance.result);
  writeNotNull('session', instance.session);
  writeNotNull('success', instance.success);
  return val;
}

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      commissionIncluded: json['commissionIncluded'] as bool?,
      flightSegments: (json['flightSegments'] as List<dynamic>?)
          ?.map((e) => FlightSegments.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      segmentDetails: (json['segmentDetails'] as List<dynamic>?)
          ?.map((e) => SegmentDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      taxDetails: (json['taxDetails'] as List<dynamic>?)
          ?.map((e) => TaxDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultToJson(Result instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('commissionIncluded', instance.commissionIncluded);
  writeNotNull('flightSegments', instance.flightSegments);
  writeNotNull('legDetails', instance.legDetails);
  writeNotNull('requestReservationChannel', instance.requestReservationChannel);
  writeNotNull('requestedCorporationID', instance.requestedCorporationID);
  writeNotNull(
      'requestedCurrencyOfFareQuote', instance.requestedCurrencyOfFareQuote);
  writeNotNull('requestedFareFilterMethod', instance.requestedFareFilterMethod);
  writeNotNull('requestedGroupMethod', instance.requestedGroupMethod);
  writeNotNull('requestedIataNumber', instance.requestedIataNumber);
  writeNotNull('requestedInventoryFilterMethod',
      instance.requestedInventoryFilterMethod);
  writeNotNull('segmentDetails', instance.segmentDetails);
  writeNotNull('taxDetails', instance.taxDetails);
  return val;
}

FlightSegments _$FlightSegmentsFromJson(Map<String, dynamic> json) =>
    FlightSegments(
      lfid: json['lfid'] as num?,
      departureDate: json['departureDate'] as String?,
      arrivalDate: json['arrivalDate'] as String?,
      legCount: json['legCount'] as num?,
      numernational: json['numernational'] as bool?,
      fareTypes: (json['fareTypes'] as List<dynamic>?)
          ?.map((e) => FareTypes.fromJson(e as Map<String, dynamic>))
          .toList(),
      flightLegDetails: (json['flightLegDetails'] as List<dynamic>?)
          ?.map((e) => FlightLegDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FlightSegmentsToJson(FlightSegments instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('lfid', instance.lfid);
  writeNotNull('departureDate', instance.departureDate);
  writeNotNull('arrivalDate', instance.arrivalDate);
  writeNotNull('legCount', instance.legCount);
  writeNotNull('numernational', instance.numernational);
  writeNotNull('fareTypes', instance.fareTypes);
  writeNotNull('flightLegDetails', instance.flightLegDetails);
  return val;
}

FareTypes _$FareTypesFromJson(Map<String, dynamic> json) => FareTypes(
      fareTypeID: json['fareTypeID'] as num?,
      fareTypeName: json['fareTypeName'] as String?,
      filterRemove: json['filterRemove'] as bool?,
      fareInfos: (json['fareInfos'] as List<dynamic>?)
          ?.map((e) => FareInfos.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FareTypesToJson(FareTypes instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fareTypeID', instance.fareTypeID);
  writeNotNull('fareTypeName', instance.fareTypeName);
  writeNotNull('filterRemove', instance.filterRemove);
  writeNotNull('fareInfos', instance.fareInfos);
  return val;
}

FareInfos _$FareInfosFromJson(Map<String, dynamic> json) => FareInfos(
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
      applicableTaxDetails: (json['applicableTaxDetails'] as List<dynamic>?)
          ?.map((e) => ApplicableTaxDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      bundleCode: json['bundleCode'] as String?,
      originalCurrency: json['originalCurrency'] as String?,
      exchangeRate: json['exchangeRate'] as num?,
      exchangeDate: json['exchangeDate'] as String?,
    );

Map<String, dynamic> _$FareInfosToJson(FareInfos instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

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
  writeNotNull('applicableTaxDetails', instance.applicableTaxDetails);
  writeNotNull('bundleCode', instance.bundleCode);
  writeNotNull('originalCurrency', instance.originalCurrency);
  writeNotNull('exchangeRate', instance.exchangeRate);
  writeNotNull('exchangeDate', instance.exchangeDate);
  return val;
}

ApplicableTaxDetails _$ApplicableTaxDetailsFromJson(
        Map<String, dynamic> json) =>
    ApplicableTaxDetails(
      taxID: json['taxID'] as num?,
      amt: json['amt'] as num?,
      initiatingTaxID: json['initiatingTaxID'] as num?,
      commissionAmount: json['commissionAmount'] as num?,
    );

Map<String, dynamic> _$ApplicableTaxDetailsToJson(
    ApplicableTaxDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('taxID', instance.taxID);
  writeNotNull('amt', instance.amt);
  writeNotNull('initiatingTaxID', instance.initiatingTaxID);
  writeNotNull('commissionAmount', instance.commissionAmount);
  return val;
}

FlightLegDetails _$FlightLegDetailsFromJson(Map<String, dynamic> json) =>
    FlightLegDetails(
      pfid: json['pfid'],
      departureDate: json['departureDate'] as String?,
    );

Map<String, dynamic> _$FlightLegDetailsToJson(FlightLegDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('pfid', instance.pfid);
  writeNotNull('departureDate', instance.departureDate);
  return val;
}

LegDetails _$LegDetailsFromJson(Map<String, dynamic> json) => LegDetails(
      pfid: json['pfid'],
      departureDate: json['departureDate'] as String?,
      origin: json['origin'] as String?,
      destination: json['destination'] as String?,
      flightNum: json['flightNum'] as String?,
      numernational: json['numernational'] as bool?,
      arrivalDate: json['arrivalDate'] as String?,
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
  writeNotNull('departureDate', instance.departureDate);
  writeNotNull('origin', instance.origin);
  writeNotNull('destination', instance.destination);
  writeNotNull('flightNum', instance.flightNum);
  writeNotNull('numernational', instance.numernational);
  writeNotNull('arrivalDate', instance.arrivalDate);
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

TaxDetails _$TaxDetailsFromJson(Map<String, dynamic> json) => TaxDetails(
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
      exchangeDate: json['exchangeDate'] as String?,
      commissionable: json['commissionable'] as bool?,
    );

Map<String, dynamic> _$TaxDetailsToJson(TaxDetails instance) {
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
  writeNotNull('exchangeDate', instance.exchangeDate);
  writeNotNull('commissionable', instance.commissionable);
  return val;
}

FlightSSR _$FlightSSRFromJson(Map<String, dynamic> json) => FlightSSR(
      bundleGroup: json['bundleGroup'] == null
          ? null
          : BundleGroup.fromJson(json['bundleGroup'] as Map<String, dynamic>),
      mealGroup: json['mealGroup'] == null
          ? null
          : BundleGroupSeat.fromJson(json['mealGroup'] as Map<String, dynamic>),
      baggageGroup: json['baggageGroup'] == null
          ? null
          : BaggageGroup.fromJson(json['baggageGroup'] as Map<String, dynamic>),
      seatGroup: json['seatGroup'] == null
          ? null
          : BundleGroupSeat.fromJson(json['seatGroup'] as Map<String, dynamic>),
      infantGroup: json['infantGroup'] == null
          ? null
          : BundleGroupSeat.fromJson(
              json['infantGroup'] as Map<String, dynamic>),
      wheelChairGroup: json['wheelChairGroup'] == null
          ? null
          : BundleGroupSeat.fromJson(
              json['wheelChairGroup'] as Map<String, dynamic>),
      sportGroup: json['sportGroup'] == null
          ? null
          : BundleGroupSeat.fromJson(
              json['sportGroup'] as Map<String, dynamic>),
      insuranceGroup: json['insuranceGroup'] == null
          ? null
          : BundleGroupSeat.fromJson(
              json['insuranceGroup'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FlightSSRToJson(FlightSSR instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bundleGroup', instance.bundleGroup);
  writeNotNull('mealGroup', instance.mealGroup);
  writeNotNull('baggageGroup', instance.baggageGroup);
  writeNotNull('seatGroup', instance.seatGroup);
  writeNotNull('infantGroup', instance.infantGroup);
  writeNotNull('wheelChairGroup', instance.wheelChairGroup);
  writeNotNull('sportGroup', instance.sportGroup);
  writeNotNull('insuranceGroup', instance.insuranceGroup);
  return val;
}

BundleGroup _$BundleGroupFromJson(Map<String, dynamic> json) => BundleGroup(
      inbound: (json['inbound'] as List<dynamic>?)
          ?.map((e) => InboundBundle.fromJson(e as Map<String, dynamic>))
          .toList(),
      outbound: (json['outbound'] as List<dynamic>?)
          ?.map((e) => InboundBundle.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BundleGroupToJson(BundleGroup instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('inbound', instance.inbound);
  writeNotNull('outbound', instance.outbound);
  return val;
}

BundleGroupSeat _$BundleGroupSeatFromJson(Map<String, dynamic> json) =>
    BundleGroupSeat(
      inbound: (json['inbound'] as List<dynamic>?)
          ?.map((e) => Bundle.fromJson(e as Map<String, dynamic>))
          .toList(),
      outbound: (json['outbound'] as List<dynamic>?)
          ?.map((e) => Bundle.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BundleGroupSeatToJson(BundleGroupSeat instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('inbound', instance.inbound);
  writeNotNull('outbound', instance.outbound);
  return val;
}

InboundBundle _$InboundBundleFromJson(Map<String, dynamic> json) =>
    InboundBundle(
      bundle: json['bundle'] == null
          ? null
          : Bundle.fromJson(json['bundle'] as Map<String, dynamic>),
      detail: json['detail'] == null
          ? null
          : Detail.fromJson(json['detail'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InboundBundleToJson(InboundBundle instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bundle', instance.bundle);
  writeNotNull('detail', instance.detail);
  return val;
}

Bundle _$BundleFromJson(Map<String, dynamic> json) => Bundle(
      logicalFlightID: json['logicalFlightID'] as String?,
      serviceID: json['serviceID'] as num?,
      departureDate: json['departureDate'] as String?,
      operatingCarrier: json['operatingCarrier'] as String?,
      marketingCarrier: json['marketingCarrier'] as String?,
      codeType: json['codeType'] as String?,
      description: json['description'] as String?,
      currencyCode: json['currencyCode'] as String?,
      amount: json['amount'] as num?,
      amountActive: json['amountActive'] as bool?,
      categoryID: json['categoryID'] as num?,
      ssrCode: json['ssrCode'] as String?,
      display: json['display'] as bool?,
      maxCountServiceLevel: json['maxCountServiceLevel'] as num?,
      refundable: json['refundable'] as bool?,
      pnlActive: json['pnlActive'] as bool?,
      cutoffHours: json['cutoffHours'] as num?,
      commissionable: json['commissionable'] as bool?,
      displayOrder: json['displayOrder'] as num?,
      revenueCategoryID: json['revenueCategoryID'] as num?,
      iataStandardCodeType: json['iataStandardCodeType'] as String?,
      serviceActive: json['serviceActive'] as bool?,
      maxCountFlightLevel: json['maxCountFlightLevel'] as num?,
      quantityAvailable: json['quantityAvailable'] as num?,
      startSalesDays: json['startSalesDays'] as num?,
      applicableTaxes: (json['applicableTaxes'] as List<dynamic>?)
          ?.map((e) => ApplicableTaxes.fromJson(e as Map<String, dynamic>))
          .toList(),
      boardingPassSsrOrder: json['boardingPassSsrOrder'] as num?,
      serviceType: json['serviceType'] as num?,
    );

Map<String, dynamic> _$BundleToJson(Bundle instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('logicalFlightID', instance.logicalFlightID);
  writeNotNull('serviceID', instance.serviceID);
  writeNotNull('departureDate', instance.departureDate);
  writeNotNull('operatingCarrier', instance.operatingCarrier);
  writeNotNull('marketingCarrier', instance.marketingCarrier);
  writeNotNull('codeType', instance.codeType);
  writeNotNull('description', instance.description);
  writeNotNull('currencyCode', instance.currencyCode);
  writeNotNull('amount', instance.amount);
  writeNotNull('amountActive', instance.amountActive);
  writeNotNull('categoryID', instance.categoryID);
  writeNotNull('ssrCode', instance.ssrCode);
  writeNotNull('display', instance.display);
  writeNotNull('maxCountServiceLevel', instance.maxCountServiceLevel);
  writeNotNull('refundable', instance.refundable);
  writeNotNull('pnlActive', instance.pnlActive);
  writeNotNull('cutoffHours', instance.cutoffHours);
  writeNotNull('commissionable', instance.commissionable);
  writeNotNull('displayOrder', instance.displayOrder);
  writeNotNull('revenueCategoryID', instance.revenueCategoryID);
  writeNotNull('iataStandardCodeType', instance.iataStandardCodeType);
  writeNotNull('serviceActive', instance.serviceActive);
  writeNotNull('maxCountFlightLevel', instance.maxCountFlightLevel);
  writeNotNull('quantityAvailable', instance.quantityAvailable);
  writeNotNull('startSalesDays', instance.startSalesDays);
  writeNotNull('applicableTaxes', instance.applicableTaxes);
  writeNotNull('boardingPassSsrOrder', instance.boardingPassSsrOrder);
  writeNotNull('serviceType', instance.serviceType);
  return val;
}

Detail _$DetailFromJson(Map<String, dynamic> json) => Detail(
      bundleDescription: json['bundleDescription'] as String?,
      bundleGlCode: json['bundleGlCode'] as String?,
      bundleIataStdCodeType: json['bundleIataStdCodeType'] as String?,
      bundleId: json['bundleId'] as num?,
      bundleIsMaxinventory: json['bundleIsMaxinventory'] as bool?,
      bundleServiceDetails: (json['bundleServiceDetails'] as List<dynamic>?)
          ?.map((e) => BundleServiceDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      bundleType: json['bundleType'] as num?,
      exceptions: json['exceptions'] as List<dynamic>?,
      serviceBundleCode: json['serviceBundleCode'] as String?,
      version: json['version'] as String?,
    );

Map<String, dynamic> _$DetailToJson(Detail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bundleDescription', instance.bundleDescription);
  writeNotNull('bundleGlCode', instance.bundleGlCode);
  writeNotNull('bundleIataStdCodeType', instance.bundleIataStdCodeType);
  writeNotNull('bundleId', instance.bundleId);
  writeNotNull('bundleIsMaxinventory', instance.bundleIsMaxinventory);
  writeNotNull('bundleServiceDetails', instance.bundleServiceDetails);
  writeNotNull('bundleType', instance.bundleType);
  writeNotNull('exceptions', instance.exceptions);
  writeNotNull('serviceBundleCode', instance.serviceBundleCode);
  writeNotNull('version', instance.version);
  return val;
}

BundleServiceDetails _$BundleServiceDetailsFromJson(
        Map<String, dynamic> json) =>
    BundleServiceDetails(
      bundleGroupIndex: json['bundleGroupIndex'] as num?,
      bundleQtyGroupIndex: json['bundleQtyGroupIndex'] as num?,
      categoryID: json['categoryID'] as num?,
      description: json['description'] as String?,
      glCode: json['glCode'] as String?,
      isMaxinventory: json['isMaxinventory'] as bool?,
      serviceID: json['serviceID'] as num?,
      ssrCode: json['ssrCode'] as String?,
    );

Map<String, dynamic> _$BundleServiceDetailsToJson(
    BundleServiceDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bundleGroupIndex', instance.bundleGroupIndex);
  writeNotNull('bundleQtyGroupIndex', instance.bundleQtyGroupIndex);
  writeNotNull('categoryID', instance.categoryID);
  writeNotNull('description', instance.description);
  writeNotNull('glCode', instance.glCode);
  writeNotNull('isMaxinventory', instance.isMaxinventory);
  writeNotNull('serviceID', instance.serviceID);
  writeNotNull('ssrCode', instance.ssrCode);
  return val;
}

BaggageGroup _$BaggageGroupFromJson(Map<String, dynamic> json) => BaggageGroup(
      inbound: (json['inbound'] as List<dynamic>?)
          ?.map((e) => Bundle.fromJson(e as Map<String, dynamic>))
          .toList(),
      outbound: (json['outbound'] as List<dynamic>?)
          ?.map((e) => Bundle.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BaggageGroupToJson(BaggageGroup instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('inbound', instance.inbound);
  writeNotNull('outbound', instance.outbound);
  return val;
}

FlightSeats _$FlightSeatsFromJson(Map<String, dynamic> json) => FlightSeats(
      inbound: (json['inbound'] as List<dynamic>?)
          ?.map((e) => InboundSeat.fromJson(e as Map<String, dynamic>))
          .toList(),
      outbound: (json['outbound'] as List<dynamic>?)
          ?.map((e) => InboundSeat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FlightSeatsToJson(FlightSeats instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('inbound', instance.inbound);
  writeNotNull('outbound', instance.outbound);
  return val;
}

InboundSeat _$InboundSeatFromJson(Map<String, dynamic> json) => InboundSeat(
      segmentCount: json['segmentCount'] as num?,
      retrieveFlightSeatMapResponse: json['retrieveFlightSeatMapResponse'] ==
              null
          ? null
          : RetrieveFlightSeatMapResponse.fromJson(
              json['retrieveFlightSeatMapResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InboundSeatToJson(InboundSeat instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('segmentCount', instance.segmentCount);
  writeNotNull(
      'retrieveFlightSeatMapResponse', instance.retrieveFlightSeatMapResponse);
  return val;
}

RetrieveFlightSeatMapResponse _$RetrieveFlightSeatMapResponseFromJson(
        Map<String, dynamic> json) =>
    RetrieveFlightSeatMapResponse(
      physicalFlights: (json['physicalFlights'] as List<dynamic>?)
          ?.map((e) => PhysicalFlights.fromJson(e as Map<String, dynamic>))
          .toList(),
      rules: json['rules'] == null
          ? null
          : Rules.fromJson(json['rules'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RetrieveFlightSeatMapResponseToJson(
    RetrieveFlightSeatMapResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('physicalFlights', instance.physicalFlights);
  writeNotNull('rules', instance.rules);
  return val;
}

PhysicalFlights _$PhysicalFlightsFromJson(Map<String, dynamic> json) =>
    PhysicalFlights(
      departureDate: json['departureDate'] as String?,
      destination: json['destination'] as String?,
      destinationName: json['destinationName'] as String?,
      flightNum: json['flightNum'] as String?,
      origin: json['origin'] as String?,
      originName: json['originName'] as String?,
      physicalFlightID: json['physicalFlightID'] as String?,
      physicalFlightSeatMap: json['physicalFlightSeatMap'] == null
          ? null
          : PhysicalFlightSeatMap.fromJson(
              json['physicalFlightSeatMap'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PhysicalFlightsToJson(PhysicalFlights instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('departureDate', instance.departureDate);
  writeNotNull('destination', instance.destination);
  writeNotNull('destinationName', instance.destinationName);
  writeNotNull('flightNum', instance.flightNum);
  writeNotNull('origin', instance.origin);
  writeNotNull('originName', instance.originName);
  writeNotNull('physicalFlightID', instance.physicalFlightID);
  writeNotNull('physicalFlightSeatMap', instance.physicalFlightSeatMap);
  return val;
}

PhysicalFlightSeatMap _$PhysicalFlightSeatMapFromJson(
        Map<String, dynamic> json) =>
    PhysicalFlightSeatMap(
      cabinClasses: (json['cabinClasses'] as List<dynamic>?)
          ?.map((e) => CabinClasses.fromJson(e as Map<String, dynamic>))
          .toList(),
      decks: (json['decks'] as List<dynamic>?)
          ?.map((e) => Decks.fromJson(e as Map<String, dynamic>))
          .toList(),
      seatCabins: (json['seatCabins'] as List<dynamic>?)
          ?.map((e) => SeatCabins.fromJson(e as Map<String, dynamic>))
          .toList(),
      seatConfiguration: json['seatConfiguration'] == null
          ? null
          : SeatConfiguration.fromJson(
              json['seatConfiguration'] as Map<String, dynamic>),
      seatDescription: (json['seatDescription'] as List<dynamic>?)
          ?.map((e) => SeatDescription.fromJson(e as Map<String, dynamic>))
          .toList(),
      seatWBZones: (json['seatWBZones'] as List<dynamic>?)
          ?.map((e) => SeatWBZones.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PhysicalFlightSeatMapToJson(
    PhysicalFlightSeatMap instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('cabinClasses', instance.cabinClasses);
  writeNotNull('decks', instance.decks);
  writeNotNull('seatCabins', instance.seatCabins);
  writeNotNull('seatConfiguration', instance.seatConfiguration);
  writeNotNull('seatDescription', instance.seatDescription);
  writeNotNull('seatWBZones', instance.seatWBZones);
  return val;
}

CabinClasses _$CabinClassesFromJson(Map<String, dynamic> json) => CabinClasses(
      cabin: json['cabin'] as String?,
      cabinClass: json['cabinClass'] as String?,
      cabinClassId: json['cabinClassId'] as num?,
      cabinOrder: json['cabinOrder'] as num?,
    );

Map<String, dynamic> _$CabinClassesToJson(CabinClasses instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('cabin', instance.cabin);
  writeNotNull('cabinClass', instance.cabinClass);
  writeNotNull('cabinClassId', instance.cabinClassId);
  writeNotNull('cabinOrder', instance.cabinOrder);
  return val;
}

Decks _$DecksFromJson(Map<String, dynamic> json) => Decks(
      deckCode: json['deckCode'] as String?,
      deckId: json['deckId'] as num?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$DecksToJson(Decks instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('deckCode', instance.deckCode);
  writeNotNull('deckId', instance.deckId);
  writeNotNull('description', instance.description);
  return val;
}

SeatCabins _$SeatCabinsFromJson(Map<String, dynamic> json) => SeatCabins(
      cabinClassId: json['cabinClassId'] as num?,
      cabinDisplayOrder: json['cabinDisplayOrder'] as num?,
      capacity: json['capacity'] as num?,
      seatCabinId: json['seatCabinId'] as num?,
      seatConfigId: json['seatConfigId'] as num?,
    );

Map<String, dynamic> _$SeatCabinsToJson(SeatCabins instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('cabinClassId', instance.cabinClassId);
  writeNotNull('cabinDisplayOrder', instance.cabinDisplayOrder);
  writeNotNull('capacity', instance.capacity);
  writeNotNull('seatCabinId', instance.seatCabinId);
  writeNotNull('seatConfigId', instance.seatConfigId);
  return val;
}

SeatConfiguration _$SeatConfigurationFromJson(Map<String, dynamic> json) =>
    SeatConfiguration(
      carrier: json['carrier'] as String?,
      configurationDescription: json['configurationDescription'] as String?,
      configurationName: json['configurationName'] as String?,
      defaultKey: json['default'] as bool?,
      iataAcType: json['iataAcType'] as String?,
      layoutName: json['layoutName'] as String?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => Rows.fromJson(e as Map<String, dynamic>))
          .toList(),
      seatConfigurationId: json['seatConfigurationId'] as num?,
    );

Map<String, dynamic> _$SeatConfigurationToJson(SeatConfiguration instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('carrier', instance.carrier);
  writeNotNull('configurationDescription', instance.configurationDescription);
  writeNotNull('configurationName', instance.configurationName);
  writeNotNull('default', instance.defaultKey);
  writeNotNull('iataAcType', instance.iataAcType);
  writeNotNull('layoutName', instance.layoutName);
  writeNotNull('rows', instance.rows);
  writeNotNull('seatConfigurationId', instance.seatConfigurationId);
  return val;
}

Rows _$RowsFromJson(Map<String, dynamic> json) => Rows(
      deckId: json['deckId'] as num?,
      restrictions: json['restrictions'] as List<dynamic>?,
      rowId: json['rowId'] as num?,
      rowNumber: json['rowNumber'] as num?,
      seatConfigId: json['seatConfigId'] as num?,
      seats: (json['seats'] as List<dynamic>?)
          ?.map((e) => Seats.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RowsToJson(Rows instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('deckId', instance.deckId);
  writeNotNull('restrictions', instance.restrictions);
  writeNotNull('rowId', instance.rowId);
  writeNotNull('rowNumber', instance.rowNumber);
  writeNotNull('seatConfigId', instance.seatConfigId);
  writeNotNull('seats', instance.seats);
  return val;
}

Seats _$SeatsFromJson(Map<String, dynamic> json) => Seats(
      blockChild: json['blockChild'] as bool?,
      blockInfant: json['blockInfant'] as bool?,
      isEmergencyRow: json['isEmergencyRow'] as bool?,
      cabinClassId: json['cabinClassId'] as num?,
      isSeatAvailable: json['isSeatAvailable'] as bool?,
      restrictions: (json['restrictions'] as List<dynamic>?)
          ?.map((e) => Restrictions.fromJson(e as Map<String, dynamic>))
          .toList(),
      rowId: json['rowId'] as num?,
      seatAttributes: (json['seatAttributes'] as List<dynamic>?)
          ?.map((e) => SeatAttributes.fromJson(e as Map<String, dynamic>))
          .toList(),
      seatCabinId: json['seatCabinId'] as num?,
      seatColumn: json['seatColumn'] as String?,
      seatId: json['seatId'] as String?,
      seatOrder: json['seatOrder'] as num?,
      seatPriceOffers: (json['seatPriceOffers'] as List<dynamic>?)
          ?.map((e) => SeatPriceOffers.fromJson(e as Map<String, dynamic>))
          .toList(),
      seatWBZoneId: json['seatWBZoneId'] as num?,
      serviceCode: json['serviceCode'] as String?,
      serviceDescription: json['serviceDescription'] as String?,
      serviceId: json['serviceId'] as num?,
      weightIndex: json['weightIndex'] as num?,
    );

Map<String, dynamic> _$SeatsToJson(Seats instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('blockChild', instance.blockChild);
  writeNotNull('blockInfant', instance.blockInfant);
  writeNotNull('isEmergencyRow', instance.isEmergencyRow);
  writeNotNull('cabinClassId', instance.cabinClassId);
  writeNotNull('isSeatAvailable', instance.isSeatAvailable);
  writeNotNull('restrictions', instance.restrictions);
  writeNotNull('rowId', instance.rowId);
  writeNotNull('seatAttributes', instance.seatAttributes);
  writeNotNull('seatCabinId', instance.seatCabinId);
  writeNotNull('seatColumn', instance.seatColumn);
  writeNotNull('seatId', instance.seatId);
  writeNotNull('seatOrder', instance.seatOrder);
  writeNotNull('seatPriceOffers', instance.seatPriceOffers);
  writeNotNull('seatWBZoneId', instance.seatWBZoneId);
  writeNotNull('serviceCode', instance.serviceCode);
  writeNotNull('serviceDescription', instance.serviceDescription);
  writeNotNull('serviceId', instance.serviceId);
  writeNotNull('weightIndex', instance.weightIndex);
  return val;
}

Restrictions _$RestrictionsFromJson(Map<String, dynamic> json) => Restrictions(
      restrictionActive: json['restrictionActive'] as bool?,
      restrictionCategory: json['restrictionCategory'] as String?,
      restrictionComment: json['restrictionComment'] as String?,
      restrictionId: json['restrictionId'] as num?,
      restrictionItemId: json['restrictionItemId'] as num?,
      restrictionItemType: json['restrictionItemType'] as num?,
      restrictionNumber: json['restrictionNumber'] as num?,
      restrictionType: json['restrictionType'] as String?,
    );

Map<String, dynamic> _$RestrictionsToJson(Restrictions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('restrictionActive', instance.restrictionActive);
  writeNotNull('restrictionCategory', instance.restrictionCategory);
  writeNotNull('restrictionComment', instance.restrictionComment);
  writeNotNull('restrictionId', instance.restrictionId);
  writeNotNull('restrictionItemId', instance.restrictionItemId);
  writeNotNull('restrictionItemType', instance.restrictionItemType);
  writeNotNull('restrictionNumber', instance.restrictionNumber);
  writeNotNull('restrictionType', instance.restrictionType);
  return val;
}

SeatAttributes _$SeatAttributesFromJson(Map<String, dynamic> json) =>
    SeatAttributes(
      active: json['active'] as bool?,
      allowSeating: json['allowSeating'] as bool?,
      attributeCode: json['attributeCode'] as String?,
      attributeDescription: json['attributeDescription'] as String?,
      attributeId: json['attributeId'] as num?,
      attributeOrder: json['attributeOrder'] as num?,
      isCommercial: json['isCommercial'] as bool?,
      isMarketing: json['isMarketing'] as bool?,
      isOperational: json['isOperational'] as bool?,
      systemAttribute: json['systemAttribute'] as bool?,
    );

Map<String, dynamic> _$SeatAttributesToJson(SeatAttributes instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('active', instance.active);
  writeNotNull('allowSeating', instance.allowSeating);
  writeNotNull('attributeCode', instance.attributeCode);
  writeNotNull('attributeDescription', instance.attributeDescription);
  writeNotNull('attributeId', instance.attributeId);
  writeNotNull('attributeOrder', instance.attributeOrder);
  writeNotNull('isCommercial', instance.isCommercial);
  writeNotNull('isMarketing', instance.isMarketing);
  writeNotNull('isOperational', instance.isOperational);
  writeNotNull('systemAttribute', instance.systemAttribute);
  return val;
}

SeatPriceOffers _$SeatPriceOffersFromJson(Map<String, dynamic> json) =>
    SeatPriceOffers(
      amount: json['amount'] as num?,
      currency: json['currency'] as String?,
      isBundleOffer: json['isBundleOffer'] as bool?,
    );

Map<String, dynamic> _$SeatPriceOffersToJson(SeatPriceOffers instance) {
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

SeatDescription _$SeatDescriptionFromJson(Map<String, dynamic> json) =>
    SeatDescription(
      price: json['price'] as num?,
      seatWBZoneId: json['seatWBZoneId'] as num?,
      serviceDescription: json['serviceDescription'] as String?,
    );

Map<String, dynamic> _$SeatDescriptionToJson(SeatDescription instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('price', instance.price);
  writeNotNull('seatWBZoneId', instance.seatWBZoneId);
  writeNotNull('serviceDescription', instance.serviceDescription);
  return val;
}

SeatWBZones _$SeatWBZonesFromJson(Map<String, dynamic> json) => SeatWBZones(
      active: json['active'] as bool?,
      autoSeatPriority: json['autoSeatPriority'] as num?,
      seatConfigId: json['seatConfigId'] as num?,
      seatWBZoneId: json['seatWBZoneId'] as num?,
      wbZone: json['wbZone'] as String?,
      zoneReferenced: json['zoneReferenced'] as bool?,
    );

Map<String, dynamic> _$SeatWBZonesToJson(SeatWBZones instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('active', instance.active);
  writeNotNull('autoSeatPriority', instance.autoSeatPriority);
  writeNotNull('seatConfigId', instance.seatConfigId);
  writeNotNull('seatWBZoneId', instance.seatWBZoneId);
  writeNotNull('wbZone', instance.wbZone);
  writeNotNull('zoneReferenced', instance.zoneReferenced);
  return val;
}

Rules _$RulesFromJson(Map<String, dynamic> json) => Rules(
      exrpar: json['exrpar'] == null
          ? null
          : Exrpar.fromJson(json['exrpar'] as Map<String, dynamic>),
      exrptc: json['exrptc'] == null
          ? null
          : Exrptc.fromJson(json['exrptc'] as Map<String, dynamic>),
      exrrsr: json['exrrsr'] == null
          ? null
          : Exrrsr.fromJson(json['exrrsr'] as Map<String, dynamic>),
      miapsr: json['miapsr'] == null
          ? null
          : Miapsr.fromJson(json['miapsr'] as Map<String, dynamic>),
      seataj: json['seataj'] == null
          ? null
          : Seataj.fromJson(json['seataj'] as Map<String, dynamic>),
      seatgt: json['seatgt'] == null
          ? null
          : Seataj.fromJson(json['seatgt'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RulesToJson(Rules instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('exrpar', instance.exrpar);
  writeNotNull('exrptc', instance.exrptc);
  writeNotNull('exrrsr', instance.exrrsr);
  writeNotNull('miapsr', instance.miapsr);
  writeNotNull('seataj', instance.seataj);
  writeNotNull('seatgt', instance.seatgt);
  return val;
}

Exrpar _$ExrparFromJson(Map<String, dynamic> json) => Exrpar(
      ageEndRange: json['ageEndRange'] as num?,
      ageStartRange: json['ageStartRange'] as num?,
      description: json['description'] as String?,
      reasonCode: json['reasonCode'] as String?,
      ruleCode: json['ruleCode'] as String?,
    );

Map<String, dynamic> _$ExrparToJson(Exrpar instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ageEndRange', instance.ageEndRange);
  writeNotNull('ageStartRange', instance.ageStartRange);
  writeNotNull('description', instance.description);
  writeNotNull('reasonCode', instance.reasonCode);
  writeNotNull('ruleCode', instance.ruleCode);
  return val;
}

Exrptc _$ExrptcFromJson(Map<String, dynamic> json) => Exrptc(
      ptcIds:
          (json['ptcIds'] as List<dynamic>?)?.map((e) => e as String).toList(),
      description: json['description'] as String?,
      reasonCode: json['reasonCode'] as String?,
      ruleCode: json['ruleCode'] as String?,
    );

Map<String, dynamic> _$ExrptcToJson(Exrptc instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ptcIds', instance.ptcIds);
  writeNotNull('description', instance.description);
  writeNotNull('reasonCode', instance.reasonCode);
  writeNotNull('ruleCode', instance.ruleCode);
  return val;
}

Exrrsr _$ExrrsrFromJson(Map<String, dynamic> json) => Exrrsr(
      ssrs: (json['ssrs'] as List<dynamic>?)?.map((e) => e as String).toList(),
      description: json['description'] as String?,
      reasonCode: json['reasonCode'] as String?,
      ruleCode: json['ruleCode'] as String?,
    );

Map<String, dynamic> _$ExrrsrToJson(Exrrsr instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ssrs', instance.ssrs);
  writeNotNull('description', instance.description);
  writeNotNull('reasonCode', instance.reasonCode);
  writeNotNull('ruleCode', instance.ruleCode);
  return val;
}

Miapsr _$MiapsrFromJson(Map<String, dynamic> json) => Miapsr(
      maxInfantAllowedPerRow: json['maxInfantAllowedPerRow'] as num?,
      description: json['description'] as String?,
      reasonCode: json['reasonCode'] as String?,
      ruleCode: json['ruleCode'] as String?,
    );

Map<String, dynamic> _$MiapsrToJson(Miapsr instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('maxInfantAllowedPerRow', instance.maxInfantAllowedPerRow);
  writeNotNull('description', instance.description);
  writeNotNull('reasonCode', instance.reasonCode);
  writeNotNull('ruleCode', instance.ruleCode);
  return val;
}

Seataj _$SeatajFromJson(Map<String, dynamic> json) => Seataj(
      dependents: json['dependents'] as List<dynamic>?,
      linkedPtcs: json['linkedPtcs'] as List<dynamic>?,
      description: json['description'] as String?,
      reasonCode: json['reasonCode'] as String?,
      ruleCode: json['ruleCode'] as String?,
    );

Map<String, dynamic> _$SeatajToJson(Seataj instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dependents', instance.dependents);
  writeNotNull('linkedPtcs', instance.linkedPtcs);
  writeNotNull('description', instance.description);
  writeNotNull('reasonCode', instance.reasonCode);
  writeNotNull('ruleCode', instance.ruleCode);
  return val;
}
