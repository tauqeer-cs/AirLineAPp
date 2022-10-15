// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirmation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmationModel _$ConfirmationModelFromJson(Map<String, dynamic> json) =>
    ConfirmationModel(
      value: json['value'] == null
          ? null
          : Value.fromJson(json['value'] as Map<String, dynamic>),
      formatters: json['formatters'] as List<dynamic>?,
      contentTypes: json['contentTypes'] as List<dynamic>?,
      statusCode: json['statusCode'] as num?,
    );

Map<String, dynamic> _$ConfirmationModelToJson(ConfirmationModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('value', instance.value);
  writeNotNull('formatters', instance.formatters);
  writeNotNull('contentTypes', instance.contentTypes);
  writeNotNull('statusCode', instance.statusCode);
  return val;
}

Value _$ValueFromJson(Map<String, dynamic> json) => Value(
      superPNR: json['superPNR'] == null
          ? null
          : SuperPNR.fromJson(json['superPNR'] as Map<String, dynamic>),
      superPNROrder: json['superPNROrder'] == null
          ? null
          : SuperPNROrder.fromJson(
              json['superPNROrder'] as Map<String, dynamic>),
      flightBookings: (json['flightBookings'] as List<dynamic>?)
          ?.map((e) => FlightBooking.fromJson(e as Map<String, dynamic>))
          .toList(),
      passengers: (json['passengers'] as List<dynamic>?)
          ?.map((e) => Passenger.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentOrders: (json['paymentOrders'] as List<dynamic>?)
          ?.map((e) => PaymentOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
      fareAndBundleDetail: json['fareAndBundleDetail'] == null
          ? null
          : FareAndBundleDetail.fromJson(
              json['fareAndBundleDetail'] as Map<String, dynamic>),
      seatDetail: json['seatDetail'] == null
          ? null
          : SeatDetail.fromJson(json['seatDetail'] as Map<String, dynamic>),
      mealDetail: json['mealDetail'] == null
          ? null
          : MealDetail.fromJson(json['mealDetail'] as Map<String, dynamic>),
      baggageDetail: json['baggageDetail'] == null
          ? null
          : BaggageDetail.fromJson(
              json['baggageDetail'] as Map<String, dynamic>),
      flightSegments: (json['flightSegments'] as List<dynamic>?)
          ?.map((e) => FlightSegment.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookingContact: json['bookingContact'] == null
          ? null
          : BookingContact.fromJson(
              json['bookingContact'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ValueToJson(Value instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('superPNR', instance.superPNR);
  writeNotNull('superPNROrder', instance.superPNROrder);
  writeNotNull('flightBookings', instance.flightBookings);
  writeNotNull('passengers', instance.passengers);
  writeNotNull('paymentOrders', instance.paymentOrders);
  writeNotNull('fareAndBundleDetail', instance.fareAndBundleDetail);
  writeNotNull('seatDetail', instance.seatDetail);
  writeNotNull('mealDetail', instance.mealDetail);
  writeNotNull('bookingContact', instance.bookingContact);
  writeNotNull('baggageDetail', instance.baggageDetail);
  writeNotNull('flightSegments', instance.flightSegments);
  return val;
}

BookingContact _$BookingContactFromJson(Map<String, dynamic> json) =>
    BookingContact(
      superPNRID: json['superPNRID'] as num?,
      userId: json['userId'] as num?,
      titleCode: json['titleCode'] as String?,
      givenName: json['givenName'] as String?,
      surname: json['surname'] as String?,
      email: json['email'] as String?,
      phone1: json['phone1'] as String?,
      phone1LocationCode: json['phone1LocationCode'] as String?,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      nationality: json['nationality'] as String?,
      passportExpiryDate: json['passportExpiryDate'] == null
          ? null
          : DateTime.parse(json['passportExpiryDate'] as String),
      emergencyGivenName: json['emergencyGivenName'] as String?,
      emergencySurname: json['emergencySurname'] as String?,
      emergencyEmail: json['emergencyEmail'] as String?,
      emergencyPhone: json['emergencyPhone'] as String?,
      emergencyPhoneCode: json['emergencyPhoneCode'] as String?,
      createdById: json['createdById'] as num?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      createdDateUTC: json['createdDateUTC'] == null
          ? null
          : DateTime.parse(json['createdDateUTC'] as String),
      modifiedById: json['modifiedById'] as num?,
      modifiedDate: json['modifiedDate'] == null
          ? null
          : DateTime.parse(json['modifiedDate'] as String),
      modifiedDateUTC: json['modifiedDateUTC'] == null
          ? null
          : DateTime.parse(json['modifiedDateUTC'] as String),
    );

Map<String, dynamic> _$BookingContactToJson(BookingContact instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('superPNRID', instance.superPNRID);
  writeNotNull('userId', instance.userId);
  writeNotNull('titleCode', instance.titleCode);
  writeNotNull('givenName', instance.givenName);
  writeNotNull('surname', instance.surname);
  writeNotNull('email', instance.email);
  writeNotNull('phone1', instance.phone1);
  writeNotNull('phone1LocationCode', instance.phone1LocationCode);
  writeNotNull('dob', instance.dob?.toIso8601String());
  writeNotNull('nationality', instance.nationality);
  writeNotNull(
      'passportExpiryDate', instance.passportExpiryDate?.toIso8601String());
  writeNotNull('emergencyGivenName', instance.emergencyGivenName);
  writeNotNull('emergencySurname', instance.emergencySurname);
  writeNotNull('emergencyEmail', instance.emergencyEmail);
  writeNotNull('emergencyPhone', instance.emergencyPhone);
  writeNotNull('emergencyPhoneCode', instance.emergencyPhoneCode);
  writeNotNull('createdById', instance.createdById);
  writeNotNull('createdDate', instance.createdDate?.toIso8601String());
  writeNotNull('createdDateUTC', instance.createdDateUTC?.toIso8601String());
  writeNotNull('modifiedById', instance.modifiedById);
  writeNotNull('modifiedDate', instance.modifiedDate?.toIso8601String());
  writeNotNull('modifiedDateUTC', instance.modifiedDateUTC?.toIso8601String());
  return val;
}

BaggageDetail _$BaggageDetailFromJson(Map<String, dynamic> json) =>
    BaggageDetail(
      totalAmount: json['totalAmount'] as num?,
      baggages: (json['baggages'] as List<dynamic>?)
          ?.map((e) => Baggage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BaggageDetailToJson(BaggageDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('totalAmount', instance.totalAmount);
  writeNotNull('baggages', instance.baggages);
  return val;
}

Baggage _$BaggageFromJson(Map<String, dynamic> json) => Baggage(
      surName: json['surName'] as String?,
      givenName: json['givenName'] as String?,
      title: json['title'] as String?,
      baggageName: json['baggageName'] as String?,
      amount: json['amount'] as num?,
      quantity: json['quantity'] as num?,
      currency: json['currency'] as String?,
      departReturn: json['departReturn'] as String?,
      seatPosition: json['seatPosition'] as String?,
    );

Map<String, dynamic> _$BaggageToJson(Baggage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('surName', instance.surName);
  writeNotNull('givenName', instance.givenName);
  writeNotNull('title', instance.title);
  writeNotNull('baggageName', instance.baggageName);
  writeNotNull('amount', instance.amount);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('currency', instance.currency);
  writeNotNull('departReturn', instance.departReturn);
  writeNotNull('seatPosition', instance.seatPosition);
  return val;
}

FareAndBundleDetail _$FareAndBundleDetailFromJson(Map<String, dynamic> json) =>
    FareAndBundleDetail(
      totalAmount: json['totalAmount'] as num?,
      fareAndBundles: (json['fareAndBundles'] as List<dynamic>?)
          ?.map((e) => FareAndBundle.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FareAndBundleDetailToJson(FareAndBundleDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('totalAmount', instance.totalAmount);
  writeNotNull('fareAndBundles', instance.fareAndBundles);
  return val;
}

FareAndBundle _$FareAndBundleFromJson(Map<String, dynamic> json) =>
    FareAndBundle(
      surName: json['surName'] as String?,
      givenName: json['givenName'] as String?,
      title: json['title'] as String?,
      fareAmount: json['fareAmount'] as num?,
      currency: json['currency'] as String?,
      quantity: json['quantity'] as num?,
      bundleItems: (json['bundleItems'] as List<dynamic>?)
          ?.map((e) => BundleItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FareAndBundleToJson(FareAndBundle instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('surName', instance.surName);
  writeNotNull('givenName', instance.givenName);
  writeNotNull('title', instance.title);
  writeNotNull('fareAmount', instance.fareAmount);
  writeNotNull('currency', instance.currency);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('bundleItems', instance.bundleItems);
  return val;
}

BundleItem _$BundleItemFromJson(Map<String, dynamic> json) => BundleItem(
      bundleName: json['bundleName'] as String?,
      bundleAmount: json['bundleAmount'] as num?,
      bundleQuantity: json['bundleQuantity'] as num?,
      currency: json['currency'] as String?,
      departReturn: json['departReturn'] as String?,
    );

Map<String, dynamic> _$BundleItemToJson(BundleItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bundleName', instance.bundleName);
  writeNotNull('bundleAmount', instance.bundleAmount);
  writeNotNull('bundleQuantity', instance.bundleQuantity);
  writeNotNull('currency', instance.currency);
  writeNotNull('departReturn', instance.departReturn);
  return val;
}

FlightBooking _$FlightBookingFromJson(Map<String, dynamic> json) =>
    FlightBooking(
      bookingId: json['bookingId'] as num?,
      superPNRID: json['superPNRID'] as num?,
      superPNRNo: json['superPNRNo'] as String?,
      orderId: json['orderId'] as num?,
      supplierCode: json['supplierCode'] as String?,
      bookingNo: json['bookingNo'] as String?,
      bookingTypeCode: json['bookingTypeCode'] as String?,
      ticketNumber: json['ticketNumber'] as String?,
      bookingStatusCode: json['bookingStatusCode'] as String?,
      currencyCode: json['currencyCode'] as String?,
      createDateTime: json['createDateTime'] == null
          ? null
          : DateTime.parse(json['createDateTime'] as String),
      lastUpdateDateTime: json['lastUpdateDateTime'] == null
          ? null
          : DateTime.parse(json['lastUpdateDateTime'] as String),
      bookingExpiryDate: json['bookingExpiryDate'] == null
          ? null
          : DateTime.parse(json['bookingExpiryDate'] as String),
      bookingExpiryDateFreeText: json['bookingExpiryDateFreeText'] as String?,
      userId: json['userId'] as num?,
      origin: json['origin'] as String?,
      destination: json['destination'] as String?,
      isReturn: json['isReturn'] as bool?,
      isDomesticFlight: json['isDomesticFlight'] as bool?,
      isBookingItinenarySent: json['isBookingItinenarySent'] as bool?,
      totalStopInbound: json['totalStopInbound'] as num?,
      totalStopOutbound: json['totalStopOutbound'] as num?,
      totalElapsedTimeInbound: json['totalElapsedTimeInbound'] as num?,
      totalElapsedTimeOutbound: json['totalElapsedTimeOutbound'] as num?,
      bookingServiceFee: json['bookingServiceFee'] as num?,
      gstAmt: json['gstAmt'] as num?,
      markupAmt: json['markupAmt'] as num?,
      sourceTotalPrice: json['sourceTotalPrice'] as num?,
      totalBookingAmt: json['totalBookingAmt'] as num?,
      discountAmt: json['discountAmt'] as num?,
      isCreditUsed: json['isCreditUsed'] as bool?,
      creditAmount: json['creditAmount'] as num?,
      queuePcc: json['queuePcc'] as String?,
      queueNumber: json['queueNumber'] as num?,
      ticketingQueueNo: json['ticketingQueueNo'] as num?,
      supplierBookingNo: json['supplierBookingNo'] as String?,
      isCheck: json['isCheck'] as bool?,
      remark: json['remark'] as String?,
      createdById: json['createdById'] as num?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      createdDateUTC: json['createdDateUTC'] == null
          ? null
          : DateTime.parse(json['createdDateUTC'] as String),
      modifiedById: json['modifiedById'] as num?,
      modifiedDate: json['modifiedDate'] == null
          ? null
          : DateTime.parse(json['modifiedDate'] as String),
      modifiedDateUTC: json['modifiedDateUTC'] == null
          ? null
          : DateTime.parse(json['modifiedDateUTC'] as String),
    );

Map<String, dynamic> _$FlightBookingToJson(FlightBooking instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('bookingId', instance.bookingId);
  writeNotNull('superPNRID', instance.superPNRID);
  writeNotNull('superPNRNo', instance.superPNRNo);
  writeNotNull('orderId', instance.orderId);
  writeNotNull('supplierCode', instance.supplierCode);
  writeNotNull('bookingNo', instance.bookingNo);
  writeNotNull('bookingTypeCode', instance.bookingTypeCode);
  writeNotNull('ticketNumber', instance.ticketNumber);
  writeNotNull('bookingStatusCode', instance.bookingStatusCode);
  writeNotNull('currencyCode', instance.currencyCode);
  writeNotNull('createDateTime', instance.createDateTime?.toIso8601String());
  writeNotNull(
      'lastUpdateDateTime', instance.lastUpdateDateTime?.toIso8601String());
  writeNotNull(
      'bookingExpiryDate', instance.bookingExpiryDate?.toIso8601String());
  writeNotNull('bookingExpiryDateFreeText', instance.bookingExpiryDateFreeText);
  writeNotNull('userId', instance.userId);
  writeNotNull('origin', instance.origin);
  writeNotNull('destination', instance.destination);
  writeNotNull('isReturn', instance.isReturn);
  writeNotNull('isDomesticFlight', instance.isDomesticFlight);
  writeNotNull('isBookingItinenarySent', instance.isBookingItinenarySent);
  writeNotNull('totalStopInbound', instance.totalStopInbound);
  writeNotNull('totalStopOutbound', instance.totalStopOutbound);
  writeNotNull('totalElapsedTimeInbound', instance.totalElapsedTimeInbound);
  writeNotNull('totalElapsedTimeOutbound', instance.totalElapsedTimeOutbound);
  writeNotNull('bookingServiceFee', instance.bookingServiceFee);
  writeNotNull('gstAmt', instance.gstAmt);
  writeNotNull('markupAmt', instance.markupAmt);
  writeNotNull('sourceTotalPrice', instance.sourceTotalPrice);
  writeNotNull('totalBookingAmt', instance.totalBookingAmt);
  writeNotNull('discountAmt', instance.discountAmt);
  writeNotNull('isCreditUsed', instance.isCreditUsed);
  writeNotNull('creditAmount', instance.creditAmount);
  writeNotNull('queuePcc', instance.queuePcc);
  writeNotNull('queueNumber', instance.queueNumber);
  writeNotNull('ticketingQueueNo', instance.ticketingQueueNo);
  writeNotNull('supplierBookingNo', instance.supplierBookingNo);
  writeNotNull('isCheck', instance.isCheck);
  writeNotNull('remark', instance.remark);
  writeNotNull('createdById', instance.createdById);
  writeNotNull('createdDate', instance.createdDate?.toIso8601String());
  writeNotNull('createdDateUTC', instance.createdDateUTC?.toIso8601String());
  writeNotNull('modifiedById', instance.modifiedById);
  writeNotNull('modifiedDate', instance.modifiedDate?.toIso8601String());
  writeNotNull('modifiedDateUTC', instance.modifiedDateUTC?.toIso8601String());
  return val;
}

FlightSegment _$FlightSegmentFromJson(Map<String, dynamic> json) =>
    FlightSegment(
      outbound: (json['outbound'] as List<dynamic>?)
          ?.map((e) => Bound.fromJson(e as Map<String, dynamic>))
          .toList(),
      inbound: (json['inbound'] as List<dynamic>?)
          ?.map((e) => Bound.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FlightSegmentToJson(FlightSegment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('outbound', instance.outbound);
  writeNotNull('inbound', instance.inbound);
  return val;
}

Bound _$BoundFromJson(Map<String, dynamic> json) => Bound(
      flightSegmentId: json['flightSegmentId'] as num?,
      bookingId: json['bookingId'] as num?,
      airlineCode: json['airlineCode'] as String?,
      fareBasisCode: json['fareBasisCode'] as String?,
      cabinTypeCode: json['cabinTypeCode'] as String?,
      airEquipType: json['airEquipType'] as String?,
      airMilesFlown: json['airMilesFlown'] as num?,
      operatingCode: json['operatingCode'] as String?,
      operatingNumber: json['operatingNumber'] as String?,
      arrivalAirportLocationCode: json['arrivalAirportLocationCode'] as String?,
      arrivalAirportLocationName: json['arrivalAirportLocationName'] as String?,
      arrivalAirportTerminalId: json['arrivalAirportTerminalId'] as String?,
      arrivalDateTime: json['arrivalDateTime'] == null
          ? null
          : DateTime.parse(json['arrivalDateTime'] as String),
      connectionInd: json['connectionInd'] as String?,
      departureAirportLocationCode:
          json['departureAirportLocationCode'] as String?,
      departureAirportLocationName:
          json['departureAirportLocationName'] as String?,
      departureAirportTerminalId: json['departureAirportTerminalId'] as String?,
      departureDateTime: json['departureDateTime'] == null
          ? null
          : DateTime.parse(json['departureDateTime'] as String),
      eTicket: json['eTicket'] as bool?,
      duration: json['duration'] as num?,
      elapsedTime: json['elapsedTime'] as num?,
      flightNumber: json['flightNumber'] as num?,
      marriageGroup: json['marriageGroup'] as String?,
      numberInParty: json['numberInParty'] as num?,
      resBookDesigCode: json['resBookDesigCode'] as String?,
      segmentNumber: json['segmentNumber'] as num?,
      smokingAllowed: json['smokingAllowed'] as bool?,
      specialMeal: json['specialMeal'] as bool?,
      status: json['status'] as String?,
      stopQuantity: json['stopQuantity'] as num?,
      supplierRefId: json['supplierRefId'] as String?,
      seatNumber: json['seatNumber'] as String?,
      aircraftType: json['aircraftType'] as String?,
      aircraftDescription: json['aircraftDescription'] as String?,
      updatedArrivalDateTime: json['updatedArrivalDateTime'] == null
          ? null
          : DateTime.parse(json['updatedArrivalDateTime'] as String),
      updatedDepartureDateTime: json['updatedDepartureDateTime'] == null
          ? null
          : DateTime.parse(json['updatedDepartureDateTime'] as String),
      segmentOrder: json['segmentOrder'] as String?,
      createdById: json['createdById'] as num?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      createdDateUTC: json['createdDateUTC'] == null
          ? null
          : DateTime.parse(json['createdDateUTC'] as String),
      modifiedById: json['modifiedById'] as num?,
      modifiedDate: json['modifiedDate'] == null
          ? null
          : DateTime.parse(json['modifiedDate'] as String),
      modifiedDateUTC: json['modifiedDateUTC'] == null
          ? null
          : DateTime.parse(json['modifiedDateUTC'] as String),
    );

Map<String, dynamic> _$BoundToJson(Bound instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('flightSegmentId', instance.flightSegmentId);
  writeNotNull('bookingId', instance.bookingId);
  writeNotNull('airlineCode', instance.airlineCode);
  writeNotNull('fareBasisCode', instance.fareBasisCode);
  writeNotNull('cabinTypeCode', instance.cabinTypeCode);
  writeNotNull('airEquipType', instance.airEquipType);
  writeNotNull('airMilesFlown', instance.airMilesFlown);
  writeNotNull('operatingCode', instance.operatingCode);
  writeNotNull('operatingNumber', instance.operatingNumber);
  writeNotNull(
      'arrivalAirportLocationCode', instance.arrivalAirportLocationCode);
  writeNotNull(
      'arrivalAirportLocationName', instance.arrivalAirportLocationName);
  writeNotNull('arrivalAirportTerminalId', instance.arrivalAirportTerminalId);
  writeNotNull('arrivalDateTime', instance.arrivalDateTime?.toIso8601String());
  writeNotNull('connectionInd', instance.connectionInd);
  writeNotNull(
      'departureAirportLocationCode', instance.departureAirportLocationCode);
  writeNotNull(
      'departureAirportLocationName', instance.departureAirportLocationName);
  writeNotNull(
      'departureAirportTerminalId', instance.departureAirportTerminalId);
  writeNotNull(
      'departureDateTime', instance.departureDateTime?.toIso8601String());
  writeNotNull('eTicket', instance.eTicket);
  writeNotNull('duration', instance.duration);
  writeNotNull('elapsedTime', instance.elapsedTime);
  writeNotNull('flightNumber', instance.flightNumber);
  writeNotNull('marriageGroup', instance.marriageGroup);
  writeNotNull('numberInParty', instance.numberInParty);
  writeNotNull('resBookDesigCode', instance.resBookDesigCode);
  writeNotNull('segmentNumber', instance.segmentNumber);
  writeNotNull('smokingAllowed', instance.smokingAllowed);
  writeNotNull('specialMeal', instance.specialMeal);
  writeNotNull('status', instance.status);
  writeNotNull('stopQuantity', instance.stopQuantity);
  writeNotNull('supplierRefId', instance.supplierRefId);
  writeNotNull('seatNumber', instance.seatNumber);
  writeNotNull('aircraftType', instance.aircraftType);
  writeNotNull('aircraftDescription', instance.aircraftDescription);
  writeNotNull('updatedArrivalDateTime',
      instance.updatedArrivalDateTime?.toIso8601String());
  writeNotNull('updatedDepartureDateTime',
      instance.updatedDepartureDateTime?.toIso8601String());
  writeNotNull('segmentOrder', instance.segmentOrder);
  writeNotNull('createdById', instance.createdById);
  writeNotNull('createdDate', instance.createdDate?.toIso8601String());
  writeNotNull('createdDateUTC', instance.createdDateUTC?.toIso8601String());
  writeNotNull('modifiedById', instance.modifiedById);
  writeNotNull('modifiedDate', instance.modifiedDate?.toIso8601String());
  writeNotNull('modifiedDateUTC', instance.modifiedDateUTC?.toIso8601String());
  return val;
}

MealDetail _$MealDetailFromJson(Map<String, dynamic> json) => MealDetail(
      totalAmount: json['totalAmount'] as num?,
      meals: (json['meals'] as List<dynamic>?)
          ?.map((e) => Meal.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealDetailToJson(MealDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('totalAmount', instance.totalAmount);
  writeNotNull('meals', instance.meals);
  return val;
}

Meal _$MealFromJson(Map<String, dynamic> json) => Meal(
      surName: json['surName'] as String?,
      givenName: json['givenName'] as String?,
      title: json['title'] as String?,
      mealList: (json['mealList'] as List<dynamic>?)
          ?.map((e) => MealList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MealToJson(Meal instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('surName', instance.surName);
  writeNotNull('givenName', instance.givenName);
  writeNotNull('title', instance.title);
  writeNotNull('mealList', instance.mealList);
  return val;
}

MealList _$MealListFromJson(Map<String, dynamic> json) => MealList(
      mealName: json['mealName'] as String?,
      amount: json['amount'] as num?,
      currency: json['currency'] as String?,
      quantity: json['quantity'] as num?,
      departReturn: json['departReturn'] as String?,
    );

Map<String, dynamic> _$MealListToJson(MealList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('mealName', instance.mealName);
  writeNotNull('amount', instance.amount);
  writeNotNull('currency', instance.currency);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('departReturn', instance.departReturn);
  return val;
}

Passenger _$PassengerFromJson(Map<String, dynamic> json) => Passenger(
      paxId: json['paxId'] as num?,
      bookingId: json['bookingId'] as num?,
      ticketIssueDate: json['ticketIssueDate'] == null
          ? null
          : DateTime.parse(json['ticketIssueDate'] as String),
      givenName: json['givenName'] as String?,
      surname: json['surname'] as String?,
      passengerType: json['passengerType'] as String?,
      dob: json['dob'] == null ? null : DateTime.parse(json['dob'] as String),
      nationality: json['nationality'] as String?,
      passport: json['passport'] as String?,
      passportExpiryDate: json['passportExpiryDate'] == null
          ? null
          : DateTime.parse(json['passportExpiryDate'] as String),
      titleCode: json['titleCode'] as String?,
      myRewardMemberId: json['myRewardMemberId'] as String?,
      createdById: json['createdById'] as num?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      createdDateUTC: json['createdDateUTC'] == null
          ? null
          : DateTime.parse(json['createdDateUTC'] as String),
      modifiedById: json['modifiedById'] as num?,
      modifiedDate: json['modifiedDate'] == null
          ? null
          : DateTime.parse(json['modifiedDate'] as String),
      modifiedDateUTC: json['modifiedDateUTC'] == null
          ? null
          : DateTime.parse(json['modifiedDateUTC'] as String),
    );

Map<String, dynamic> _$PassengerToJson(Passenger instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('paxId', instance.paxId);
  writeNotNull('bookingId', instance.bookingId);
  writeNotNull('ticketIssueDate', instance.ticketIssueDate?.toIso8601String());
  writeNotNull('givenName', instance.givenName);
  writeNotNull('surname', instance.surname);
  writeNotNull('passengerType', instance.passengerType);
  writeNotNull('dob', instance.dob?.toIso8601String());
  writeNotNull('nationality', instance.nationality);
  writeNotNull('passport', instance.passport);
  writeNotNull(
      'passportExpiryDate', instance.passportExpiryDate?.toIso8601String());
  writeNotNull('titleCode', instance.titleCode);
  writeNotNull('myRewardMemberId', instance.myRewardMemberId);
  writeNotNull('createdById', instance.createdById);
  writeNotNull('createdDate', instance.createdDate?.toIso8601String());
  writeNotNull('createdDateUTC', instance.createdDateUTC?.toIso8601String());
  writeNotNull('modifiedById', instance.modifiedById);
  writeNotNull('modifiedDate', instance.modifiedDate?.toIso8601String());
  writeNotNull('modifiedDateUTC', instance.modifiedDateUTC?.toIso8601String());
  return val;
}

PaymentOrder _$PaymentOrderFromJson(Map<String, dynamic> json) => PaymentOrder(
      paymentId: json['paymentId'] as num?,
      orderId: json['orderId'] as num?,
      paymentDate: json['paymentDate'] == null
          ? null
          : DateTime.parse(json['paymentDate'] as String),
      paymentMethodCode: json['paymentMethodCode'] as String?,
      paymentStatusCode: json['paymentStatusCode'] as String?,
      requeryStatusCode: json['requeryStatusCode'] as String?,
      currencyCode: json['currencyCode'] as String?,
      paymentAmount: json['paymentAmount'] as num?,
      cardOption: json['cardOption'] as String?,
      hasError: json['hasError'] as bool?,
      paymentRefNo: json['paymentRefNo'] as String?,
      paymentTransactionId: json['paymentTransactionId'] as String?,
      createdById: json['createdById'] as num?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      createdDateUTC: json['createdDateUTC'] == null
          ? null
          : DateTime.parse(json['createdDateUTC'] as String),
      modifiedById: json['modifiedById'] as num?,
      modifiedDate: json['modifiedDate'] == null
          ? null
          : DateTime.parse(json['modifiedDate'] as String),
      modifiedDateUTC: json['modifiedDateUTC'] == null
          ? null
          : DateTime.parse(json['modifiedDateUTC'] as String),
    );

Map<String, dynamic> _$PaymentOrderToJson(PaymentOrder instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('paymentId', instance.paymentId);
  writeNotNull('orderId', instance.orderId);
  writeNotNull('paymentDate', instance.paymentDate?.toIso8601String());
  writeNotNull('paymentMethodCode', instance.paymentMethodCode);
  writeNotNull('paymentStatusCode', instance.paymentStatusCode);
  writeNotNull('requeryStatusCode', instance.requeryStatusCode);
  writeNotNull('cardOption', instance.cardOption);
  writeNotNull('currencyCode', instance.currencyCode);
  writeNotNull('paymentAmount', instance.paymentAmount);
  writeNotNull('hasError', instance.hasError);
  writeNotNull('paymentRefNo', instance.paymentRefNo);
  writeNotNull('paymentTransactionId', instance.paymentTransactionId);
  writeNotNull('createdById', instance.createdById);
  writeNotNull('createdDate', instance.createdDate?.toIso8601String());
  writeNotNull('createdDateUTC', instance.createdDateUTC?.toIso8601String());
  writeNotNull('modifiedById', instance.modifiedById);
  writeNotNull('modifiedDate', instance.modifiedDate?.toIso8601String());
  writeNotNull('modifiedDateUTC', instance.modifiedDateUTC?.toIso8601String());
  return val;
}

SeatDetail _$SeatDetailFromJson(Map<String, dynamic> json) => SeatDetail(
      totalAmount: json['totalAmount'] as num?,
      seats: (json['seats'] as List<dynamic>?)
          ?.map((e) => Baggage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeatDetailToJson(SeatDetail instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('totalAmount', instance.totalAmount);
  writeNotNull('seats', instance.seats);
  return val;
}

SuperPNR _$SuperPNRFromJson(Map<String, dynamic> json) => SuperPNR(
      superPNRID: json['superPNRID'] as num?,
      superPNRNo: json['superPNRNo'] as String?,
      channelTypeCode: json['channelTypeCode'] as String?,
      bookingDate: json['bookingDate'] == null
          ? null
          : DateTime.parse(json['bookingDate'] as String),
      userId: json['userId'] as num?,
      validDateFrom: json['validDateFrom'] == null
          ? null
          : DateTime.parse(json['validDateFrom'] as String),
      validDateTo: json['validDateTo'] == null
          ? null
          : DateTime.parse(json['validDateTo'] as String),
      isActive: json['isActive'] as bool?,
      createdById: json['createdById'] as num?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      createdDateUTC: json['createdDateUTC'] == null
          ? null
          : DateTime.parse(json['createdDateUTC'] as String),
      modifiedById: json['modifiedById'] as num?,
      modifiedDate: json['modifiedDate'] == null
          ? null
          : DateTime.parse(json['modifiedDate'] as String),
      modifiedDateUTC: json['modifiedDateUTC'] == null
          ? null
          : DateTime.parse(json['modifiedDateUTC'] as String),
    );

Map<String, dynamic> _$SuperPNRToJson(SuperPNR instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('superPNRID', instance.superPNRID);
  writeNotNull('superPNRNo', instance.superPNRNo);
  writeNotNull('channelTypeCode', instance.channelTypeCode);
  writeNotNull('bookingDate', instance.bookingDate?.toIso8601String());
  writeNotNull('userId', instance.userId);
  writeNotNull('validDateFrom', instance.validDateFrom?.toIso8601String());
  writeNotNull('validDateTo', instance.validDateTo?.toIso8601String());
  writeNotNull('isActive', instance.isActive);
  writeNotNull('createdById', instance.createdById);
  writeNotNull('createdDate', instance.createdDate?.toIso8601String());
  writeNotNull('createdDateUTC', instance.createdDateUTC?.toIso8601String());
  writeNotNull('modifiedById', instance.modifiedById);
  writeNotNull('modifiedDate', instance.modifiedDate?.toIso8601String());
  writeNotNull('modifiedDateUTC', instance.modifiedDateUTC?.toIso8601String());
  return val;
}

SuperPNROrder _$SuperPNROrderFromJson(Map<String, dynamic> json) =>
    SuperPNROrder(
      orderId: json['orderId'] as num?,
      superPNRID: json['superPNRID'] as num?,
      affiliationId: json['affiliationId'] as num?,
      orderNo: json['orderNo'] as String?,
      bookingTypeCode: json['bookingTypeCode'] as String?,
      bookingStatusCode: json['bookingStatusCode'] as String?,
      isDynamic: json['isDynamic'] as bool?,
      isFixed: json['isFixed'] as bool?,
      currencyCode: json['currencyCode'] as String?,
      gstAmt: json['gstAmt'] as num?,
      markupAmt: json['markupAmt'] as num?,
      sourceTotalPrice: json['sourceTotalPrice'] as num?,
      totalBookingAmt: json['totalBookingAmt'] as num?,
      voucherCode: json['voucherCode'] as String?,
      voucherDiscountAmt: json['voucherDiscountAmt'] as num?,
      discountAmt: json['discountAmt'] as num?,
      isCreditUsed: json['isCreditUsed'] as bool?,
      creditAmount: json['creditAmount'] as num?,
      instantDiscountAmt: json['instantDiscountAmt'] as num?,
      affiliationRef: json['affiliationRef'] as String?,
      rebateInfo: json['rebateInfo'] as String?,
      createdById: json['createdById'] as num?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      createdDateUTC: json['createdDateUTC'] == null
          ? null
          : DateTime.parse(json['createdDateUTC'] as String),
      modifiedById: json['modifiedById'] as num?,
      modifiedDate: json['modifiedDate'] == null
          ? null
          : DateTime.parse(json['modifiedDate'] as String),
      modifiedDateUTC: json['modifiedDateUTC'] == null
          ? null
          : DateTime.parse(json['modifiedDateUTC'] as String),
    );

Map<String, dynamic> _$SuperPNROrderToJson(SuperPNROrder instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('orderId', instance.orderId);
  writeNotNull('superPNRID', instance.superPNRID);
  writeNotNull('affiliationId', instance.affiliationId);
  writeNotNull('orderNo', instance.orderNo);
  writeNotNull('bookingTypeCode', instance.bookingTypeCode);
  writeNotNull('bookingStatusCode', instance.bookingStatusCode);
  writeNotNull('isDynamic', instance.isDynamic);
  writeNotNull('isFixed', instance.isFixed);
  writeNotNull('currencyCode', instance.currencyCode);
  writeNotNull('gstAmt', instance.gstAmt);
  writeNotNull('markupAmt', instance.markupAmt);
  writeNotNull('sourceTotalPrice', instance.sourceTotalPrice);
  writeNotNull('totalBookingAmt', instance.totalBookingAmt);
  writeNotNull('voucherCode', instance.voucherCode);
  writeNotNull('voucherDiscountAmt', instance.voucherDiscountAmt);
  writeNotNull('discountAmt', instance.discountAmt);
  writeNotNull('isCreditUsed', instance.isCreditUsed);
  writeNotNull('creditAmount', instance.creditAmount);
  writeNotNull('instantDiscountAmt', instance.instantDiscountAmt);
  writeNotNull('affiliationRef', instance.affiliationRef);
  writeNotNull('rebateInfo', instance.rebateInfo);
  writeNotNull('createdById', instance.createdById);
  writeNotNull('createdDate', instance.createdDate?.toIso8601String());
  writeNotNull('createdDateUTC', instance.createdDateUTC?.toIso8601String());
  writeNotNull('modifiedById', instance.modifiedById);
  writeNotNull('modifiedDate', instance.modifiedDate?.toIso8601String());
  writeNotNull('modifiedDateUTC', instance.modifiedDateUTC?.toIso8601String());
  return val;
}
