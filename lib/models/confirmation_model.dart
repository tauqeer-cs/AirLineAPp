import 'package:app/models/number_person.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'confirmation_model.g.dart';

@JsonSerializable()
class ConfirmationModel extends Equatable {
  const ConfirmationModel({
    this.value,
    this.formatters,
    this.contentTypes,
    this.statusCode,
  });

  @override
  List<Object?> get props => [
        value,
        formatters,
        contentTypes,
        statusCode,
      ];

  factory ConfirmationModel.fromJson(Map<String, dynamic> json) =>
      _$ConfirmationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmationModelToJson(this);

  final Value? value;
  final List<dynamic>? formatters;
  final List<dynamic>? contentTypes;
  final num? statusCode;

  ConfirmationModel copyWith({
    Value? value,
    List<dynamic>? formatters,
    List<dynamic>? contentTypes,
    num? statusCode,
  }) =>
      ConfirmationModel(
        value: value ?? this.value,
        formatters: formatters ?? this.formatters,
        contentTypes: contentTypes ?? this.contentTypes,
        statusCode: statusCode ?? this.statusCode,
      );
}

@JsonSerializable()
class Value extends Equatable {
  factory Value.fromJson(Map<String, dynamic> json) => _$ValueFromJson(json);

  Map<String, dynamic> toJson() => _$ValueToJson(this);

  const Value({
    this.superPNR,
    this.superPNROrder,
    this.flightBookings,
    this.passengers,
    this.paymentOrders,
    this.fareAndBundleDetail,
    this.seatDetail,
    this.mealDetail,
    this.baggageDetail,
    this.sportEquipmentDetail,
    this.flightSegments,
    this.bookingContact,
    this.insuranceSSRDetail,
  });

  @override
  List<Object?> get props => [
        superPNR,
        superPNROrder,
        flightBookings,
        passengers,
        paymentOrders,
        fareAndBundleDetail,
        seatDetail,
        mealDetail,
        baggageDetail,
    sportEquipmentDetail,
    insuranceSSRDetail,
        flightSegments,
        bookingContact,
      ];

  final SuperPNR? superPNR;
  final SuperPNROrder? superPNROrder;
  final List<FlightBooking>? flightBookings;
  final List<Passenger>? passengers;
  final List<PaymentOrder>? paymentOrders;
  final FareAndBundleDetail? fareAndBundleDetail;
  final SeatDetail? seatDetail;
  final MealDetail? mealDetail;
  final BookingContact? bookingContact;
  final BaggageDetail? baggageDetail;
  final SportsEquipmentDetail? sportEquipmentDetail;

  final InsuranceDetails? insuranceSSRDetail;
  final List<FlightSegment>? flightSegments;

  Value copyWith({
    SuperPNR? superPNR,
    SuperPNROrder? superPNROrder,
    List<FlightBooking>? flightBookings,
    List<Passenger>? passengers,
    List<PaymentOrder>? paymentOrders,
    FareAndBundleDetail? fareAndBundleDetail,
    SeatDetail? seatDetail,
    BookingContact? bookingContact,
    MealDetail? mealDetail,
    BaggageDetail? baggageDetail,
    List<FlightSegment>? flightSegments,
    SportsEquipmentDetail? sportEquipmentDetail,
    InsuranceDetails? insuranceSSRDetail,
  }) =>
      Value(
        bookingContact: bookingContact ?? this.bookingContact,
        superPNR: superPNR ?? this.superPNR,
        superPNROrder: superPNROrder ?? this.superPNROrder,
        flightBookings: flightBookings ?? this.flightBookings,
        passengers: passengers ?? this.passengers,
        paymentOrders: paymentOrders ?? this.paymentOrders,
        fareAndBundleDetail: fareAndBundleDetail ?? this.fareAndBundleDetail,
        seatDetail: seatDetail ?? this.seatDetail,
        mealDetail: mealDetail ?? this.mealDetail,
        baggageDetail: baggageDetail ?? this.baggageDetail,
        flightSegments: flightSegments ?? this.flightSegments,
        insuranceSSRDetail: insuranceSSRDetail ?? this.insuranceSSRDetail,
      );
}

@JsonSerializable()
class BookingContact extends Equatable {
  factory BookingContact.fromJson(Map<String, dynamic> json) =>
      _$BookingContactFromJson(json);

  Map<String, dynamic> toJson() => _$BookingContactToJson(this);

  const BookingContact(  {
    this.superPNRID,
    this.userId,
    this.titleCode,
    this.givenName,
    this.surname,
    this.email,
    this.phone1,
    this.phone1LocationCode,
    this.dob,
    this.nationality,
    this.passportExpiryDate,
    this.emergencyGivenName,
    this.emergencySurname,
    this.emergencyEmail,
    this.emergencyPhone,
    this.emergencyPhoneCode,
    this.createdById,
    this.createdDate,
    this.createdDateUTC,
    this.modifiedById,
    this.modifiedDate,
    this.modifiedDateUTC,
    this.addressCountryCode,
  this.emergencyRelationship,
    this.fullName,
    this.acceptNewsAndPromotionByEmail
  });

  final num? superPNRID;
  final num? userId;
  final String? titleCode;
  final String? givenName;
  final String? surname;
  final String? email;
  final String? phone1;
  final String? phone1LocationCode;
  @JsonKey(toJson: AppDateUtils.toDateWithoutTimeToJson)
  final DateTime? dob;
  final String? nationality;
  final DateTime? passportExpiryDate;
  final String? emergencyGivenName;
  final String? emergencySurname;
  final String? emergencyEmail;
  final String? emergencyPhone;
  final String? emergencyPhoneCode;
  final num? createdById;
  final DateTime? createdDate;
  final DateTime? createdDateUTC;
  final num? modifiedById;
  final DateTime? modifiedDate;
  final DateTime? modifiedDateUTC;

  final String? addressCountryCode;
  final String? emergencyRelationship;
  final String? fullName;
  final bool? acceptNewsAndPromotionByEmail;

