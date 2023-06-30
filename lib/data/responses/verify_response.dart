import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/data/requests/search_flight_request.dart';
import 'package:app/data/responses/aplicable_taxes.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/pages/add_on/seats/ui/seat_legend_simple.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:json_annotation/json_annotation.dart';

import '../../utils/date_utils.dart';

part 'verify_response.g.dart';

@JsonSerializable(includeIfNull: false)
class VerifyResponse extends Equatable {
  @override
  List<Object?> get props => [
        flightVerifyRequest,
        flightVerifyResponse,
        flightSSR,
        flightSeat,
        orderID,
        success,
        flightSummaryPNRRequest,
        token,
        verifyExpiredDateTime,
      ];

  factory VerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResponseToJson(this);
  final CommonFlightRequest? flightVerifyRequest;
  final FlightVerifyResponse? flightVerifyResponse;
  final FlightSSR? flightSSR;
  final FlightSeats? flightSeat;
  final FlightSummaryPnrRequest? flightSummaryPNRRequest;
  final num? orderID;
  final bool? success;
  final String? token;
  final DateTime? verifyExpiredDateTime;

  const VerifyResponse({
    this.flightVerifyRequest,
    this.flightVerifyResponse,
    this.flightSummaryPNRRequest,
    this.flightSSR,
    this.flightSeat,
    this.orderID,
    this.success,
    this.token,
    this.verifyExpiredDateTime,
  });

  VerifyResponse copyWith({
    CommonFlightRequest? flightVerifyRequest,
    FlightVerifyResponse? flightVerifyResponse,
    FlightSummaryPnrRequest? flightSummaryPNRRequest,
    FlightSSR? flightSSR,
    FlightSeats? flightSeat,
    num? orderID,
    bool? success,
    String? token,
    DateTime? verifyExpiredDateTime,
  }) =>
      VerifyResponse(
        flightVerifyRequest: flightVerifyRequest ?? this.flightVerifyRequest,
        flightVerifyResponse: flightVerifyResponse ?? this.flightVerifyResponse,
        flightSummaryPNRRequest:
            flightSummaryPNRRequest ?? this.flightSummaryPNRRequest,
        flightSSR: flightSSR ?? this.flightSSR,
        flightSeat: flightSeat ?? this.flightSeat,
        orderID: orderID ?? this.orderID,
        success: success ?? this.success,
        token: token ?? this.token,
        verifyExpiredDateTime:
            verifyExpiredDateTime ?? this.verifyExpiredDateTime,
      );
}

@JsonSerializable(includeIfNull: false)
class FlightVerifyRequest extends Equatable {
  @override
  List<Object?> get props => [
        originAirport,
        destinationAirport,
        departDate,
        returnDate,
        adults,
        childrens,
        infants,
        isReturn,
        currency,
        totalAmount,
        outboundLFID,
        inboundLFID,
      ];

  factory FlightVerifyRequest.fromJson(Map<String, dynamic> json) =>
      _$FlightVerifyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FlightVerifyRequestToJson(this);
  final String? originAirport;
  final String? destinationAirport;
  final String? departDate;
  final String? returnDate;
  final num? adults;
  final num? childrens;
  final num? infants;
  final bool? isReturn;
  final String? currency;
  final num? totalAmount;
  final List<num>? outboundLFID;
  final List<num>? inboundLFID;

  const FlightVerifyRequest({
    this.originAirport,
    this.destinationAirport,
    this.departDate,
    this.returnDate,
    this.adults,
    this.childrens,
    this.infants,
    this.isReturn,
    this.currency,
    this.totalAmount,
    this.outboundLFID,
    this.inboundLFID,
  });
}

@JsonSerializable(includeIfNull: false)
class FlightVerifyResponse extends Equatable {
  @override
  List<Object?> get props => [errors, result, session, success];

  factory FlightVerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$FlightVerifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FlightVerifyResponseToJson(this);
  final List<dynamic>? errors;
  final Result? result;
  final String? session;
  final bool? success;

  const FlightVerifyResponse(
      {this.errors, this.result, this.session, this.success});
}

@JsonSerializable(includeIfNull: false)
class Result extends Equatable {
  @override
  List<Object?> get props => [
        commissionIncluded,
        flightSegments,
        legDetails,
        requestReservationChannel,
        requestedCorporationID,
        requestedCurrencyOfFareQuote,
        requestedFareFilterMethod,
        requestedGroupMethod,
        requestedIataNumber,
        requestedInventoryFilterMethod,
        segmentDetails,
        taxDetails,
      ];

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
  final bool? commissionIncluded;
  final List<FlightSegments>? flightSegments;
  final List<LegDetails>? legDetails;
  final num? requestReservationChannel;
  final num? requestedCorporationID;
  final String? requestedCurrencyOfFareQuote;
  final num? requestedFareFilterMethod;
  final num? requestedGroupMethod;
  final String? requestedIataNumber;
  final num? requestedInventoryFilterMethod;
  final List<SegmentDetail>? segmentDetails;
  final List<TaxDetails>? taxDetails;

