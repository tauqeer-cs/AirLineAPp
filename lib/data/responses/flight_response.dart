import 'package:app/data/requests/search_flight_request.dart';
import 'package:app/models/number_person.dart';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flight_response.g.dart';

@JsonSerializable()
class FlightResponse extends Equatable {
  final CommonFlightRequest? searchFlightRequest;
  final SearchFlightResponse? searchFlightResponse;
  final num? orderID;
  final bool? success;

  const FlightResponse(
      {this.searchFlightRequest,
      this.searchFlightResponse,
      this.orderID,
      this.success});

  factory FlightResponse.fromJson(Map<String, dynamic> json) =>
      _$FlightResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FlightResponseToJson(this);

  @override
  List<Object?> get props =>
      [searchFlightRequest, searchFlightResponse, orderID, success];
}

@JsonSerializable()
class SearchFlightResponse extends Equatable {
  @override
  List<Object?> get props => [flightResult];

  final List<dynamic>? errors;
  final FlightResult? flightResult;

  const SearchFlightResponse({this.errors, this.flightResult});

  factory SearchFlightResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchFlightResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchFlightResponseToJson(this);
}

@JsonSerializable()
class FlightResult extends Equatable {
  @override
  List<Object?> get props => [
        inboundSegment,
        outboundSegment,
        commissionIncluded,
        legDetails,
        requestReservationChannel,
        requestedCorporationID,
        requestedCurrencyOfFareQuote,
        requestedFareFilterMethod,
        requestedGroupMethod,
        requestedIataNumber,
        requestedInventoryFilterMethod,
        taxDetails
      ];

  final List<InboundOutboundSegment>? inboundSegment;
  final List<InboundOutboundSegment>? outboundSegment;
  final bool? commissionIncluded;
  final List<LegDetails>? legDetails;
  final num? requestReservationChannel;
  final num? requestedCorporationID;
  final String? requestedCurrencyOfFareQuote;
  final num? requestedFareFilterMethod;
  final num? requestedGroupMethod;
  final String? requestedIataNumber;
  final num? requestedInventoryFilterMethod;
  final List<TaxDetail>? taxDetails;

  const FlightResult(
      {this.inboundSegment,
      this.outboundSegment,
      this.commissionIncluded,
      this.legDetails,
      this.requestReservationChannel,
      this.requestedCorporationID,
      this.requestedCurrencyOfFareQuote,
      this.requestedFareFilterMethod,
      this.requestedGroupMethod,
      this.requestedIataNumber,
      this.requestedInventoryFilterMethod,
      this.taxDetails});

  factory FlightResult.fromJson(Map<String, dynamic> json) =>
      _$FlightResultFromJson(json);

  Map<String, dynamic> toJson() => _$FlightResultToJson(this);
}

@JsonSerializable()
class InboundOutboundSegment extends Equatable {
  @override
  List<Object?> get props => [
        segmentDetail,
        minInboundTotalPrice,
        totalSegmentFareAmt,
        adultPricePerPax,
        adultPriceTotal,
        childPricePerPax,
        childPriceTotal,
        infantPricePerPax,
        infantPriceTotal,
        fareTypeWithTaxDetails,
        lfid,
        departureDate,
        arrivalDate,
        legCount,
        international,
        flightLegDetails,
        totalSegmentFareAmtWithInfantSSR,
        beforeDiscountTotalAmt,
        beforeDiscountTotalAmtWithInfantSSR,
        fbCode,
        discountPCT,
      ];

  final SegmentDetail? segmentDetail;
  final num? minInboundTotalPrice;
  final num? totalSegmentFareAmt;
  final num? adultPricePerPax;
  final num adultPriceTotal;
  final num? childPricePerPax;
  final num childPriceTotal;
  final num? infantPricePerPax;
  final num infantPriceTotal;
  final List<FareTypeWithTaxDetails>? fareTypeWithTaxDetails;
  final num? lfid;
  final DateTime? departureDate;
  final DateTime? arrivalDate;
  final num? legCount;
  final bool? international;
  final List<FlightLegDetails>? flightLegDetails;
  final num? totalSegmentFareAmtWithInfantSSR;
  final num? beforeDiscountTotalAmt;
  final num? beforeDiscountTotalAmtWithInfantSSR;
  final num? discountPCT;

  final String? fbCode;

  const InboundOutboundSegment({
    this.totalSegmentFareAmtWithInfantSSR,
    this.beforeDiscountTotalAmt,
    this.beforeDiscountTotalAmtWithInfantSSR,
    this.fbCode,
    this.segmentDetail,
    this.minInboundTotalPrice,
    this.totalSegmentFareAmt,
    this.adultPricePerPax,
    this.discountPCT,
    this.adultPriceTotal = 0,
    this.childPricePerPax,
    this.childPriceTotal = 0,
    this.infantPricePerPax,
    this.infantPriceTotal = 0,
    this.fareTypeWithTaxDetails,
    this.lfid,
    this.departureDate,
    this.arrivalDate,
    this.legCount,
    this.international,
    this.flightLegDetails,
  });

  num get getTotalPrice => totalSegmentFareAmt ?? 0;