  BookingContact copyWith({
    num? superPNRID,
    num? userId,
    String? titleCode,
    String? givenName,
    String? surname,
    String? email,
    String? phone1,
    String? phone1LocationCode,
    DateTime? dob,
    String? nationality,
    DateTime? passportExpiryDate,
    String? emergencyGivenName,
    String? emergencySurname,
    String? emergencyEmail,
    String? emergencyPhone,
    String? emergencyPhoneCode,
    num? createdById,
    DateTime? createdDate,
    DateTime? createdDateUTC,
    num? modifiedById,
    DateTime? modifiedDate,
    DateTime? modifiedDateUTC,
     String? addressCountryCode,
     String? emergencyRelationship,
    String? fullName,
     bool? acceptNewsAndPromotionByEmail,
  }) =>
      BookingContact(
        superPNRID: superPNRID ?? this.superPNRID,
        userId: userId ?? this.userId,
        titleCode: titleCode ?? this.titleCode,
        givenName: givenName ?? this.givenName,
        surname: surname ?? this.surname,
        email: email ?? this.email,
        phone1: phone1 ?? this.phone1,
        phone1LocationCode: phone1LocationCode ?? this.phone1LocationCode,
        dob: dob ?? this.dob,
        nationality: nationality ?? this.nationality,
        passportExpiryDate: passportExpiryDate ?? this.passportExpiryDate,
        emergencyGivenName: emergencyGivenName ?? this.emergencyGivenName,
        emergencySurname: emergencySurname ?? this.emergencySurname,
        emergencyEmail: emergencyEmail ?? this.emergencyEmail,
        emergencyPhone: emergencyPhone ?? this.emergencyPhone,
        emergencyPhoneCode: emergencyPhoneCode ?? this.emergencyPhoneCode,
        createdById: createdById ?? this.createdById,
        createdDate: createdDate ?? this.createdDate,
        createdDateUTC: createdDateUTC ?? this.createdDateUTC,
        modifiedById: modifiedById ?? this.modifiedById,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        modifiedDateUTC: modifiedDateUTC ?? this.modifiedDateUTC,
        addressCountryCode: addressCountryCode ?? this.addressCountryCode,
        emergencyRelationship: emergencyRelationship ?? this.emergencyRelationship,
        fullName: fullName ?? this.fullName,
        acceptNewsAndPromotionByEmail: acceptNewsAndPromotionByEmail ?? this.acceptNewsAndPromotionByEmail,

      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        superPNRID,
        userId,
        titleCode,
        givenName,
        surname,
        email,
        phone1,
        phone1LocationCode,
        dob,
        nationality,
        passportExpiryDate,
        emergencyGivenName,
        emergencySurname,
        emergencyEmail,
        emergencyPhone,
        emergencyPhoneCode,
        createdById,
        createdDate,
        createdDateUTC,
        modifiedById,
        modifiedDate,
        modifiedDateUTC,
    addressCountryCode,
    emergencyRelationship,
    fullName,
    acceptNewsAndPromotionByEmail
      ];
}

@JsonSerializable()
class BaggageDetail extends Equatable {
  factory BaggageDetail.fromJson(Map<String, dynamic> json) =>
      _$BaggageDetailFromJson(json);

  Map<String, dynamic> toJson() => _$BaggageDetailToJson(this);

  const BaggageDetail({
    this.totalAmount,
    this.baggages,
    this.baggageCount,
  });

  @override
  List<Object?> get props => [
        totalAmount,
        baggages,
      ];

  final num? totalAmount;
  final List<Baggage>? baggages;
  final num? baggageCount;



  BaggageDetail copyWith({
    num? totalAmount,
    List<Baggage>? baggages,
    num? baggageCount
  }) =>
      BaggageDetail(
        totalAmount: totalAmount ?? this.totalAmount,
        baggages: baggages ?? this.baggages,
        baggageCount: baggageCount ?? this.baggageCount,

      );
}

@JsonSerializable()
class Baggage extends Equatable {
  factory Baggage.fromJson(Map<String, dynamic> json) =>
      _$BaggageFromJson(json);

  Map<String, dynamic> toJson() => _$BaggageToJson(this);

  const Baggage({
    this.surName,
    this.givenName,
    this.title,
    this.baggageName,
    this.amount,
    this.quantity,
    this.currency,
    this.departReturn,
    this.seatPosition,
    this.sportEquipmentName,
    this.insuranceSSRName,
  });

  @override
  List<Object?> get props => [
        surName,
        givenName,
        title,
        baggageName,
        amount,
        quantity,
        currency,
        departReturn,
        sportEquipmentName,
      ];
  String? get titleToShow {

    if(title != null) {

      return title!.capitalize();
    }
    return null;
  }

  final String? surName;
  final String? givenName;
  final String? title;

  final String? baggageName;
  final num? amount;
  final num? quantity;
  final String? currency;
  final String? departReturn;
  final String? seatPosition;
  final String? sportEquipmentName;
  final String? insuranceSSRName;


  Baggage copyWith({
    String? surName,
    String? givenName,
    String? title,
    String? baggageName,
    num? amount,
    num? quantity,
    String? currency,
    String? departReturn,
    String? seatPosition,
    String? sportEquipmentName,
    String? insuranceName,
  }) =>
      Baggage(
        surName: surName ?? this.surName,
        givenName: givenName ?? this.givenName,
        title: title ?? this.title,
        baggageName: baggageName ?? this.baggageName,
        amount: amount ?? this.amount,
        quantity: quantity ?? this.quantity,
        currency: currency ?? this.currency,
        departReturn: departReturn ?? this.departReturn,
        seatPosition: seatPosition ?? this.seatPosition,
        sportEquipmentName: sportEquipmentName ?? this.sportEquipmentName,
        insuranceSSRName : insuranceName ?? insuranceSSRName,
      );
}

@JsonSerializable()
class FareAndBundleDetail extends Equatable {
  factory FareAndBundleDetail.fromJson(Map<String, dynamic> json) =>
      _$FareAndBundleDetailFromJson(json);

  Map<String, dynamic> toJson() => _$FareAndBundleDetailToJson(this);

  const FareAndBundleDetail({
    this.totalAmount,
    this.fareAndBundles,
    this.fareAndBundleCount
  });

  @override
  List<Object?> get props => [
        totalAmount,
        fareAndBundles,
    fareAndBundleCount
      ];

  final num? totalAmount;
  final num? fareAndBundleCount;

  final List<FareAndBundle>? fareAndBundles;

  FareAndBundleDetail copyWith({
    num? totalAmount,
    List<FareAndBundle>? fareAndBundles,
    num? fareAndBundleCount
  }) =>
      FareAndBundleDetail(
        totalAmount: totalAmount ?? this.totalAmount,
        fareAndBundles: fareAndBundles ?? this.fareAndBundles,
        fareAndBundleCount: fareAndBundleCount ?? this.fareAndBundleCount,
      );
}

@JsonSerializable()
class FareAndBundle extends Equatable {
  factory FareAndBundle.fromJson(Map<String, dynamic> json) =>
      _$FareAndBundleFromJson(json);

  Map<String, dynamic> toJson() => _$FareAndBundleToJson(this);

  const FareAndBundle({
    this.surName,
    this.givenName,
    this.title,
    this.fareAmount,
    this.currency,
    this.quantity,
    this.bundleItems,
  });