  const Result({
    this.commissionIncluded,
    this.flightSegments,
    this.legDetails,
    this.requestReservationChannel,
    this.requestedCorporationID,
    this.requestedCurrencyOfFareQuote,
    this.requestedFareFilterMethod,
    this.requestedGroupMethod,
    this.requestedIataNumber,
    this.requestedInventoryFilterMethod,
    this.segmentDetails,
    this.taxDetails,
  });
}

@JsonSerializable(includeIfNull: false)
class FlightSegments extends Equatable {
  @override
  List<Object?> get props => [
        lfid,
        departureDate,
        arrivalDate,
        legCount,
        numernational,
        fareTypes,
        flightLegDetails
      ];

  factory FlightSegments.fromJson(Map<String, dynamic> json) =>
      _$FlightSegmentsFromJson(json);

  Map<String, dynamic> toJson() => _$FlightSegmentsToJson(this);
  final num? lfid;
  final String? departureDate;

  final String? arrivalDate;
  final num? legCount;
  final bool? numernational;
  final List<FareTypes>? fareTypes;
  final List<FlightLegDetails>? flightLegDetails;

  const FlightSegments(
      {this.lfid,
      this.departureDate,
      this.arrivalDate,
      this.legCount,
      this.numernational,
      this.fareTypes,
      this.flightLegDetails});


  DateTime get departureDateObject {
    return DateTime.parse(departureDate ?? '');
  }
   String  departureDateToShow(String? locale) {

     if(departureDate == null){
       return '';
     }

    return AppDateUtils.formatHalfDateHalfMonth(DateTime.parse(departureDate!),locale: locale);

   }

  String  departureDateToTwoLine(String? locale) {

    if(departureDate == null){
      return '';
    }

    return AppDateUtils.formatFullDateTwoLines(DateTime.parse(departureDate!),locale: locale);
  }

  String arrivalDateToTwoLine(String? locale) {

    if(arrivalDate == null){
      return '';
    }

    return AppDateUtils.formatFullDateTwoLines(DateTime.parse(arrivalDate!),locale: locale);
  }

   //    return AppDateUtils.formatFullDateTwoLines(
//         flightSegments?.first.inbound?.first.departureDateTime);

}

@JsonSerializable(includeIfNull: false)
class FareTypes extends Equatable {
  @override
  List<Object?> get props =>
      [fareTypeID, fareTypeName, filterRemove, fareInfos];

  factory FareTypes.fromJson(Map<String, dynamic> json) =>
      _$FareTypesFromJson(json);

  Map<String, dynamic> toJson() => _$FareTypesToJson(this);
  final num? fareTypeID;
  final String? fareTypeName;
  final bool? filterRemove;
  final List<FareInfos>? fareInfos;

  const FareTypes(
      {this.fareTypeID, this.fareTypeName, this.filterRemove, this.fareInfos});
}

@JsonSerializable(includeIfNull: false)
class FareInfos extends Equatable {
  @override
  List<Object?> get props => [
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
        applicableTaxDetails,
        bundleCode,
        originalCurrency,
        exchangeRate,
        exchangeDate
      ];

  factory FareInfos.fromJson(Map<String, dynamic> json) =>
      _$FareInfosFromJson(json);

  Map<String, dynamic> toJson() => _$FareInfosToJson(this);
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
  final List<ApplicableTaxDetails>? applicableTaxDetails;
  final String? bundleCode;
  final String? originalCurrency;
  final num? exchangeRate;
  final String? exchangeDate;

  const FareInfos(
      {this.returnFlightSegmentDetails,
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
      this.applicableTaxDetails,
      this.bundleCode,
      this.originalCurrency,
      this.exchangeRate,
      this.exchangeDate});
}

@JsonSerializable(includeIfNull: false)
class ApplicableTaxDetails extends Equatable {
  @override
  List<Object?> get props => [taxID, amt, initiatingTaxID, commissionAmount];

  factory ApplicableTaxDetails.fromJson(Map<String, dynamic> json) =>
      _$ApplicableTaxDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicableTaxDetailsToJson(this);
  final num? taxID;
  final num? amt;
  final num? initiatingTaxID;
  final num? commissionAmount;

  const ApplicableTaxDetails(
      {this.taxID, this.amt, this.initiatingTaxID, this.commissionAmount});
}

@JsonSerializable(includeIfNull: false)
class FlightLegDetails extends Equatable {
  @override
  List<Object?> get props => [pfid, departureDate];

