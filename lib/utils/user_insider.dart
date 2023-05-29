import 'package:app/app/app_logger.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_insider/flutter_insider.dart';
import 'package:flutter_insider/src/event.dart';
import 'package:flutter_insider/src/product.dart';

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
    if (context == null) {
      return FlutterInsider.Instance.createNewProduct(
        "12345",
        "test12345",
        ["test"],
        "imageURL",
        1000,
        "MYR",
      );
    }
    final filterState = context!.read<FilterCubit>().state;
    final filter = context!.read<SearchFlightCubit>().state.filterState ??
        const FilterState();
    final bookingState = context!.read<BookingCubit>().state;
    FlutterInsiderProduct insiderProduct =
        FlutterInsider.Instance.createNewProduct(
      bookingState.superPnrNo?.nullIfEmpty ??
          bookingState.verifyResponse?.token?.nullIfEmpty ??
          "none",
      filterState.beautifyCode,
      [
        filterState.flightType.name,
        filterState.origin?.code ?? "none",
        filterState.destination?.code ?? "none"
      ],
      "https://www.myairline.my/image/logo.png",
      (bookingState.getFinalPriceDisplay + (filter.numberPerson.getTotal()))
          .toDouble(),
      "MYR",
    );
    insiderProduct
        .setCustomAttributeWithString(
            "from", filterState.origin?.code?.nullIfEmpty ?? "none")
        .setCustomAttributeWithString(
          "PNR",
          bookingState.superPnrNo?.nullIfEmpty ??
              bookingState.verifyResponse?.token?.nullIfEmpty ??
              "none",
        )
        .setCustomAttributeWithString(
            "to", filterState.destination?.code?.nullIfEmpty ?? "none")
        .setCustomAttributeWithString("trip_type", filterState.flightType.name)
        .setCustomAttributeWithString("route", filterState.routeShort)
        .setCustomAttributeWithDate(
            "departure_date", filterState.departDate ?? DateTime.now())
        .setCustomAttributeWithString(
            "boarding_time",
            NumberUtils.getTimeString(
                bookingState.selectedDeparture?.segmentDetail?.flightTime))
        .setCustomAttributeWithString(
            "flight_number",
            bookingState
                    .selectedDeparture?.segmentDetail?.flightNum?.nullIfEmpty ??
                "none")
        .setCustomAttributeWithString(
            "aircraft",
            bookingState.selectedDeparture?.segmentDetail?.aircraftDescription
                    ?.nullIfEmpty ??
                "none")
        .setCustomAttributeWithString("gate", "none")
        .setCustomAttributeWithInt(
            "total_adult_passenger", filterState.numberPerson.numberOfAdult)
        .setCustomAttributeWithInt(
            "total_child_passenger", filterState.numberPerson.numberOfChildren)
        .setCustomAttributeWithInt(
            "total_infant_passenger", filterState.numberPerson.numberOfInfant)
        .setCustomAttributeWithBoolean(
          "ancillary_bundle",
          filter.numberPerson.getTotalBundlesPartial(false) +
                  filter.numberPerson.getTotalBundlesPartial(true) >
              0,
        )
        .setCustomAttributeWithBoolean(
          "ancillary_seat",
          filter.numberPerson.getTotalSeatsPartial(false) +
                  filter.numberPerson.getTotalSeatsPartial(true) >
              0,
        )
        .setCustomAttributeWithBoolean(
          "ancillary_meal",
          filter.numberPerson.getTotalMealPartial(false) +
                  filter.numberPerson.getTotalMealPartial(true) >
              0,
        )
        .setCustomAttributeWithBoolean(
          "ancillary_sport",
          (filter.numberPerson.getTotalSportsPartial(false) ?? 0) +
                  (filter.numberPerson.getTotalSportsPartial(true) ?? 0) >
              0,
        )
        .setCustomAttributeWithBoolean(
          "ancillary_baggage",
          filter.numberPerson.getTotalBaggagePartial(false) +
                  filter.numberPerson.getTotalBaggagePartial(true) >
              0,
        );

    if (filter.flightType == FlightType.round) {
      insiderProduct.setCustomAttributeWithDate(
          "return_date", filter.returnDate ?? DateTime.now());
      insiderProduct
          .setCustomAttributeWithString(
              "return_boarding_time",
              NumberUtils.getTimeString(
                  bookingState.selectedReturn?.segmentDetail?.flightTime))
          .setCustomAttributeWithString(
              "return_flight_number",
              bookingState
                      .selectedReturn?.segmentDetail?.flightNum?.nullIfEmpty ??
                  "")
          .setCustomAttributeWithString(
              "return_aircraft",
              bookingState.selectedReturn?.segmentDetail?.aircraftDescription
                      ?.nullIfEmpty ??
                  "");
    }
    return insiderProduct;
  }

  registerStandardEvent(String eventName) {
    logger.d("Register event with standard $eventName");
    FlutterInsider.Instance.tagEvent(eventName).build();
  }

  registerPurchasedAddOn() {
    logger.d("Register addon purchase with custom");
    FlutterInsiderEvent insiderEvent =
        FlutterInsider.Instance.tagEvent(InsiderConstants.ancillaryPurchased);
    if (context == null) return;

    final filter = context!.read<SearchFlightCubit>().state.filterState;
    if (filter == null) return;
    if (filter.numberPerson.getTotalBundlesPartial(true) > 0) {
      for (var element in filter.numberPerson.persons) {
        if (element.departureBundle == null) continue;
        insiderEvent.addParameterWithString("bundle_purchased",
            element.departureBundle?.bundle?.description ?? "");
      }
    }
    if (filter.numberPerson.getTotalSeatsPartial(true) > 0) {
      for (var element in filter.numberPerson.persons) {
        if (element.departureSeats == null) continue;
        insiderEvent.addParameterWithString(
            "seat_purchased", element.departureSeats?.serviceDescription ?? "");
      }
    }
    if (filter.numberPerson.getTotalMealPartial(true) > 0) {
      for (var element in filter.numberPerson.persons) {
        if (element.departureMeal.isEmpty) continue;
        insiderEvent.addParameterWithArray("meal_purchased",
            element.departureMeal.map((e) => e.description ?? "").toList());
      }
    }
    if (filter.numberPerson.getTotalBaggagePartial(true) > 0) {
      for (var element in filter.numberPerson.persons) {
        if (element.departureBaggage == null) continue;
        insiderEvent.addParameterWithString(
            "baggage_purchased", element.departureBaggage!.description ?? "");
      }
    }
    if ((filter.numberPerson.getTotalSportsPartial(true) ?? 0) > 0) {
      for (var element in filter.numberPerson.persons) {
        if (element.departureSports == null) continue;
        insiderEvent.addParameterWithString(
            "sports_purchased", element.departureSports!.description ?? "");
      }
    }

    if (filter.flightType == FlightType.round) {
      if (filter.numberPerson.getTotalBundlesPartial(false) > 0) {
        for (var element in filter.numberPerson.persons) {
          if (element.returnBundle == null) continue;
          insiderEvent.addParameterWithString("return_bundle_purchased",
              element.returnBundle?.bundle?.description ?? "");
        }
      }
      if (filter.numberPerson.getTotalSeatsPartial(false) > 0) {
        for (var element in filter.numberPerson.persons) {
          if (element.returnSeats == null) continue;
          insiderEvent.addParameterWithString("return_seat_purchased",
              element.returnSeats?.serviceDescription ?? "");
        }
      }
      if (filter.numberPerson.getTotalMealPartial(false) > 0) {
        for (var element in filter.numberPerson.persons) {
          if (element.returnMeal.isEmpty) continue;
          insiderEvent.addParameterWithArray("return_meal_purchased",
              element.returnMeal.map((e) => e.description ?? "").toList());
        }
      }
      if (filter.numberPerson.getTotalBaggagePartial(false) > 0) {
        for (var element in filter.numberPerson.persons) {
          if (element.returnBaggage == null) continue;
          insiderEvent.addParameterWithString("return_baggage_purchased",
              element.returnBaggage!.description ?? "");
        }
      }
      if ((filter.numberPerson.getTotalSportsPartial(false) ?? 0) > 0) {
        for (var element in filter.numberPerson.persons) {
          if (element.returnSports == null) continue;
          insiderEvent.addParameterWithString("return_sports_purchased",
              element.returnSports!.description ?? "");
        }
      }
    }
    insiderEvent.build();
  }

  registerEventWithParameterProduct(
    String eventName, {
    String? aircraft,
    String? flightNumber,
  }) async {
    logger.d("Register event with custom param $eventName");
    logger.d("context $context");

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
      if (aircraft != null) {
        insiderEvent.addParameterWithString("return_aircraft", aircraft);
      }
      if (flightNumber != null) {
        insiderEvent.addParameterWithString(
            "return_flight_number", flightNumber);
      }
    }
    insiderEvent.build();
    logger.d("event is ${insiderEvent.toString()}");
  }
}

class InsiderConstants {
  static const String registrationStarted = "registration_started";
  static const String registrationCompleted = "registration_completed";
  static const String loginCompleted = "login_completed";
  static const String checkInStarted = "checkin_started";
  static const String checkInCompleted = "checkin_completed";
  static const String searchFlightButtonClicked =
      "search_flight_button_clicked";
  static const String searchFlightResultPage = "search_flight_result_page";
  static const String flightSelected = "flight_selected";
  static const String ancillaryPurchased = "ancillary_purchased";
  static const String bookingDetailsPageview = "booking_details_page_view";
  static const String promoCodeApplied = "promo_code_applied";
  static const String promoCodeRemoved = "promo_code_removed";

  static const String manageBookingPageView = "manage_booking_page_view";
  static const String dealsPageView = "deals_page_view";
  static const String promotionListingPageView = "promotion_listing_page_view";
  static const String promotionDetailPageView = "promotion_detail_page_view";
  static const String promotionSearchFlightButtonClicked =
      "promotion_search_flight_button_clicked";
}