  @override
  List<Object?> get props => [
        surName,
        givenName,
        title,
        fareAmount,
        currency,
        quantity,
        bundleItems,
      ];

  final String? surName;
  final String? givenName;
  final String? title;
   String? get titleToShow {

     if(title != null) {

       return title!.capitalize();
     }
     return null;
  }

  final num? fareAmount;
  final String? currency;
  final num? quantity;
  final List<BundleItem>? bundleItems;

  FareAndBundle copyWith({
    String? surName,
    String? givenName,
    String? title,
    num? fareAmount,
    String? currency,
    num? quantity,
    List<BundleItem>? bundleItems,
  }) =>
      FareAndBundle(
        surName: surName ?? this.surName,
        givenName: givenName ?? this.givenName,
        title: title ?? this.title,
        fareAmount: fareAmount ?? this.fareAmount,
        currency: currency ?? this.currency,
        quantity: quantity ?? this.quantity,
        bundleItems: bundleItems ?? this.bundleItems,
      );
}

@JsonSerializable()
class BundleItem extends Equatable {
  factory BundleItem.fromJson(Map<String, dynamic> json) =>
      _$BundleItemFromJson(json);

  Map<String, dynamic> toJson() => _$BundleItemToJson(this);

  const BundleItem({
    this.bundleName,
    this.bundleAmount,
    this.bundleQuantity,
    this.currency,
    this.departReturn,
  });

  @override
  List<Object?> get props => [
        bundleName,
        bundleAmount,
        bundleQuantity,
        currency,
        departReturn,
      ];

  final String? bundleName;
  final num? bundleAmount;
  final num? bundleQuantity;
  final String? currency;
  final String? departReturn;

  BundleItem copyWith({
    String? bundleName,
    num? bundleAmount,
    num? bundleQuantity,
    String? currency,
    String? departReturn,
  }) =>
      BundleItem(
        bundleName: bundleName ?? this.bundleName,
        bundleAmount: bundleAmount ?? this.bundleAmount,
        bundleQuantity: bundleQuantity ?? this.bundleQuantity,
        currency: currency ?? this.currency,
        departReturn: departReturn ?? this.departReturn,
      );
}

@JsonSerializable()
class FlightBooking extends Equatable {
  factory FlightBooking.fromJson(Map<String, dynamic> json) =>
      _$FlightBookingFromJson(json);

  Map<String, dynamic> toJson() => _$FlightBookingToJson(this);

  const FlightBooking({
    this.bookingId,
    this.superPNRID,
    this.superPNRNo,
    this.orderId,
    this.supplierCode,
    this.bookingNo,
    this.bookingTypeCode,
    this.ticketNumber,
    this.bookingStatusCode,
    this.currencyCode,
    this.createDateTime,
    this.lastUpdateDateTime,
    this.bookingExpiryDate,
    this.bookingExpiryDateFreeText,
    this.userId,
    this.origin,
    this.destination,
    this.isReturn,
    this.isDomesticFlight,
    this.isBookingItinenarySent,
    this.totalStopInbound,
    this.totalStopOutbound,
    this.totalElapsedTimeInbound,
    this.totalElapsedTimeOutbound,
    this.bookingServiceFee,
    this.gstAmt,
    this.markupAmt,
    this.sourceTotalPrice,
    this.totalBookingAmt,
    this.discountAmt,
    this.isCreditUsed,
    this.creditAmount,
    this.queuePcc,
    this.queueNumber,
    this.ticketingQueueNo,
    this.supplierBookingNo,
    this.isCheck,
    this.remark,
    this.createdById,
    this.createdDate,
    this.createdDateUTC,
    this.modifiedById,
    this.modifiedDate,
    this.modifiedDateUTC,
  });

  @override
  List<Object?> get props => [
        bookingId,
        superPNRID,
        superPNRNo,
        orderId,
        supplierCode,
        bookingNo,
        bookingTypeCode,
        ticketNumber,
        bookingStatusCode,
        currencyCode,
        createDateTime,
        lastUpdateDateTime,
        bookingExpiryDate,
        bookingExpiryDateFreeText,
        userId,
        origin,
        destination,
        isReturn,
        isDomesticFlight,
        isBookingItinenarySent,
        totalStopInbound,
        totalStopOutbound,
        totalElapsedTimeInbound,
        totalElapsedTimeOutbound,
        bookingServiceFee,
        gstAmt,
        markupAmt,
        sourceTotalPrice,
        totalBookingAmt,
        discountAmt,
        isCreditUsed,
        creditAmount,
        queuePcc,
        queueNumber,
        ticketingQueueNo,
        supplierBookingNo,
        isCheck,
        remark,
        createdById,
        createdDate,
        createdDateUTC,
        modifiedById,
        modifiedDate,
        modifiedDateUTC,
      ];

  final num? bookingId;
  final num? superPNRID;
  final String? superPNRNo;
  final num? orderId;
  final String? supplierCode;
  final String? bookingNo;
  final String? bookingTypeCode;
  final String? ticketNumber;
  final String? bookingStatusCode;
  final String? currencyCode;
  final DateTime? createDateTime;
  final DateTime? lastUpdateDateTime;
  final DateTime? bookingExpiryDate;
  final String? bookingExpiryDateFreeText;
  final num? userId;
  final String? origin;
  final String? destination;
  final bool? isReturn;
  final bool? isDomesticFlight;
  final bool? isBookingItinenarySent;
  final num? totalStopInbound;
  final num? totalStopOutbound;
  final num? totalElapsedTimeInbound;
  final num? totalElapsedTimeOutbound;
  final num? bookingServiceFee;
  final num? gstAmt;
  final num? markupAmt;
  final num? sourceTotalPrice;
  final num? totalBookingAmt;
  final num? discountAmt;
  final bool? isCreditUsed;
  final num? creditAmount;
  final String? queuePcc;
  final num? queueNumber;
  final num? ticketingQueueNo;
  final String? supplierBookingNo;
  final bool? isCheck;
  final String? remark;
  final num? createdById;
  final DateTime? createdDate;
  final DateTime? createdDateUTC;
  final num? modifiedById;
  final DateTime? modifiedDate;
  final DateTime? modifiedDateUTC;