  factory FlightLegDetails.fromJson(Map<String, dynamic> json) =>
      _$FlightLegDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$FlightLegDetailsToJson(this);
  final String? pfid;
  final String? departureDate;

  const FlightLegDetails({this.pfid, this.departureDate});
}

@JsonSerializable(includeIfNull: false)
class LegDetails extends Equatable {
  @override
  List<Object?> get props => [];

  factory LegDetails.fromJson(Map<String, dynamic> json) =>
      _$LegDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$LegDetailsToJson(this);
  final String? pfid;
  final String? departureDate;
  final String? origin;
  final String? destination;
  final String? flightNum;
  final bool? numernational;
  final String? arrivalDate;
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
      this.numernational,
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
}

@JsonSerializable(includeIfNull: false)
class TaxDetails extends Equatable {
  @override
  List<Object?> get props => [];

  factory TaxDetails.fromJson(Map<String, dynamic> json) =>
      _$TaxDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TaxDetailsToJson(this);
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
  final String? exchangeDate;
  final bool? commissionable;

  const TaxDetails({
    this.taxID,
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
    this.commissionable,
  });
}

@JsonSerializable(includeIfNull: false)
class FlightSSR extends Equatable {
  @override
  List<Object?> get props => [bundleGroup, mealGroup, baggageGroup, seatGroup];

  factory FlightSSR.fromJson(Map<String, dynamic> json) =>
      _$FlightSSRFromJson(json);

  Map<String, dynamic> toJson() => _$FlightSSRToJson(this);
  final BundleGroup? bundleGroup;
  final BundleGroupSeat? mealGroup;
  final BaggageGroup? baggageGroup;
  final BundleGroupSeat? seatGroup;
  final BundleGroupSeat? infantGroup;
  final BundleGroupSeat? wheelChairGroup;
  final BundleGroupSeat? sportGroup;
  final BundleGroupSeat? insuranceGroup;

  //
  //

  const FlightSSR({
    this.bundleGroup,
    this.mealGroup,
    this.baggageGroup,
    this.seatGroup,
    this.infantGroup,
    this.wheelChairGroup,
    this.sportGroup,
    this.insuranceGroup,
  });
}

@JsonSerializable(includeIfNull: false)
class BundleGroup extends Equatable {
  @override
  List<Object?> get props => [inbound, outbound];

  factory BundleGroup.fromJson(Map<String, dynamic> json) =>
      _$BundleGroupFromJson(json);

  Map<String, dynamic> toJson() => _$BundleGroupToJson(this);
  final List<InboundBundle>? inbound;
  final List<InboundBundle>? outbound;

  const BundleGroup({this.inbound, this.outbound});
}

@JsonSerializable(includeIfNull: false)
class BundleGroupSeat extends Equatable {
  @override
  List<Object?> get props => [inbound, outbound];

  factory BundleGroupSeat.fromJson(Map<String, dynamic> json) =>
      _$BundleGroupSeatFromJson(json);

  Map<String, dynamic> toJson() => _$BundleGroupSeatToJson(this);
  final List<Bundle>? inbound;
  final List<Bundle>? outbound;

  const BundleGroupSeat({this.inbound, this.outbound});
}

@JsonSerializable(includeIfNull: false)
class InboundBundle extends Equatable {
  @override
  List<Object?> get props => [bundle, detail];

  factory InboundBundle.fromJson(Map<String, dynamic> json) =>
      _$InboundBundleFromJson(json);

  Map<String, dynamic> toJson() => _$InboundBundleToJson(this);
  final Bundle? bundle;
  final Detail? detail;

  const InboundBundle({this.bundle, this.detail});

  Bound toBound({bool sports = false}) {
    if (sports) {
      return Bound(
        name: bundle?.description?.toLowerCase(),
        servicesType: "Sports",
        price: bundle?.finalAmount,
        logicalFlightId: bundle?.logicalFlightID,
        quantity: 1,
        serviceId: bundle?.serviceID,
      );
    }
    return Bound(
      name: bundle?.description?.toLowerCase(),
      servicesType: "BUNDLE",
      price: bundle?.finalAmount,
      logicalFlightId: bundle?.logicalFlightID,
      quantity: 1,
      serviceId: bundle?.serviceID,
    );
  }
}

