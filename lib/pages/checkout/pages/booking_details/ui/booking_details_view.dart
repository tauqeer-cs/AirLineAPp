
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/repositories/local_repositories.dart';
import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/data/requests/summary_request.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/checkout/pages/booking_details/bloc/summary_cubit.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/card_summary.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/list_of_passenger_info.dart';
import 'package:app/pages/checkout/ui/booking_details_header.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../theme/theme.dart';

const formNameFirstName = "_first_name";
const formNameLastName = "_last_name";
const formNameTitle = "_title";
const formNameNationality = "_nationality";
const formNameDob = "_dob";
const formNameContactEmail = "contact_email";
const formNameContactFirstName = "contact_first_name";
const formNameContactLastName = "contact_last_name";
const formNameContactPhoneCode = "contact_phone_code";
const formNameContactPhoneNumber = "contact_phone_number";
const formNameContactReceiveEmail = "contact_receive_email";
const formNameEmergencyFirstName = "emergency_first_name";
const formNameEmergencyLastName = "emergency_last_name";
const formNameEmergencyRelation = "emergency_relation";
const formNameEmergencyEmail = "emergency_email";
const formNameEmergencyCountry = "emergency_country";
const formNameEmergencyPhone = "emergency_phone";
const formNameCompanyName = "company_name";
const formNameCompanyAddress = "company_address";
const formNameCompanyCountry = "company_country";
const formNameCompanyState = "company_state";
const formNameCompanyCity = "company_city";
const formNameCompanyPostCode = "company_post_code";
const formNameCompanyEmailAddress = "company_email";

class BookingDetailsView extends StatefulWidget {
  static final _fbKey = GlobalKey<FormBuilderState>();

  const BookingDetailsView({Key? key}) : super(key: key);

  @override
  State<BookingDetailsView> createState() => _BookingDetailsViewState();
}

class _BookingDetailsViewState extends State<BookingDetailsView> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      autoFocusOnValidationFailure: true,
      key: BookingDetailsView._fbKey,
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            kVerticalSpacerBig,
            Padding(
              padding: kPageHorizontalPadding,
              child: Column(
                children: [
                  const BookingDetailsHeader(),
                  kVerticalSpacer,
                  const CardSummary(showFees: false),
                  kVerticalSpacer,
                  const ListOfPassengerInfo(),

                ],
              ),
            ),
            Stack(
              children: [
                const CheckoutSummary(),
                Positioned(
                  bottom: 15,
                  right: 15,
                  child: FloatingActionButton(
                    onPressed: () {
                      scrollController.animateTo(
                        scrollController.position.minScrollExtent,
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    backgroundColor: Styles.kPrimaryColor,
                    child: const Icon(Icons.keyboard_arrow_up),
                  ),
                )
              ],
            ),
            kVerticalSpacer,
            SummaryContainer(
              child: Padding(
                padding: kPagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const BookingSummary(),
                    ElevatedButton(
                      onPressed: () => onBooking(context),
                      child: const Text("Continue"),
                    ),
                    kVerticalSpacer,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onBooking(BuildContext context) {
    if (BookingDetailsView._fbKey.currentState!.saveAndValidate()) {
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
      final value = BookingDetailsView._fbKey.currentState!.value;
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

      final summaryRequest = SummaryRequest(
        token: verifyToken ?? "",
        flightSummaryPNRRequest: FlightSummaryPnrRequest(
          contactEmail: value[formNameContactEmail],
          contactFullName: "${value[formNameContactFirstName]} ${value[formNameContactLastName]}",
          contactPhoneCode: value[formNameContactPhoneCode],
          contactPhoneNumber: value[formNameContactPhoneNumber],
          displayCurrency: "MYR",
          preferredContactMethod: "Email",
          acceptNewsAndPromotionByEmail: value[formNameContactReceiveEmail] ?? false,
          comment: "No",
          promoCode: "",
          companyTaxInvoice: CompanyTaxInvoice(
            companyName: value[formNameCompanyName],
            companyAddress: value[formNameCompanyAddress],
            country: value[formNameCompanyCountry],
            state: value[formNameCompanyState],
            city: value[formNameCompanyCity],
            emailAddress: value[formNameCompanyEmailAddress],
            postCode: value[formNameCompanyPostCode],
          ),
          emergencyContact: EmergencyContact(
            firstName: value[formNameEmergencyFirstName],
            lastName: value[formNameEmergencyLastName],
            phoneCode: value[formNameEmergencyCountry],
            phoneNumber: value[formNameEmergencyPhone],
            relationship: value[formNameEmergencyRelation],
            email: value[formNameEmergencyEmail]
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
