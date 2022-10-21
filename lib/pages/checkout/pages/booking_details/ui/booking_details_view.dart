import 'dart:developer';

import 'package:app/app/app_router.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/repositories/local_repositories.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/data/requests/summary_request.dart';
import 'package:app/models/country.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/checkout/pages/booking_details/bloc/summary_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/card_summary.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/list_of_passenger_info.dart';
import 'package:app/pages/checkout/pages/select_seats/ui/seats_legend.dart';
import 'package:app/pages/checkout/ui/booking_details_header.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/checkout/ui/person_selector.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/widgets/app_booking_header.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../theme/theme.dart';

const formNameFirstName = "_first_name";
const formNameLastName = "_last_name";
const formNameTitle = "_title";
const formNameNationality = "_nationality";
const formNameDob = "_dob";
const formNameContactEmail = "contact_email";
const formNameEmergencyFirstName = "emergency_first_name";
const formNameEmergencyLastName = "emergency_last_name";
const formNameEmergencyRelation = "emergency_relation";
const formNameEmergencyCountry = "emergency_country";
const formNameEmergencyPhone = "emergency_phone";
const formNameCompanyName = "company_name";
const formNameCompanyAddress = "company_address";
const formNameCompanyCountry = "company_country";
const formNameCompanyState = "company_state";
const formNameCompanyCity = "company_city";
const formNameCompanyPostCode = "company_post_code";
const formNameCompanyEmailAddress = "company_email";

class BookingDetailsView extends StatelessWidget {
  static final _fbKey = GlobalKey<FormBuilderState>();

  const BookingDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notice = context.watch<CmsSsrCubit>().state.notice;
    return FormBuilder(
      autoFocusOnValidationFailure: true,
      key: _fbKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            kVerticalSpacerBig,
            Padding(
              padding: kPageHorizontalPadding,
              child: Column(
                children: [
                  AppBookingHeader(passedSteps: [
                    BookingStep.flights,
                    BookingStep.addOn,
                    BookingStep.bookingDetails
                  ]),
                  kVerticalSpacer,
                  BookingDetailsHeader(),
                  kVerticalSpacer,
                  CardSummary(),
                  kVerticalSpacer,
                  ListOfPassengerInfo(),
                  kVerticalSpacer,
                  kVerticalSpacer,
                  Container(
                    padding: EdgeInsets.all(8),
                    width: 500.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(value: true, onChanged: (_) {}),
                        Expanded(child: Html(data: notice?.content ?? "")),
                      ],
                    ),
                  )
                ],
              ),
            ),
            CheckoutSummary(),
            kVerticalSpacer,
            Padding(
              padding: kPageHorizontalPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppDividerWidget(),
                  kVerticalSpacer,
                  BookingSummary(),
                  kVerticalSpacer,
                  ElevatedButton(
                    onPressed: () => onBooking(context),
                    child: Text("Continue"),
                  ),
                  kVerticalSpacer,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  onBooking(BuildContext context) {
    if (_fbKey.currentState!.saveAndValidate()) {
      final bookingState = context.read<BookingCubit>().state;
      final state = context.read<SearchFlightCubit>().state;
      final verifyToken = bookingState.verifyResponse?.token;
      final flightSeats = bookingState.verifyResponse?.flightSeat;
      final outboundSeats = flightSeats?.outbound;
      final inboundSeats = flightSeats?.inbound;
      final rowsOutBound = outboundSeats
          ?.firstOrNull
          ?.retrieveFlightSeatMapResponse
          ?.physicalFlights
          ?.firstOrNull
          ?.physicalFlightSeatMap
          ?.seatConfiguration
          ?.rows;
      final rowsInBound = inboundSeats
          ?.firstOrNull
          ?.retrieveFlightSeatMapResponse
          ?.physicalFlights
          ?.firstOrNull
          ?.physicalFlightSeatMap
          ?.seatConfiguration
          ?.rows;
      final persons = state.filterState?.numberPerson;
      final value = _fbKey.currentState!.value;
      List<Passenger> passengers = [];
      for (Person person in (persons?.persons ?? [])) {
        final passenger = person.toPassenger(
          outboundRows: rowsOutBound ?? [],
          inboundRows: rowsInBound ?? [],
          inboundPhysicalId: inboundSeats
              ?.firstOrNull
              ?.retrieveFlightSeatMapResponse
              ?.physicalFlights
              ?.firstOrNull
              ?.physicalFlightID,
          outboundPhysicalId: outboundSeats
              ?.firstOrNull
              ?.retrieveFlightSeatMapResponse
              ?.physicalFlights
              ?.firstOrNull
              ?.physicalFlightID,
        );
        final filledPassenger = passenger.copyWith(
            firstName: value["${person.toString()}$formNameFirstName"],
            lastName: value["${person.toString()}$formNameLastName"],
            title: (value["${person.toString()}$formNameTitle"] as String?)
                ?.toUpperCase(),
            nationality: value["${person.toString()}$formNameNationality"],
            dob: value["${person.toString()}$formNameDob"],
            gender: "Male",
            relation: "Self");
        passengers.add(filledPassenger);
      }
      final companyCountry = value[formNameCompanyCountry] as Country?;
      final emergencyPhone = value[formNameEmergencyCountry] as Country?;

      final summaryRequest = SummaryRequest(
        token: verifyToken ?? "",
        flightSummaryPNRRequest: FlightSummaryPnrRequest(
          contactEmail: value[formNameContactEmail],
          displayCurrency: "MYR",
          preferredContactMethod: "Email",
          comment: "No",
          promoCode: "",
          companyTaxInvoice: CompanyTaxInvoice(
            companyName: value[formNameCompanyName],
            companyAddress: value[formNameCompanyAddress],
            country: companyCountry?.countryCode ?? "",
            state: value[formNameCompanyState],
            city: value[formNameCompanyCity],
            emailAddress: value[formNameCompanyEmailAddress],
            postCode: value[formNameCompanyPostCode],
          ),
          emergencyContact: EmergencyContact(
            firstName: value[formNameEmergencyFirstName],
            lastName: value[formNameEmergencyLastName],
            phoneCode: emergencyPhone?.phoneCode,
            phoneNumber: value[formNameEmergencyPhone],
            relationship: value[formNameEmergencyRelation],
          ),
          passengers: passengers,
        ),
      );
      LocalRepository()
          .setPassengerInfo(summaryRequest.flightSummaryPNRRequest);
      context.read<SummaryCubit>().submitSummary(summaryRequest);
    }
  }
}