@JsonSerializable(includeIfNull: false)
class Bundle extends Equatable {
  Bound toBound({bool sports = false, bool isInsurance = false}) {
    if (isInsurance) {
      return Bound(
        name: description,
        servicesType: "Insurance",
        logicalFlightId: logicalFlightID,
        quantity: 1,
        price: amount == null
            ? 0
            : (amount! + (applicableTaxes!.firstOrNull?.taxAmount ?? 0)),
        serviceId: serviceID,
      );
    } else if (sports) {
      return Bound(
        name: description?.toLowerCase(),
        servicesType: "Sport",
        logicalFlightId: logicalFlightID,
        quantity: 1,
        serviceId: serviceID,
      );
    }
    return Bound(
      name: description?.toLowerCase(),
      servicesType: description?.contains("Wheelchair") ?? false
          ? "WheelChair"
          : "BAGGAGE",
      price: finalAmount,
      logicalFlightId: logicalFlightID,
      quantity: 1,
      serviceId: serviceID,
    );
  }

  @override
  List<Object?> get props => [
        logicalFlightID,
        serviceID,
        departureDate,
        operatingCarrier,
        marketingCarrier,
        codeType,
        description,
        currencyCode,
        amount,
        amountActive,
        categoryID,
        ssrCode,
        display,
        maxCountServiceLevel,
        refundable,
        pnlActive,
        cutoffHours,
        commissionable,
        displayOrder,
        revenueCategoryID,
        iataStandardCodeType,
        serviceActive,
        maxCountFlightLevel,
        quantityAvailable,
        startSalesDays,
        applicableTaxes,
        boardingPassSsrOrder,
        serviceType
      ];

  factory Bundle.fromJson(Map<String, dynamic> json) => _$BundleFromJson(json);

  Map<String, dynamic> toJson() => _$BundleToJson(this);
  final String? logicalFlightID;
  final num? serviceID;
  final String? departureDate;
  final String? operatingCarrier;
  final String? marketingCarrier;
  final String? codeType;
  final String? description;
  final String? currencyCode;
  final num? amount;
  final bool? amountActive;
  final num? categoryID;
  final String? ssrCode;
  final bool? display;
  final num? maxCountServiceLevel;
  final bool? refundable;
  final bool? pnlActive;
  final num? cutoffHours;
  final bool? commissionable;
  final num? displayOrder;
  final num? revenueCategoryID;
  final String? iataStandardCodeType;
  final bool? serviceActive;
  final num? maxCountFlightLevel;
  final num? quantityAvailable;
  final num? startSalesDays;
  final List<ApplicableTaxes>? applicableTaxes;
  final num? boardingPassSsrOrder;
  final num? serviceType;

  const Bundle({
    this.logicalFlightID,
    this.serviceID,
    this.departureDate,
    this.operatingCarrier,
    this.marketingCarrier,
    this.codeType,
    this.description,
    this.currencyCode,
    this.amount,
    this.amountActive,
    this.categoryID,
    this.ssrCode,
    this.display,
    this.maxCountServiceLevel,
    this.refundable,
    this.pnlActive,
    this.cutoffHours,
    this.commissionable,
    this.displayOrder,
    this.revenueCategoryID,
    this.iataStandardCodeType,
    this.serviceActive,
    this.maxCountFlightLevel,
    this.quantityAvailable,
    this.startSalesDays,
    this.applicableTaxes,
    this.boardingPassSsrOrder,
    this.serviceType,
  });

  num get getTotalTaxes {
    if (applicableTaxes?.isEmpty ?? true) return 0;
    num totalTax = 0;
    for (var element in applicableTaxes!) {
      totalTax = totalTax + (element.amountToApply ?? 0);
    }
    return totalTax;
  }

  num get finalAmount => (amount ?? 0) + getTotalTaxes;
}

@JsonSerializable(includeIfNull: false)
class Detail extends Equatable {
  @override
  List<Object?> get props => [
        bundleDescription,
        bundleGlCode,
        bundleIataStdCodeType,
        bundleId,
        bundleIsMaxinventory,
        bundleServiceDetails,
        bundleType,
        exceptions,
        serviceBundleCode,
        version
      ];

  factory Detail.fromJson(Map<String, dynamic> json) => _$DetailFromJson(json);

  Map<String, dynamic> toJson() => _$DetailToJson(this);
  final String? bundleDescription;
  final String? bundleGlCode;
  final String? bundleIataStdCodeType;
  final num? bundleId;
  final bool? bundleIsMaxinventory;
  final List<BundleServiceDetails>? bundleServiceDetails;
  final num? bundleType;
  final List<dynamic>? exceptions;
  final String? serviceBundleCode;
  final String? version;

  const Detail(
      {this.bundleDescription,
      this.bundleGlCode,
      this.bundleIataStdCodeType,
      this.bundleId,
      this.bundleIsMaxinventory,
      this.bundleServiceDetails,
      this.bundleType,
      this.exceptions,
      this.serviceBundleCode,
      this.version});
}