  FlightBooking copyWith({
    num? bookingId,
    num? superPNRID,
    String? superPNRNo,
    num? orderId,
    String? supplierCode,
    String? bookingNo,
    String? bookingTypeCode,
    String? ticketNumber,
    String? bookingStatusCode,
    String? currencyCode,
    DateTime? createDateTime,
    DateTime? lastUpdateDateTime,
    DateTime? bookingExpiryDate,
    String? bookingExpiryDateFreeText,
    num? userId,
    String? origin,
    String? destination,
    bool? isReturn,
    bool? isDomesticFlight,
    bool? isBookingItinenarySent,
    num? totalStopInbound,
    num? totalStopOutbound,
    num? totalElapsedTimeInbound,
    num? totalElapsedTimeOutbound,
    num? bookingServiceFee,
    num? gstAmt,
    num? markupAmt,
    num? sourceTotalPrice,
    num? totalBookingAmt,
    num? discountAmt,
    bool? isCreditUsed,
    num? creditAmount,
    String? queuePcc,
    num? queueNumber,
    num? ticketingQueueNo,
    String? supplierBookingNo,
    bool? isCheck,
    String? remark,
    num? createdById,
    DateTime? createdDate,
    DateTime? createdDateUTC,
    num? modifiedById,
    DateTime? modifiedDate,
    DateTime? modifiedDateUTC,
  }) =>
      FlightBooking(
        bookingId: bookingId ?? this.bookingId,
        superPNRID: superPNRID ?? this.superPNRID,
        superPNRNo: superPNRNo ?? this.superPNRNo,
        orderId: orderId ?? this.orderId,
        supplierCode: supplierCode ?? this.supplierCode,
        bookingNo: bookingNo ?? this.bookingNo,
        bookingTypeCode: bookingTypeCode ?? this.bookingTypeCode,
        ticketNumber: ticketNumber ?? this.ticketNumber,
        bookingStatusCode: bookingStatusCode ?? this.bookingStatusCode,
        currencyCode: currencyCode ?? this.currencyCode,
        createDateTime: createDateTime ?? this.createDateTime,
        lastUpdateDateTime: lastUpdateDateTime ?? this.lastUpdateDateTime,
        bookingExpiryDate: bookingExpiryDate ?? this.bookingExpiryDate,
        bookingExpiryDateFreeText:
            bookingExpiryDateFreeText ?? this.bookingExpiryDateFreeText,
        userId: userId ?? this.userId,
        origin: origin ?? this.origin,
        destination: destination ?? this.destination,
        isReturn: isReturn ?? this.isReturn,
        isDomesticFlight: isDomesticFlight ?? this.isDomesticFlight,
        isBookingItinenarySent:
            isBookingItinenarySent ?? this.isBookingItinenarySent,
        totalStopInbound: totalStopInbound ?? this.totalStopInbound,
        totalStopOutbound: totalStopOutbound ?? this.totalStopOutbound,
        totalElapsedTimeInbound:
            totalElapsedTimeInbound ?? this.totalElapsedTimeInbound,
        totalElapsedTimeOutbound:
            totalElapsedTimeOutbound ?? this.totalElapsedTimeOutbound,
        bookingServiceFee: bookingServiceFee ?? this.bookingServiceFee,
        gstAmt: gstAmt ?? this.gstAmt,
        markupAmt: markupAmt ?? this.markupAmt,
        sourceTotalPrice: sourceTotalPrice ?? this.sourceTotalPrice,
        totalBookingAmt: totalBookingAmt ?? this.totalBookingAmt,
        discountAmt: discountAmt ?? this.discountAmt,
        isCreditUsed: isCreditUsed ?? this.isCreditUsed,
        creditAmount: creditAmount ?? this.creditAmount,
        queuePcc: queuePcc ?? this.queuePcc,
        queueNumber: queueNumber ?? this.queueNumber,
        ticketingQueueNo: ticketingQueueNo ?? this.ticketingQueueNo,
        supplierBookingNo: supplierBookingNo ?? this.supplierBookingNo,
        isCheck: isCheck ?? this.isCheck,
        remark: remark ?? this.remark,
        createdById: createdById ?? this.createdById,
        createdDate: createdDate ?? this.createdDate,
        createdDateUTC: createdDateUTC ?? this.createdDateUTC,
        modifiedById: modifiedById ?? this.modifiedById,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        modifiedDateUTC: modifiedDateUTC ?? this.modifiedDateUTC,
      );
}

@JsonSerializable()
class FlightSegment extends Equatable {
  factory FlightSegment.fromJson(Map<String, dynamic> json) =>
      _$FlightSegmentFromJson(json);

  Map<String, dynamic> toJson() => _$FlightSegmentToJson(this);

  const FlightSegment({
    this.outbound,
    this.inbound,
  });

  @override
  List<Object?> get props => [
        outbound,
        inbound,
      ];

  final List<Bound>? outbound;
  final List<Bound>? inbound;

  FlightSegment copyWith({
    List<Bound>? outbound,
    List<Bound>? inbound,
  }) =>
      FlightSegment(
        outbound: outbound ?? this.outbound,
        inbound: inbound ?? this.inbound,
      );
}

@JsonSerializable()
class Bound extends Equatable {
  factory Bound.fromJson(Map<String, dynamic> json) => _$BoundFromJson(json);

  Map<String, dynamic> toJson() => _$BoundToJson(this);

  const Bound({
    this.flightSegmentId,
    this.bookingId,
    this.airlineCode,
    this.fareBasisCode,
    this.cabinTypeCode,
    this.airEquipType,
    this.airMilesFlown,
    this.operatingCode,
    this.operatingNumber,
    this.arrivalAirportLocationCode,
    this.arrivalAirportLocationName,
    this.arrivalAirportTerminalId,
    this.arrivalDateTime,
    this.connectionInd,
    this.departureAirportLocationCode,
    this.departureAirportLocationName,
    this.departureAirportTerminalId,
    this.departureDateTime,
    this.eTicket,
    this.duration,
    this.elapsedTime,
    this.flightNumber,
    this.marriageGroup,
    this.numberInParty,
    this.resBookDesigCode,
    this.segmentNumber,
    this.smokingAllowed,
    this.specialMeal,
    this.status,
    this.stopQuantity,
    this.supplierRefId,
    this.seatNumber,
    this.aircraftType,
    this.aircraftDescription,
    this.updatedArrivalDateTime,
    this.updatedDepartureDateTime,
    this.segmentOrder,
    this.createdById,
    this.createdDate,
    this.createdDateUTC,
    this.modifiedById,
    this.modifiedDate,
    this.modifiedDateUTC,
  });

  @override
  List<Object?> get props => [
        flightSegmentId,
        bookingId,
        airlineCode,
        fareBasisCode,
        cabinTypeCode,
        airEquipType,
        airMilesFlown,
        operatingCode,
        operatingNumber,
        arrivalAirportLocationCode,
        arrivalAirportLocationName,
        arrivalAirportTerminalId,
        arrivalDateTime,
        connectionInd,
        departureAirportLocationCode,
        departureAirportLocationName,
        departureAirportTerminalId,
        departureDateTime,
        eTicket,
        duration,
        elapsedTime,
        flightNumber,
        marriageGroup,
        numberInParty,
        resBookDesigCode,
        segmentNumber,
        smokingAllowed,
        specialMeal,
        status,
        stopQuantity,
        supplierRefId,
        seatNumber,
        aircraftType,
        aircraftDescription,
        updatedArrivalDateTime,
        updatedDepartureDateTime,
        segmentOrder,
        createdById,
        createdDate,
        createdDateUTC,
        modifiedById,
        modifiedDate,
        modifiedDateUTC,
      ];

