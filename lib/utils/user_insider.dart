import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/utils/fcm_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_insider/flutter_insider.dart';
import 'package:flutter_insider/flutter_insider.dart';
import 'package:flutter_insider/src/product.dart';
import 'package:flutter_insider/enum/InsiderGender.dart';
import 'package:flutter_insider/enum/InsiderCallbackAction.dart';
import 'package:flutter_insider/enum/ContentOptimizerDataType.dart';
import 'package:flutter_insider/src/event.dart';
import 'package:flutter_insider/src/identifiers.dart';

class UserInsider {
  BuildContext? context;
  static final UserInsider _userInsider = UserInsider._internal();

  factory UserInsider() {
    return _userInsider;
  }

  static UserInsider instance = UserInsider();

  UserInsider._internal();

  static UserInsider of(BuildContext context) {
    UserInsider insider = UserInsider();
    insider.context = context;
    return insider;
  }

  FlutterInsiderProduct generateProduct() {
    FlutterInsiderProduct insiderProduct =
        FlutterInsider.Instance.createNewProduct(
      "productID",
      "productName",
      [],
      "imageURL",
      0,
      "currency",
    );
    if (context == null) return insiderProduct;
    final filterState = context!.read<FilterCubit>().state;
    final bookingState = context!.read<BookingCubit>().state;

    insiderProduct
        .setCustomAttributeWithString("from", filterState.origin?.code ?? "")
        .setCustomAttributeWithString("to", filterState.destination?.code ?? "")
        .setCustomAttributeWithString("trip_type", filterState.flightType.name)
        .setCustomAttributeWithString("route", filterState.routeShort)
        .setCustomAttributeWithDate(
            "departure_date", filterState.departDate ?? DateTime.now())
        // .setCustomAttributeWithString("boarding_time", "")
        // .setCustomAttributeWithString("flight_number", "")
        // .setCustomAttributeWithString("aircraft", "")
        .setCustomAttributeWithString("gate", "")
        .setCustomAttributeWithInt(
            "total_adult_passenger", filterState.numberPerson.numberOfAdult)
        .setCustomAttributeWithInt(
            "total_child_passenger", filterState.numberPerson.numberOfChildren)
        .setCustomAttributeWithInt(
            "total_infant_passenger", filterState.numberPerson.numberOfInfant)
        .setCustomAttributeWithBoolean(
          "ancillary_seat",
          filterState.numberPerson.getTotalSeatsPartial(false) +
                  filterState.numberPerson.getTotalSeatsPartial(true) >
              0,
        )
        .setCustomAttributeWithBoolean(
          "ancillary_meal",
          filterState.numberPerson.getTotalMealPartial(false) +
                  filterState.numberPerson.getTotalMealPartial(true) >
              0,
        )
        .setCustomAttributeWithBoolean(
          "ancillary_baggage",
          filterState.numberPerson.getTotalBaggagePartial(false) +
                  filterState.numberPerson.getTotalBaggagePartial(true) >
              0,
        );

    if (filterState.flightType == FlightType.round) {
      insiderProduct.setCustomAttributeWithDate(
          "return_date", filterState.returnDate ?? DateTime.now());
    }
    return insiderProduct;
  }

  registerStandardEvent(String eventName) {
    FlutterInsider.Instance.tagEvent(eventName).build();
  }

  registerEventWithParameterProduct(
    String eventName, {
    String? aircraft,
    String? flightNumber,
  }) {
    if (context == null) return;
    final filterState = context!.read<FilterCubit>().state;
    final bookingState = context!.read<BookingCubit>().state;
    FlutterInsiderEvent insiderEvent =
        FlutterInsider.Instance.tagEvent(eventName);
    insiderEvent
        .addParameterWithString("from", filterState.origin?.code ?? "")
        .addParameterWithString("to", filterState.destination?.code ?? "")
        .addParameterWithString("flight_type", filterState.flightType.name)
        .addParameterWithString("route", filterState.routeShort)
        .addParameterWithDate(
            "departure_date", filterState.departDate ?? DateTime.now())
        .addParameterWithInt(
            "total_adult_passenger", filterState.numberPerson.numberOfAdult)
        .addParameterWithInt(
            "total_child_passenger", filterState.numberPerson.numberOfChildren)
        .addParameterWithInt(
            "total_infant_passenger", filterState.numberPerson.numberOfInfant);
    if (aircraft != null) {
      insiderEvent.addParameterWithString("aircraft", aircraft);
    }
    if (flightNumber != null) {
      insiderEvent.addParameterWithString("flight_number", flightNumber);
    }
    if (filterState.flightType == FlightType.round) {
      insiderEvent.addParameterWithDate(
          "return_date", filterState.returnDate ?? DateTime.now());
    }
  }


}

class InsiderConstants {
  static const String registrationStarted = "registration_started ";
  static const String registrationCompleted = "registration_completed";
  static const String loginCompleted = "login_completed ";
  static const String checkInStarted = "checkin_started ";
  static const String checkInCompleted = "checkin_completed";
  static const String searchFlightButtonClicked =
      "search_flight_button_clicked";
  static const String searchFlightResultPage = "search_flight_result_page";
  static const String flightSelected = "flight_selected";
  static const String ancillaryPurchased = "ancillary_purchased";
  static const String bookingDetailsPageview = "booking_details_page_view";
  static const String promoCodeApplied = "promo_code_applied";
  static const String manageBookingPageView = "manage_booking_page_view";
  static const String dealsPageView = "deals_page_view";
  static const String promotionListingPageView = "promotion_listing_page_view";
  static const String promotionDetailPageView = "promotion_detail_page_view";
  static const String promotionSearchFlightButtonClicked =
      "promotion_search_flight_button_clicked";
}