@JsonSerializable(includeIfNull: false)
class BundleServiceDetails extends Equatable {
  @override
  List<Object?> get props => [
        bundleGroupIndex,
        bundleQtyGroupIndex,
        categoryID,
        description,
        glCode,
        isMaxinventory,
        serviceID,
        ssrCode
      ];

  factory BundleServiceDetails.fromJson(Map<String, dynamic> json) =>
      _$BundleServiceDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$BundleServiceDetailsToJson(this);
  final num? bundleGroupIndex;
  final num? bundleQtyGroupIndex;
  final num? categoryID;
  final String? description;
  final String? glCode;
  final bool? isMaxinventory;
  final num? serviceID;
  final String? ssrCode;

  const BundleServiceDetails(
      {this.bundleGroupIndex,
      this.bundleQtyGroupIndex,
      this.categoryID,
      this.description,
      this.glCode,
      this.isMaxinventory,
      this.serviceID,
      this.ssrCode});
}

@JsonSerializable(includeIfNull: false)
class BaggageGroup extends Equatable {
  @override
  List<Object?> get props => [inbound, outbound];

  factory BaggageGroup.fromJson(Map<String, dynamic> json) =>
      _$BaggageGroupFromJson(json);

  Map<String, dynamic> toJson() => _$BaggageGroupToJson(this);
  final List<Bundle>? inbound;
  final List<Bundle>? outbound;

  const BaggageGroup({this.inbound, this.outbound});
}

@JsonSerializable(includeIfNull: false)
class FlightSeats extends Equatable {
  @override
  List<Object?> get props => [inbound, outbound];

  factory FlightSeats.fromJson(Map<String, dynamic> json) =>
      _$FlightSeatsFromJson(json);

  Map<String, dynamic> toJson() => _$FlightSeatsToJson(this);
  final List<InboundSeat>? inbound;
  final List<InboundSeat>? outbound;

  const FlightSeats({this.inbound, this.outbound});
}

@JsonSerializable(includeIfNull: false)
class InboundSeat extends Equatable {
  @override
  List<Object?> get props => [segmentCount, retrieveFlightSeatMapResponse];

  factory InboundSeat.fromJson(Map<String, dynamic> json) =>
      _$InboundSeatFromJson(json);

  Map<String, dynamic> toJson() => _$InboundSeatToJson(this);
  final num? segmentCount;
  final RetrieveFlightSeatMapResponse? retrieveFlightSeatMapResponse;

  const InboundSeat({this.segmentCount, this.retrieveFlightSeatMapResponse});
}

@JsonSerializable(includeIfNull: false)
class RetrieveFlightSeatMapResponse extends Equatable {
  @override
  List<Object?> get props => [physicalFlights, rules];

  factory RetrieveFlightSeatMapResponse.fromJson(Map<String, dynamic> json) =>
      _$RetrieveFlightSeatMapResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RetrieveFlightSeatMapResponseToJson(this);
  final List<PhysicalFlights>? physicalFlights;
  final Rules? rules;

  const RetrieveFlightSeatMapResponse({this.physicalFlights, this.rules});
}

@JsonSerializable(includeIfNull: false)
class PhysicalFlights extends Equatable {
  @override
  List<Object?> get props => [
        departureDate,
        destination,
        destinationName,
        flightNum,
        origin,
        originName,
        physicalFlightID,
        physicalFlightSeatMap
      ];

  factory PhysicalFlights.fromJson(Map<String, dynamic> json) =>
      _$PhysicalFlightsFromJson(json);

  Map<String, dynamic> toJson() => _$PhysicalFlightsToJson(this);
  final String? departureDate;
  final String? destination;
  final String? destinationName;
  final String? flightNum;
  final String? origin;
  final String? originName;
  final String? physicalFlightID;
  final PhysicalFlightSeatMap? physicalFlightSeatMap;

  const PhysicalFlights(
      {this.departureDate,
      this.destination,
      this.destinationName,
      this.flightNum,
      this.origin,
      this.originName,
      this.physicalFlightID,
      this.physicalFlightSeatMap});
}

@JsonSerializable(includeIfNull: false)
class PhysicalFlightSeatMap extends Equatable {
  @override
  List<Object?> get props => [
        cabinClasses,
        decks,
        seatCabins,
        seatConfiguration,
        seatDescription,
        seatWBZones
      ];

  factory PhysicalFlightSeatMap.fromJson(Map<String, dynamic> json) =>
      _$PhysicalFlightSeatMapFromJson(json);

  Map<String, dynamic> toJson() => _$PhysicalFlightSeatMapToJson(this);
  final List<CabinClasses>? cabinClasses;
  final List<Decks>? decks;
  final List<SeatCabins>? seatCabins;
  final SeatConfiguration? seatConfiguration;
  final List<SeatDescription>? seatDescription;
  final List<SeatWBZones>? seatWBZones;