  final num? flightSegmentId;
  final num? bookingId;
  final String? airlineCode;
  final String? fareBasisCode;
  final String? cabinTypeCode;
  final String? airEquipType;
  final num? airMilesFlown;
  final String? operatingCode;
  final String? operatingNumber;
  final String? arrivalAirportLocationCode;
  final String? arrivalAirportLocationName;
  final String? arrivalAirportTerminalId;
  final DateTime? arrivalDateTime;
  final String? connectionInd;
  final String? departureAirportLocationCode;
  final String? departureAirportLocationName;
  final String? departureAirportTerminalId;
  final DateTime? departureDateTime;
  final bool? eTicket;
  final num? duration;
  final num? elapsedTime;
  final num? flightNumber;
  final String? marriageGroup;
  final num? numberInParty;
  final String? resBookDesigCode;
  final num? segmentNumber;
  final bool? smokingAllowed;
  final bool? specialMeal;
  final String? status;
  final num? stopQuantity;
  final String? supplierRefId;
  final String? seatNumber;
  final String? aircraftType;
  final String? aircraftDescription;
  final DateTime? updatedArrivalDateTime;
  final DateTime? updatedDepartureDateTime;
  final String? segmentOrder;
  final num? createdById;
  final DateTime? createdDate;
  final DateTime? createdDateUTC;
  final num? modifiedById;
  final DateTime? modifiedDate;
  final DateTime? modifiedDateUTC;

  Bound copyWith({
    num? flightSegmentId,
    num? bookingId,
    String? airlineCode,
    String? fareBasisCode,
    String? cabinTypeCode,
    String? airEquipType,
    num? airMilesFlown,
    String? operatingCode,
    String? operatingNumber,
    String? arrivalAirportLocationCode,
    String? arrivalAirportLocationName,
    String? arrivalAirportTerminalId,
    DateTime? arrivalDateTime,
    String? connectionInd,
    String? departureAirportLocationCode,
    String? departureAirportLocationName,
    String? departureAirportTerminalId,
    DateTime? departureDateTime,
    bool? eTicket,
    num? duration,
    num? elapsedTime,
    num? flightNumber,
    String? marriageGroup,
    num? numberInParty,
    String? resBookDesigCode,
    num? segmentNumber,
    bool? smokingAllowed,
    bool? specialMeal,
    String? status,
    num? stopQuantity,
    String? supplierRefId,
    String? seatNumber,
    String? aircraftType,
    String? aircraftDescription,
    DateTime? updatedArrivalDateTime,
    DateTime? updatedDepartureDateTime,
    String? segmentOrder,
    num? createdById,
    DateTime? createdDate,
    DateTime? createdDateUTC,
    num? modifiedById,
    DateTime? modifiedDate,
    DateTime? modifiedDateUTC,
  }) =>
      Bound(
        flightSegmentId: flightSegmentId ?? this.flightSegmentId,
        bookingId: bookingId ?? this.bookingId,
        airlineCode: airlineCode ?? this.airlineCode,
        fareBasisCode: fareBasisCode ?? this.fareBasisCode,
        cabinTypeCode: cabinTypeCode ?? this.cabinTypeCode,
        airEquipType: airEquipType ?? this.airEquipType,
        airMilesFlown: airMilesFlown ?? this.airMilesFlown,
        operatingCode: operatingCode ?? this.operatingCode,
        operatingNumber: operatingNumber ?? this.operatingNumber,
        arrivalAirportLocationCode:
            arrivalAirportLocationCode ?? this.arrivalAirportLocationCode,
        arrivalAirportLocationName:
            arrivalAirportLocationName ?? this.arrivalAirportLocationName,
        arrivalAirportTerminalId:
            arrivalAirportTerminalId ?? this.arrivalAirportTerminalId,
        arrivalDateTime: arrivalDateTime ?? this.arrivalDateTime,
        connectionInd: connectionInd ?? this.connectionInd,
        departureAirportLocationCode:
            departureAirportLocationCode ?? this.departureAirportLocationCode,
        departureAirportLocationName:
            departureAirportLocationName ?? this.departureAirportLocationName,
        departureAirportTerminalId:
            departureAirportTerminalId ?? this.departureAirportTerminalId,
        departureDateTime: departureDateTime ?? this.departureDateTime,
        eTicket: eTicket ?? this.eTicket,
        duration: duration ?? this.duration,
        elapsedTime: elapsedTime ?? this.elapsedTime,
        flightNumber: flightNumber ?? this.flightNumber,
        marriageGroup: marriageGroup ?? this.marriageGroup,
        numberInParty: numberInParty ?? this.numberInParty,
        resBookDesigCode: resBookDesigCode ?? this.resBookDesigCode,
        segmentNumber: segmentNumber ?? this.segmentNumber,
        smokingAllowed: smokingAllowed ?? this.smokingAllowed,
        specialMeal: specialMeal ?? this.specialMeal,
        status: status ?? this.status,
        stopQuantity: stopQuantity ?? this.stopQuantity,
        supplierRefId: supplierRefId ?? this.supplierRefId,
        seatNumber: seatNumber ?? this.seatNumber,
        aircraftType: aircraftType ?? this.aircraftType,
        aircraftDescription: aircraftDescription ?? this.aircraftDescription,
        updatedArrivalDateTime:
            updatedArrivalDateTime ?? this.updatedArrivalDateTime,
        updatedDepartureDateTime:
            updatedDepartureDateTime ?? this.updatedDepartureDateTime,
        segmentOrder: segmentOrder ?? this.segmentOrder,
        createdById: createdById ?? this.createdById,
        createdDate: createdDate ?? this.createdDate,
        createdDateUTC: createdDateUTC ?? this.createdDateUTC,
        modifiedById: modifiedById ?? this.modifiedById,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        modifiedDateUTC: modifiedDateUTC ?? this.modifiedDateUTC,
      );
}

@JsonSerializable()
class MealDetail extends Equatable {
  factory MealDetail.fromJson(Map<String, dynamic> json) =>
      _$MealDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MealDetailToJson(this);

  const MealDetail({
    this.totalAmount,
    this.meals,
    this.mealCount,
  });

  bool get noMealsSelected {

    for(Meal currentItem in meals ?? []) {
      if((currentItem.mealList ?? []).isNotEmpty){
        return false;
      }
    }
    return true;

  }
  @override
  List<Object?> get props => [
        totalAmount,
        meals,
    mealCount,
      ];