  num get getTotalPriceDisplay => totalSegmentFareAmtWithInfantSSR ?? 0;

  factory InboundOutboundSegment.fromJson(Map<String, dynamic> json) =>
      _$InboundOutboundSegmentFromJson(json);

  Map<String, dynamic> toJson() => _$InboundOutboundSegmentToJson(this);

  getPrice(String pax){
    switch (pax.toUpperCase()){
      case "ADT":
        return adultPricePerPax;
      case "CHD":
        return childPricePerPax;
      case "INF":
        return infantPricePerPax;
      default:
        return 0;
    }
  }
}

@JsonSerializable()
class SegmentDetail extends Equatable {
  @override
  List<Object?> get props => [
        lfid,
        origin,
        destination,
        departureDate,
        carrierCode,
        arrivalDate,
        stops,
        flightTime,
        aircraftType,
        sellingCarrier,
        flightNum,
        operatingCarrier,
        operatingFlightNum,
        flyMonday,
        flyTuesday,
        flyWednesday,
        flyThursday,
        flyFriday,
        flySaturday,
        flySunday,
        aircraftDescription,
        deiDisclosure
      ];

  final num? lfid;
  final String? origin;
  final String? destination;
  final DateTime? departureDate;
  final String? carrierCode;
  final DateTime? arrivalDate;
  final num? stops;
  final num? flightTime;
  final String? aircraftType;
  final String? sellingCarrier;
  final String? flightNum;
  final String? operatingCarrier;
  final String? operatingFlightNum;
  final bool? flyMonday;
  final bool? flyTuesday;
  final bool? flyWednesday;
  final bool? flyThursday;
  final bool? flyFriday;
  final bool? flySaturday;
  final bool? flySunday;
  final String? aircraftDescription;
  final String? deiDisclosure;

  const SegmentDetail({
    this.lfid,
    this.origin,
    this.destination,
    this.departureDate,
    this.carrierCode,
    this.arrivalDate,
    this.stops,
    this.flightTime,
    this.aircraftType,
    this.sellingCarrier,
    this.flightNum,
    this.operatingCarrier,
    this.operatingFlightNum,
    this.flyMonday,
    this.flyTuesday,
    this.flyWednesday,
    this.flyThursday,
    this.flyFriday,
    this.flySaturday,
    this.flySunday,
    this.aircraftDescription,
    this.deiDisclosure,
  });

  factory SegmentDetail.fromJson(Map<String, dynamic> json) =>
      _$SegmentDetailFromJson(json);

  Map<String, dynamic> toJson() => _$SegmentDetailToJson(this);
}

@JsonSerializable()
class FareTypeWithTaxDetails extends Equatable {
  @override
  List<Object?> get props =>
      [fareInfoWithTaxDetails, fareTypeID, fareTypeName, filterRemove];

  final List<FareInfoWithTaxDetails>? fareInfoWithTaxDetails;
  final num? fareTypeID;
  final String? fareTypeName;
  final bool? filterRemove;

  const FareTypeWithTaxDetails(
      {this.fareInfoWithTaxDetails,
      this.fareTypeID,
      this.fareTypeName,
      this.filterRemove});

  factory FareTypeWithTaxDetails.fromJson(Map<String, dynamic> json) =>
      _$FareTypeWithTaxDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$FareTypeWithTaxDetailsToJson(this);
}

@JsonSerializable()
class FareInfoWithTaxDetails extends Equatable {
  @override
  List<Object?> get props => [
        applicationTaxDetailBinds,
        returnFlightSegmentDetails,
        fareID,
        fcCode,
        fbCode,
        baseFareAmtNoTaxes,
        baseFareAmt,
        fareAmtNoTaxes,
        fareAmt,
        baseFareAmtInclTax,
        fareAmtInclTax,
        pvtFare,
        ptcid,
        cabin,
        seatsAvailable,
        infantSeatsAvailable,
        fareScheduleID,
        promotionID,
        roundTrip,
        displayFareAmt,
        displayTaxSum,
        specialMarketed,
        waitList,
        spaceAvailable,
        positiveSpace,
        promotionCatID,
        commissionAmount,
        promotionAmount,
        bundleCode,
        originalCurrency,
        exchangeRate,
        exchangeDate
      ];

  final List<ApplicationTaxDetailBinds>? applicationTaxDetailBinds;
  final List<dynamic>? returnFlightSegmentDetails;
  final num? fareID;
  final String? fcCode;
  final String? fbCode;
  final num? baseFareAmtNoTaxes;
  final num? baseFareAmt;
  final num? fareAmtNoTaxes;
  final num? fareAmt;
  final num? baseFareAmtInclTax;
  final num? fareAmtInclTax;
  final bool? pvtFare;
  final num? ptcid;
  final String? cabin;
  final num? seatsAvailable;
  final num? infantSeatsAvailable;
  final num? fareScheduleID;
  final num? promotionID;
  final num? roundTrip;
  final num? displayFareAmt;
  final num? displayTaxSum;
  final bool? specialMarketed;
  final bool? waitList;
  final bool? spaceAvailable;
  final bool? positiveSpace;
  final num? promotionCatID;
  final num? commissionAmount;
  final num? promotionAmount;
  final String? bundleCode;
  final String? originalCurrency;
  final num? exchangeRate;
  final DateTime? exchangeDate;