  const PhysicalFlightSeatMap(
      {this.cabinClasses,
      this.decks,
      this.seatCabins,
      this.seatConfiguration,
      this.seatDescription,
      this.seatWBZones});
}

@JsonSerializable(includeIfNull: false)
class CabinClasses extends Equatable {
  @override
  List<Object?> get props => [cabin, cabinClass, cabinClassId, cabinOrder];

  factory CabinClasses.fromJson(Map<String, dynamic> json) =>
      _$CabinClassesFromJson(json);

  Map<String, dynamic> toJson() => _$CabinClassesToJson(this);
  final String? cabin;
  final String? cabinClass;
  final num? cabinClassId;
  final num? cabinOrder;

  const CabinClasses(
      {this.cabin, this.cabinClass, this.cabinClassId, this.cabinOrder});
}

@JsonSerializable(includeIfNull: false)
class Decks extends Equatable {
  @override
  List<Object?> get props => [deckCode, deckId, description];

  factory Decks.fromJson(Map<String, dynamic> json) => _$DecksFromJson(json);

  Map<String, dynamic> toJson() => _$DecksToJson(this);
  final String? deckCode;
  final num? deckId;
  final String? description;

  const Decks({this.deckCode, this.deckId, this.description});
}

@JsonSerializable(includeIfNull: false)
class SeatCabins extends Equatable {
  @override
  List<Object?> get props =>
      [cabinClassId, cabinDisplayOrder, capacity, seatCabinId, seatConfigId];

  factory SeatCabins.fromJson(Map<String, dynamic> json) =>
      _$SeatCabinsFromJson(json);

  Map<String, dynamic> toJson() => _$SeatCabinsToJson(this);
  final num? cabinClassId;
  final num? cabinDisplayOrder;
  final num? capacity;
  final num? seatCabinId;
  final num? seatConfigId;

  const SeatCabins(
      {this.cabinClassId,
      this.cabinDisplayOrder,
      this.capacity,
      this.seatCabinId,
      this.seatConfigId});
}

@JsonSerializable(includeIfNull: false)
class SeatConfiguration extends Equatable {
  @override
  List<Object?> get props => [
        carrier,
        configurationDescription,
        configurationName,
        defaultKey,
        iataAcType,
        layoutName,
        rows,
        seatConfigurationId
      ];

  factory SeatConfiguration.fromJson(Map<String, dynamic> json) =>
      _$SeatConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$SeatConfigurationToJson(this);
  final String? carrier;
  final String? configurationDescription;
  final String? configurationName;
  @JsonKey(name: 'default')
  final bool? defaultKey;
  final String? iataAcType;
  final String? layoutName;
  final List<Rows>? rows;
  final num? seatConfigurationId;

  const SeatConfiguration(
      {this.carrier,
      this.configurationDescription,
      this.configurationName,
      this.defaultKey,
      this.iataAcType,
      this.layoutName,
      this.rows,
      this.seatConfigurationId});
}

@JsonSerializable(includeIfNull: false)
class Rows extends Equatable {
  @override
  List<Object?> get props =>
      [deckId, restrictions, rowId, rowNumber, seatConfigId, seats];

  factory Rows.fromJson(Map<String, dynamic> json) => _$RowsFromJson(json);

  Map<String, dynamic> toJson() => _$RowsToJson(this);
  final num? deckId;
  final List<dynamic>? restrictions;
  final num? rowId;
  final num? rowNumber;
  final num? seatConfigId;
  final List<Seats>? seats;

  const Rows(
      {this.deckId,
      this.restrictions,
      this.rowId,
      this.rowNumber,
      this.seatConfigId,
      this.seats});
}

@JsonSerializable(includeIfNull: false)
class Seats extends Equatable {
  @override
  List<Object?> get props => [
        blockChild,
        blockInfant,
        isEmergencyRow,
        cabinClassId,
        isSeatAvailable,
        restrictions,
        rowId,
        seatAttributes,
        seatCabinId,
        seatColumn,
        seatId,
        seatOrder,
        seatPriceOffers,
        seatWBZoneId,
        serviceCode,
        serviceDescription,
        serviceId,
        weightIndex
      ];

  factory Seats.fromJson(Map<String, dynamic> json) => _$SeatsFromJson(json);

  Map<String, dynamic> toJson() => _$SeatsToJson(this);
  final bool? blockChild;
  final bool? blockInfant;
  final bool? isEmergencyRow;
  final num? cabinClassId;
  final bool? isSeatAvailable;
  final List<Restrictions>? restrictions;
  final num? rowId;
  final List<SeatAttributes>? seatAttributes;
  final num? seatCabinId;
  final String? seatColumn;
  final String? seatId;
  final num? seatOrder;
  final List<SeatPriceOffers>? seatPriceOffers;
  final num? seatWBZoneId;
  final String? serviceCode;
  final String? serviceDescription;
  final num? serviceId;
  final num? weightIndex;