  final num? totalAmount;
  final num? mealCount;

  final List<Meal>? meals;

  MealDetail copyWith({
    num? totalAmount,
    List<Meal>? meals,
    num? mealCount
  }) =>
      MealDetail(
        totalAmount: totalAmount ?? this.totalAmount,
        meals: meals ?? this.meals,
          mealCount : mealCount ?? this.mealCount
      );
}

@JsonSerializable()
class Meal extends Equatable {
  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);

  Map<String, dynamic> toJson() => _$MealToJson(this);

  const Meal({
    this.surName,
    this.givenName,
    this.title,
    this.mealList,
  });

  @override
  List<Object?> get props => [
        surName,
        givenName,
        title,
        mealList,
      ];

  final String? surName;
  final String? givenName;
  final String? title;
  final List<MealList>? mealList;
  String? get titleToShow {

    if(title != null) {

      return title!.capitalize();
    }
    return null;
  }

  Meal copyWith({
    String? surName,
    String? givenName,
    String? title,
    List<MealList>? mealList,
  }) =>
      Meal(
        surName: surName ?? this.surName,
        givenName: givenName ?? this.givenName,
        title: title ?? this.title,
        mealList: mealList ?? this.mealList,
      );
}

@JsonSerializable()
class MealList extends Equatable {
  factory MealList.fromJson(Map<String, dynamic> json) =>
      _$MealListFromJson(json);

  Map<String, dynamic> toJson() => _$MealListToJson(this);

  const MealList({
    this.mealName,
    this.amount,
    this.currency,
    this.quantity,
    this.departReturn,
  });

  @override
  List<Object?> get props => [
        mealName,
        amount,
        currency,
        quantity,
        departReturn,
      ];

  final String? mealName;
  final num? amount;
  final String? currency;
  final num? quantity;
  final String? departReturn;

  MealList copyWith({
    String? mealName,
    num? amount,
    String? currency,
    num? quantity,
    String? departReturn,
  }) =>
      MealList(
        mealName: mealName ?? this.mealName,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        quantity: quantity ?? this.quantity,
        departReturn: departReturn ?? this.departReturn,
      );
}

@JsonSerializable()
class Passenger extends Equatable {
  factory Passenger.fromJson(Map<String, dynamic> json) =>
      _$PassengerFromJson(json);

  Map<String, dynamic> toJson() => _$PassengerToJson(this);

  PeopleType? get getType => PeopleType.values
      .firstWhereOrNull((element) => element.code == passengerType);

  const Passenger({
    this.paxId,
    this.bookingId,
    this.ticketIssueDate,
    this.givenName,
    this.surname,
    this.passengerType,
    this.dob,
    this.nationality,
    this.passport,
    this.passportExpiryDate,
    this.titleCode,
    this.myRewardMemberId,
    this.createdById,
    this.createdDate,
    this.createdDateUTC,
    this.modifiedById,
    this.modifiedDate,
    this.modifiedDateUTC,
  });

  @override
  List<Object?> get props => [
        paxId,
        bookingId,
        ticketIssueDate,
        givenName,
        surname,
        passengerType,
        dob,
        nationality,
        passport,
        passportExpiryDate,
        titleCode,
        myRewardMemberId,
        createdById,
        createdDate,
        createdDateUTC,
        modifiedById,
        modifiedDate,
        modifiedDateUTC,
      ];

  final num? paxId;
  final num? bookingId;
  final DateTime? ticketIssueDate;
  final String? givenName;
  final String? surname;
  final String? passengerType;
  final DateTime? dob;
  final String? nationality;
  final String? passport;
  final DateTime? passportExpiryDate;
  final String? titleCode;
  String? get titleToShow {

    if(titleCode != null) {

      return titleCode!.capitalize();
    }
    return null;
  }

  final String? myRewardMemberId;
  final num? createdById;
  final DateTime? createdDate;
  final DateTime? createdDateUTC;
  final num? modifiedById;
  final DateTime? modifiedDate;
  final DateTime? modifiedDateUTC;

  Passenger copyWith({
    num? paxId,
    num? bookingId,
    DateTime? ticketIssueDate,
    String? givenName,
    String? surname,
    String? passengerType,
    DateTime? dob,
    String? nationality,
    String? passport,
    DateTime? passportExpiryDate,
    String? titleCode,
    String? myRewardMemberId,
    num? createdById,
    DateTime? createdDate,
    DateTime? createdDateUTC,
    num? modifiedById,
    DateTime? modifiedDate,
    DateTime? modifiedDateUTC,
  }) =>
      Passenger(
        paxId: paxId ?? this.paxId,
        bookingId: bookingId ?? this.bookingId,
        ticketIssueDate: ticketIssueDate ?? this.ticketIssueDate,
        givenName: givenName ?? this.givenName,
        surname: surname ?? this.surname,
        passengerType: passengerType ?? this.passengerType,
        dob: dob ?? this.dob,
        nationality: nationality ?? this.nationality,
        passport: passport ?? this.passport,
        passportExpiryDate: passportExpiryDate ?? this.passportExpiryDate,
        titleCode: titleCode ?? this.titleCode,
        myRewardMemberId: myRewardMemberId ?? this.myRewardMemberId,
        createdById: createdById ?? this.createdById,
        createdDate: createdDate ?? this.createdDate,
        createdDateUTC: createdDateUTC ?? this.createdDateUTC,
        modifiedById: modifiedById ?? this.modifiedById,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        modifiedDateUTC: modifiedDateUTC ?? this.modifiedDateUTC,
      );
}

@JsonSerializable()
class PaymentOrder extends Equatable {
  factory PaymentOrder.fromJson(Map<String, dynamic> json) =>
      _$PaymentOrderFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentOrderToJson(this);

  const PaymentOrder({
    this.paymentId,
    this.orderId,
    this.paymentDate,
    this.paymentMethodCode,
    this.paymentStatusCode,
    this.requeryStatusCode,
    this.currencyCode,
    this.paymentAmount,
    this.cardOption,
    this.hasError,
    this.paymentRefNo,
    this.paymentTransactionId,
    this.createdById,
    this.createdDate,
    this.createdDateUTC,
    this.modifiedById,
    this.modifiedDate,
    this.modifiedDateUTC,
    this.cardNumber,
  });

  @override
  List<Object?> get props => [
        paymentId,
        orderId,
        paymentDate,
        paymentMethodCode,
        paymentStatusCode,
        requeryStatusCode,
        cardOption,
        currencyCode,
        paymentAmount,
        hasError,
        paymentRefNo,
        paymentTransactionId,
        createdById,
        createdDate,
        createdDateUTC,
        modifiedById,
        modifiedDate,
        modifiedDateUTC,
    cardNumber,
      ];