  const FareInfoWithTaxDetails(
      {this.applicationTaxDetailBinds,
      this.returnFlightSegmentDetails,
      this.fareID,
      this.fcCode,
      this.fbCode,
      this.baseFareAmtNoTaxes,
      this.baseFareAmt,
      this.fareAmtNoTaxes,
      this.fareAmt,
      this.baseFareAmtInclTax,
      this.fareAmtInclTax,
      this.pvtFare,
      this.ptcid,
      this.cabin,
      this.seatsAvailable,
      this.infantSeatsAvailable,
      this.fareScheduleID,
      this.promotionID,
      this.roundTrip,
      this.displayFareAmt,
      this.displayTaxSum,
      this.specialMarketed,
      this.waitList,
      this.spaceAvailable,
      this.positiveSpace,
      this.promotionCatID,
      this.commissionAmount,
      this.promotionAmount,
      this.bundleCode,
      this.originalCurrency,
      this.exchangeRate,
      this.exchangeDate});

  factory FareInfoWithTaxDetails.fromJson(Map<String, dynamic> json) =>
      _$FareInfoWithTaxDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$FareInfoWithTaxDetailsToJson(this);
}

@JsonSerializable()
class ApplicationTaxDetailBinds extends Equatable {
  @override
  List<Object?> get props =>
      [taxDetail, taxID, amt, initiatingTaxID, commissionAmount];

  final TaxDetail? taxDetail;
  final num? taxID;
  final num? amt;
  final num? initiatingTaxID;
  final num? commissionAmount;

  const ApplicationTaxDetailBinds(
      {this.taxDetail,
      this.taxID,
      this.amt,
      this.initiatingTaxID,
      this.commissionAmount});

  factory ApplicationTaxDetailBinds.fromJson(Map<String, dynamic> json) =>
      _$ApplicationTaxDetailBindsFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationTaxDetailBindsToJson(this);
}

@JsonSerializable()
class TaxDetail extends Equatable {
  @override
  List<Object?> get props => [
        taxID,
        taxCode,
        codeType,
        taxCurr,
        taxDesc,
        taxType,
        isVat,
        includedInFare,
        originalCurrency,
        exchangeRate,
        exchangeDate,
        commissionable
      ];

  final num? taxID;
  final String? taxCode;
  final String? codeType;
  final String? taxCurr;
  final String? taxDesc;
  final num? taxType;
  final bool? isVat;
  final bool? includedInFare;
  final String? originalCurrency;
  final num? exchangeRate;
  final DateTime? exchangeDate;
  final bool? commissionable;

  const TaxDetail(
      {this.taxID,
      this.taxCode,
      this.codeType,
      this.taxCurr,
      this.taxDesc,
      this.taxType,
      this.isVat,
      this.includedInFare,
      this.originalCurrency,
      this.exchangeRate,
      this.exchangeDate,
      this.commissionable});

  factory TaxDetail.fromJson(Map<String, dynamic> json) =>
      _$TaxDetailFromJson(json);

  Map<String, dynamic> toJson() => _$TaxDetailToJson(this);
}

@JsonSerializable()
class FlightLegDetails extends Equatable {
  @override
  List<Object?> get props => [pfid, departureDate];

  final num? pfid;
  final DateTime? departureDate;

  const FlightLegDetails({this.pfid, this.departureDate});

  factory FlightLegDetails.fromJson(Map<String, dynamic> json) =>
      _$FlightLegDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$FlightLegDetailsToJson(this);
}

@JsonSerializable()
class LegDetails extends Equatable {
  @override
  List<Object?> get props => [
        pfid,
        departureDate,
        origin,
        destination,
        flightNum,
        international,
        arrivalDate,
        flightTime,
        operatingCarrier,
        fromTerminal,
        toTerminal,
        aircraftType,
        aircraftDescription,
        deiDisclosure,
        aircraftLayoutName,
        serviceType
      ];

  final num? pfid;
  final DateTime? departureDate;
  final String? origin;
  final String? destination;
  final String? flightNum;
  final bool? international;
  final DateTime? arrivalDate;
  final num? flightTime;
  final String? operatingCarrier;
  final String? fromTerminal;
  final String? toTerminal;
  final String? aircraftType;
  final String? aircraftDescription;
  final String? deiDisclosure;
  final String? aircraftLayoutName;
  final String? serviceType;

  const LegDetails(
      {this.pfid,
      this.departureDate,
      this.origin,
      this.destination,
      this.flightNum,
      this.international,
      this.arrivalDate,
      this.flightTime,
      this.operatingCarrier,
      this.fromTerminal,
      this.toTerminal,
      this.aircraftType,
      this.aircraftDescription,
      this.deiDisclosure,
      this.aircraftLayoutName,
      this.serviceType});

  factory LegDetails.fromJson(Map<String, dynamic> json) =>
      _$LegDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$LegDetailsToJson(this);
}