  const Seats(
      {this.blockChild,
      this.blockInfant,
      this.isEmergencyRow,
      this.cabinClassId,
      this.isSeatAvailable,
      this.restrictions,
      this.rowId,
      this.seatAttributes,
      this.seatCabinId,
      this.seatColumn,
      this.seatId,
      this.seatOrder,
      this.seatPriceOffers,
      this.seatWBZoneId,
      this.serviceCode,
      this.serviceDescription,
      this.serviceId,
      this.weightIndex});

  num getRowNumber(List<Rows> rows) {
    final row = rows.firstWhereOrNull((element) => element.rowId == rowId);
    return row?.rowNumber ?? 0;
  }

  Outbound toOutbound(List<Rows> rows) {
    return Outbound(
      seatRow: getRowNumber(rows),
      price: (seatPriceOffers ?? [])
          .map(
            (e) => Price(
                amount: e.amount,
                currency: e.currency,
                isBundleOffer: e.isBundleOffer),
          )
          .toList(),
      seatColumn: seatColumn,
    );
  }

  Color get toColor {
    if(serviceDescription?.toLowerCase().contains("PREFERRED") ?? false){
      return SeatAvailableLegend.unavailable.color;
    }else if(serviceDescription?.toLowerCase().contains("standard")?? false){
      return SeatAvailableLegend.standard.color;
    }else{
      return SeatAvailableLegend.preferred.color;
    }
  }
}

@JsonSerializable(includeIfNull: false)
class Restrictions extends Equatable {
  @override
  List<Object?> get props => [
        restrictionActive,
        restrictionCategory,
        restrictionComment,
        restrictionId,
        restrictionItemId,
        restrictionItemType,
        restrictionNumber,
        restrictionType
      ];

  factory Restrictions.fromJson(Map<String, dynamic> json) =>
      _$RestrictionsFromJson(json);

  Map<String, dynamic> toJson() => _$RestrictionsToJson(this);
  final bool? restrictionActive;
  final String? restrictionCategory;
  final String? restrictionComment;
  final num? restrictionId;
  final num? restrictionItemId;
  final num? restrictionItemType;
  final num? restrictionNumber;
  final String? restrictionType;

  const Restrictions(
      {this.restrictionActive,
      this.restrictionCategory,
      this.restrictionComment,
      this.restrictionId,
      this.restrictionItemId,
      this.restrictionItemType,
      this.restrictionNumber,
      this.restrictionType});
}

@JsonSerializable(includeIfNull: false)
class SeatAttributes extends Equatable {
  @override
  List<Object?> get props => [
        active,
        allowSeating,
        attributeCode,
        attributeDescription,
        attributeId,
        attributeOrder,
        isCommercial,
        isMarketing,
        isOperational,
        systemAttribute
      ];

  factory SeatAttributes.fromJson(Map<String, dynamic> json) =>
      _$SeatAttributesFromJson(json);

  Map<String, dynamic> toJson() => _$SeatAttributesToJson(this);
  final bool? active;
  final bool? allowSeating;
  final String? attributeCode;
  final String? attributeDescription;
  final num? attributeId;
  final num? attributeOrder;
  final bool? isCommercial;
  final bool? isMarketing;
  final bool? isOperational;
  final bool? systemAttribute;

  const SeatAttributes(
      {this.active,
      this.allowSeating,
      this.attributeCode,
      this.attributeDescription,
      this.attributeId,
      this.attributeOrder,
      this.isCommercial,
      this.isMarketing,
      this.isOperational,
      this.systemAttribute});
}

@JsonSerializable(includeIfNull: false)
class SeatPriceOffers extends Equatable {
  @override
  List<Object?> get props => [amount, currency, isBundleOffer];

  factory SeatPriceOffers.fromJson(Map<String, dynamic> json) =>
      _$SeatPriceOffersFromJson(json);

  Map<String, dynamic> toJson() => _$SeatPriceOffersToJson(this);
  final num? amount;
  final String? currency;
  final bool? isBundleOffer;

  const SeatPriceOffers({this.amount, this.currency, this.isBundleOffer});
}

@JsonSerializable(includeIfNull: false)
class SeatDescription extends Equatable {
  @override
  List<Object?> get props => [price, seatWBZoneId, serviceDescription];

  factory SeatDescription.fromJson(Map<String, dynamic> json) =>
      _$SeatDescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$SeatDescriptionToJson(this);
  final num? price;
  final num? seatWBZoneId;
  final String? serviceDescription;

  const SeatDescription(
      {this.price, this.seatWBZoneId, this.serviceDescription});
}