  final num? paymentId;
  final num? orderId;
  final DateTime? paymentDate;
  final String? paymentMethodCode;
  final String? paymentStatusCode;
  final String? requeryStatusCode;
  final String? cardOption;
  final String? cardNumber;
  final String? currencyCode;
  final num? paymentAmount;
  final bool? hasError;
  final String? paymentRefNo;
  final String? paymentTransactionId;
  final num? createdById;
  final DateTime? createdDate;
  final DateTime? createdDateUTC;
  final num? modifiedById;
  final DateTime? modifiedDate;
  final DateTime? modifiedDateUTC;

  PaymentOrder copyWith({
    num? paymentId,
    num? orderId,
    DateTime? paymentDate,
    String? paymentMethodCode,
    String? paymentStatusCode,
    String? requeryStatusCode,
    String? currencyCode,
    String? cardNumber,
    num? paymentAmount,
    String? cardOption,
    bool? hasError,
    String? paymentRefNo,
    String? paymentTransactionId,
    num? createdById,
    DateTime? createdDate,
    DateTime? createdDateUTC,
    num? modifiedById,
    DateTime? modifiedDate,
    DateTime? modifiedDateUTC,
  }) =>
      PaymentOrder(
        cardOption: cardOption ?? this.cardOption,
        paymentId: paymentId ?? this.paymentId,
        orderId: orderId ?? this.orderId,
        paymentDate: paymentDate ?? this.paymentDate,
        paymentMethodCode: paymentMethodCode ?? this.paymentMethodCode,
        paymentStatusCode: paymentStatusCode ?? this.paymentStatusCode,
        requeryStatusCode: requeryStatusCode ?? this.requeryStatusCode,
        currencyCode: currencyCode ?? this.currencyCode,
        paymentAmount: paymentAmount ?? this.paymentAmount,
        hasError: hasError ?? this.hasError,
        paymentRefNo: paymentRefNo ?? this.paymentRefNo,
        paymentTransactionId: paymentTransactionId ?? this.paymentTransactionId,
        createdById: createdById ?? this.createdById,
        createdDate: createdDate ?? this.createdDate,
        createdDateUTC: createdDateUTC ?? this.createdDateUTC,
        modifiedById: modifiedById ?? this.modifiedById,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        modifiedDateUTC: modifiedDateUTC ?? this.modifiedDateUTC,
          cardNumber : cardNumber ?? this.cardNumber,
      );
}

@JsonSerializable()
class SeatDetail extends Equatable {
  factory SeatDetail.fromJson(Map<String, dynamic> json) =>
      _$SeatDetailFromJson(json);

  Map<String, dynamic> toJson() => _$SeatDetailToJson(this);

  const SeatDetail({
    this.totalAmount,
    this.seats,
    this.seatCount,
  });

  @override
  List<Object?> get props => [
        totalAmount,
        seats,
    seatCount,
      ];

  final num? seatCount;

  final num? totalAmount;
  final List<Baggage>? seats;

  SeatDetail copyWith({
    num? totalAmount,
    List<Baggage>? seats,
     num? seatCount,
  }) =>
      SeatDetail(
        totalAmount: totalAmount ?? this.totalAmount,
        seats: seats ?? this.seats,
        seatCount: seatCount ?? this.seatCount,

      );
}

@JsonSerializable()
class SuperPNR extends Equatable {
  factory SuperPNR.fromJson(Map<String, dynamic> json) =>
      _$SuperPNRFromJson(json);

  Map<String, dynamic> toJson() => _$SuperPNRToJson(this);

  const SuperPNR({
    this.superPNRID,
    this.superPNRNo,
    this.channelTypeCode,
    this.bookingDate,
    this.userId,
    this.validDateFrom,
    this.validDateTo,
    this.isActive,
    this.createdById,
    this.createdDate,
    this.createdDateUTC,
    this.modifiedById,
    this.modifiedDate,
    this.modifiedDateUTC,
  });

  @override
  List<Object?> get props => [
        superPNRID,
        superPNRNo,
        channelTypeCode,
        bookingDate,
        userId,
        validDateFrom,
        validDateTo,
        isActive,
        createdById,
        createdDate,
        createdDateUTC,
        modifiedById,
        modifiedDate,
        modifiedDateUTC,
      ];

  final num? superPNRID;
  final String? superPNRNo;
  final String? channelTypeCode;
  final DateTime? bookingDate;
  final num? userId;
  final DateTime? validDateFrom;
  final DateTime? validDateTo;
  final bool? isActive;
  final num? createdById;
  final DateTime? createdDate;
  final DateTime? createdDateUTC;
  final num? modifiedById;
  final DateTime? modifiedDate;
  final DateTime? modifiedDateUTC;

  SuperPNR copyWith({
    num? superPNRID,
    String? superPNRNo,
    String? channelTypeCode,
    DateTime? bookingDate,
    num? userId,
    DateTime? validDateFrom,
    DateTime? validDateTo,
    bool? isActive,
    num? createdById,
    DateTime? createdDate,
    DateTime? createdDateUTC,
    num? modifiedById,
    DateTime? modifiedDate,
    DateTime? modifiedDateUTC,
  }) =>
      SuperPNR(
        superPNRID: superPNRID ?? this.superPNRID,
        superPNRNo: superPNRNo ?? this.superPNRNo,
        channelTypeCode: channelTypeCode ?? this.channelTypeCode,
        bookingDate: bookingDate ?? this.bookingDate,
        userId: userId ?? this.userId,
        validDateFrom: validDateFrom ?? this.validDateFrom,
        validDateTo: validDateTo ?? this.validDateTo,
        isActive: isActive ?? this.isActive,
        createdById: createdById ?? this.createdById,
        createdDate: createdDate ?? this.createdDate,
        createdDateUTC: createdDateUTC ?? this.createdDateUTC,
        modifiedById: modifiedById ?? this.modifiedById,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        modifiedDateUTC: modifiedDateUTC ?? this.modifiedDateUTC,
      );
}

@JsonSerializable()
class SuperPNROrder extends Equatable {
  factory SuperPNROrder.fromJson(Map<String, dynamic> json) =>
      _$SuperPNROrderFromJson(json);

  Map<String, dynamic> toJson() => _$SuperPNROrderToJson(this);

  const SuperPNROrder({
    this.orderId,
    this.superPNRID,
    this.affiliationId,
    this.orderNo,
    this.bookingTypeCode,
    this.bookingStatusCode,
    this.isDynamic,
    this.isFixed,
    this.currencyCode,
    this.gstAmt,
    this.markupAmt,
    this.sourceTotalPrice,
    this.totalBookingAmt,
    this.voucherCode,
    this.voucherDiscountAmt,
    this.discountAmt,
    this.isCreditUsed,
    this.creditAmount,
    this.instantDiscountAmt,
    this.affiliationRef,
    this.rebateInfo,
    this.createdById,
    this.createdDate,
    this.createdDateUTC,
    this.modifiedById,
    this.modifiedDate,
    this.modifiedDateUTC,
  });

  @override
  List<Object?> get props => [
        orderId,
        superPNRID,
        affiliationId,
        orderNo,
        bookingTypeCode,
        bookingStatusCode,
        isDynamic,
        isFixed,
        currencyCode,
        gstAmt,
        markupAmt,
        sourceTotalPrice,
        totalBookingAmt,
        voucherCode,
        voucherDiscountAmt,
        discountAmt,
        isCreditUsed,
        creditAmount,
        instantDiscountAmt,
        affiliationRef,
        rebateInfo,
        createdById,
        createdDate,
        createdDateUTC,
        modifiedById,
        modifiedDate,
        modifiedDateUTC,
      ];

  final num? orderId;
  final num? superPNRID;
  final num? affiliationId;
  final String? orderNo;
  final String? bookingTypeCode;
  final String? bookingStatusCode;
  final bool? isDynamic;
  final bool? isFixed;
  final String? currencyCode;
  final num? gstAmt;
  final num? markupAmt;
  final num? sourceTotalPrice;
  final num? totalBookingAmt;
  final String? voucherCode;
  final num? voucherDiscountAmt;
  final num? discountAmt;
  final bool? isCreditUsed;
  final num? creditAmount;
  final num? instantDiscountAmt;
  final String? affiliationRef;
  final String? rebateInfo;
  final num? createdById;
  final DateTime? createdDate;
  final DateTime? createdDateUTC;
  final num? modifiedById;
  final DateTime? modifiedDate;
  final DateTime? modifiedDateUTC;

  SuperPNROrder copyWith({
    num? orderId,
    num? superPNRID,
    num? affiliationId,
    String? orderNo,
    String? bookingTypeCode,
    String? bookingStatusCode,
    bool? isDynamic,
    bool? isFixed,
    String? currencyCode,
    num? gstAmt,
    num? markupAmt,
    num? sourceTotalPrice,
    num? totalBookingAmt,
    String? voucherCode,
    num? voucherDiscountAmt,
    num? discountAmt,
    bool? isCreditUsed,
    num? creditAmount,
    num? instantDiscountAmt,
    String? affiliationRef,
    String? rebateInfo,
    num? createdById,
    DateTime? createdDate,
    DateTime? createdDateUTC,
    num? modifiedById,
    DateTime? modifiedDate,
    DateTime? modifiedDateUTC,
  }) =>
      SuperPNROrder(
        orderId: orderId ?? this.orderId,
        superPNRID: superPNRID ?? this.superPNRID,
        affiliationId: affiliationId ?? this.affiliationId,
        orderNo: orderNo ?? this.orderNo,
        bookingTypeCode: bookingTypeCode ?? this.bookingTypeCode,
        bookingStatusCode: bookingStatusCode ?? this.bookingStatusCode,
        isDynamic: isDynamic ?? this.isDynamic,
        isFixed: isFixed ?? this.isFixed,
        currencyCode: currencyCode ?? this.currencyCode,
        gstAmt: gstAmt ?? this.gstAmt,
        markupAmt: markupAmt ?? this.markupAmt,
        sourceTotalPrice: sourceTotalPrice ?? this.sourceTotalPrice,
        totalBookingAmt: totalBookingAmt ?? this.totalBookingAmt,
        voucherCode: voucherCode ?? this.voucherCode,
        voucherDiscountAmt: voucherDiscountAmt ?? this.voucherDiscountAmt,
        discountAmt: discountAmt ?? this.discountAmt,
        isCreditUsed: isCreditUsed ?? this.isCreditUsed,
        creditAmount: creditAmount ?? this.creditAmount,
        instantDiscountAmt: instantDiscountAmt ?? this.instantDiscountAmt,
        affiliationRef: affiliationRef ?? this.affiliationRef,
        rebateInfo: rebateInfo ?? this.rebateInfo,
        createdById: createdById ?? this.createdById,
        createdDate: createdDate ?? this.createdDate,
        createdDateUTC: createdDateUTC ?? this.createdDateUTC,
        modifiedById: modifiedById ?? this.modifiedById,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        modifiedDateUTC: modifiedDateUTC ?? this.modifiedDateUTC,
      );
}

@JsonSerializable()
class SportsEquipmentDetail extends Equatable {
  factory SportsEquipmentDetail.fromJson(Map<String, dynamic> json) =>
      _$SportsEquipmentDetailFromJson(json);

  Map<String, dynamic> toJson() => _$SportsEquipmentDetailToJson(this);

  const SportsEquipmentDetail({
    this.totalAmount,
    this.sportEquipments,
    this.sportEquipmentCount,
  });

  @override
  List<Object?> get props => [
        totalAmount,
    sportEquipments,
    sportEquipmentCount,
      ];

  final num? totalAmount;
  final num? sportEquipmentCount;
  final List<Baggage>? sportEquipments;

  SportsEquipmentDetail copyWith({
    num? totalAmount,
    List<Baggage>? sportEquipments,
    num? sportEquipmentCount,
  }) =>
      SportsEquipmentDetail(
        totalAmount: totalAmount ?? this.totalAmount,
        sportEquipments: sportEquipments ?? this.sportEquipments,
        sportEquipmentCount: sportEquipmentCount ?? this.sportEquipmentCount,

      );
}

@JsonSerializable()
class InsuranceDetails extends Equatable {
  factory InsuranceDetails.fromJson(Map<String, dynamic> json) =>
      _$InsuranceDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$InsuranceDetailsToJson(this);

  const InsuranceDetails({
    this.totalAmount,
    this.insuranceSSRs,
    this.insuranceSSRCount
  });

  @override
  List<Object?> get props => [
    totalAmount,
    insuranceSSRs,
    insuranceSSRCount
  ];

  final num? totalAmount;
  final List<Baggage>? insuranceSSRs;
  final num? insuranceSSRCount;


  InsuranceDetails copyWith({
    num? totalAmount,
    List<Baggage>? insuranceSSRs,
    num? insuranceSSRCount

  }) =>
      InsuranceDetails(
        totalAmount: totalAmount ?? this.totalAmount,
        insuranceSSRs: insuranceSSRs ?? this.insuranceSSRs,
        insuranceSSRCount: insuranceSSRCount ?? this.insuranceSSRCount,

      );
}