@JsonSerializable(includeIfNull: false)
class SeatWBZones extends Equatable {
  @override
  List<Object?> get props => [
        active,
        autoSeatPriority,
        seatConfigId,
        seatWBZoneId,
        wbZone,
        zoneReferenced
      ];

  factory SeatWBZones.fromJson(Map<String, dynamic> json) =>
      _$SeatWBZonesFromJson(json);

  Map<String, dynamic> toJson() => _$SeatWBZonesToJson(this);
  final bool? active;
  final num? autoSeatPriority;
  final num? seatConfigId;
  final num? seatWBZoneId;
  final String? wbZone;
  final bool? zoneReferenced;

  const SeatWBZones(
      {this.active,
      this.autoSeatPriority,
      this.seatConfigId,
      this.seatWBZoneId,
      this.wbZone,
      this.zoneReferenced});
}

@JsonSerializable(includeIfNull: false)
class Rules extends Equatable {
  @override
  List<Object?> get props => [exrpar, exrptc, exrrsr, miapsr, seataj, seatgt];

  factory Rules.fromJson(Map<String, dynamic> json) => _$RulesFromJson(json);

  Map<String, dynamic> toJson() => _$RulesToJson(this);
  final Exrpar? exrpar;
  final Exrptc? exrptc;
  final Exrrsr? exrrsr;
  final Miapsr? miapsr;
  final Seataj? seataj;
  final Seataj? seatgt;

  const Rules(
      {this.exrpar,
      this.exrptc,
      this.exrrsr,
      this.miapsr,
      this.seataj,
      this.seatgt});
}

@JsonSerializable(includeIfNull: false)
class Exrpar extends Equatable {
  @override
  List<Object?> get props =>
      [ageEndRange, ageStartRange, description, reasonCode, ruleCode];

  factory Exrpar.fromJson(Map<String, dynamic> json) => _$ExrparFromJson(json);

  Map<String, dynamic> toJson() => _$ExrparToJson(this);
  final num? ageEndRange;
  final num? ageStartRange;
  final String? description;
  final String? reasonCode;
  final String? ruleCode;

  const Exrpar(
      {this.ageEndRange,
      this.ageStartRange,
      this.description,
      this.reasonCode,
      this.ruleCode});
}

@JsonSerializable(includeIfNull: false)
class Exrptc extends Equatable {
  @override
  List<Object?> get props => [ptcIds, description, reasonCode, ruleCode];

  factory Exrptc.fromJson(Map<String, dynamic> json) => _$ExrptcFromJson(json);

  Map<String, dynamic> toJson() => _$ExrptcToJson(this);
  final List<String>? ptcIds;
  final String? description;
  final String? reasonCode;
  final String? ruleCode;

  const Exrptc({this.ptcIds, this.description, this.reasonCode, this.ruleCode});
}

@JsonSerializable(includeIfNull: false)
class Exrrsr extends Equatable {
  @override
  List<Object?> get props => [ssrs, description, reasonCode, ruleCode];

  factory Exrrsr.fromJson(Map<String, dynamic> json) => _$ExrrsrFromJson(json);

  Map<String, dynamic> toJson() => _$ExrrsrToJson(this);
  final List<String>? ssrs;
  final String? description;
  final String? reasonCode;
  final String? ruleCode;

  const Exrrsr({this.ssrs, this.description, this.reasonCode, this.ruleCode});
}

@JsonSerializable(includeIfNull: false)
class Miapsr extends Equatable {
  @override
  List<Object?> get props =>
      [maxInfantAllowedPerRow, description, reasonCode, ruleCode];

  factory Miapsr.fromJson(Map<String, dynamic> json) => _$MiapsrFromJson(json);

  Map<String, dynamic> toJson() => _$MiapsrToJson(this);
  final num? maxInfantAllowedPerRow;
  final String? description;
  final String? reasonCode;
  final String? ruleCode;

  const Miapsr(
      {this.maxInfantAllowedPerRow,
      this.description,
      this.reasonCode,
      this.ruleCode});
}

@JsonSerializable(includeIfNull: false)
class Seataj extends Equatable {
  @override
  List<Object?> get props =>
      [dependents, linkedPtcs, description, reasonCode, ruleCode];

  factory Seataj.fromJson(Map<String, dynamic> json) => _$SeatajFromJson(json);

  Map<String, dynamic> toJson() => _$SeatajToJson(this);
  final List<dynamic>? dependents;
  final List<dynamic>? linkedPtcs;
  final String? description;
  final String? reasonCode;
  final String? ruleCode;

  const Seataj({
    this.dependents,
    this.linkedPtcs,
    this.description,
    this.reasonCode,
    this.ruleCode,
  });
}
