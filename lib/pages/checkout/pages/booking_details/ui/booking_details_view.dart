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
import 'package:app/pages/search_result/ui/summary_container_listener.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../models/switch_setting.dart';
import '../../../../../theme/theme.dart';
import '../../../../../utils/ui_utils.dart';
import '../../../../../widgets/settings_wrapper.dart';
import 'insurance_terms.dart';

const formNameFirstName = "_first_name";
const formNameLastName = "_last_name";
const formNameMYRewardId = "_reward_id";

const formNameWheelChair = "_wheel_chair";
const formNameInsurance = '_insurance';
const formNameOkIdNumber = "_okIdNumber";
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
  static final fbKey = GlobalKey<FormBuilderState>();

  const BookingDetailsView({Key? key}) : super(key: key);

  @override
  State<BookingDetailsView> createState() => _BookingDetailsViewState();
}

class _BookingDetailsViewState extends State<BookingDetailsView> {
  final scrollController = ScrollController();
  final keySummary = GlobalKey();
  final bookingSummary = GlobalKey();

  void rebuild() {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (keySummary.currentContext as Element).visitChildren(rebuild);
  }

  void rebuildSummary() {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (bookingSummary.currentContext as Element).visitChildren(rebuild);
  }

  var isValid = false;
  var insuranceChecked = false;

  @override
  void initState() {
    super.initState();
  }

  SearchFlightState? currentState;

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<SearchFlightCubit>();
    currentState = bloc.state;

    bool showInsuranceTerms =
        context.watch<SearchFlightCubit>().showInsuranceCheck();
    return Stack(
      children: [
        FormBuilder(
          //autoFocusOnValidationFailure: true,
          onChanged: () {
            if (BookingDetailsView.fbKey.currentState!.validate()) {
              setState(() {
                isValid = true;
              });
            } else {
              setState(() {
                isValid = false;
              });
            }
          },
          key: BookingDetailsView.fbKey,
          child: SummaryContainerListener(
            scrollController: scrollController,
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
                        ListOfPassengerInfo(
                          onInsuranceChanged: () {
                            rebuild();
                            rebuildSummary();
                          },
                        ),
                        kVerticalSpacer,
                        if (showInsuranceTerms) ...[
                          SettingsWrapper(
                            settingType: AvailableSetting.insurance,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: insuranceChecked,
                                        onChanged: (newValue) {
                                          setState(() {
                                            insuranceChecked =
                                                newValue ?? false;
                                          });
                                        }),
                                    Expanded(
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Yes, I would like to add ',
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <TextSpan>[
                                            makeClickableTextSpan(context,
                                                text: 'MY Travel Shield',
                                                makeNormalTextBol: true),
                                            makeClickableTextSpan(context,
                                                text: ' to cover my trip.',
                                                makeNormalTextBol: false),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ], //
                                  //
                                  //
                                ),
                                const InsuranceTerms(),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      CheckoutSummary(
                        key: bookingSummary,
                      ),
                      Positioned(
                        bottom: 0,
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
                  kSummaryContainerSpacing,
                  kSummaryContainerSpacing,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SummaryContainer(
            child: Padding(
              padding: kPagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BookingSummary(
                    key: keySummary,
                  ),
                  ElevatedButton(
                    onPressed: showInsuranceTerms
                        ? ((showInsuranceTerms && insuranceChecked)
                            ? (isValid ? () => onBooking(context) : null)
                            : null)
                        : (isValid ? () => onBooking(context) : null),
                    child: const Text("Continue"),
                  ),
                  kVerticalSpacer,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  onBooking(BuildContext context) {
    if (BookingDetailsView.fbKey.currentState!.saveAndValidate()) {
      var values = BookingDetailsView.fbKey.currentState!.value;

      if (values != null) {
        var contactName = makeLowerCaseName(
            values, formNameContactFirstName, formNameContactLastName);
        var emergencyName = (values[formNameEmergencyFirstName].toString() +
                values[formNameEmergencyLastName].toString())
            .toLowerCase();
        if (contactName == emergencyName) {
          showSameNameError();

          return;
        } else {
          var emergencyName = (values[formNameEmergencyFirstName].toString() +
                  values[formNameEmergencyLastName].toString())
              .toLowerCase();

          int adults =
              currentState?.filterState?.numberPerson.numberOfAdult ?? 0;
          int childs =
              currentState?.filterState?.numberPerson.numberOfChildren ?? 0;
          int infant =
              currentState?.filterState?.numberPerson.numberOfInfant ?? 0;

          for (int i = 0; i < adults; i++) {
            var keyName = 'Adult ${i + 1}_first_name';
            var keyLname = 'Adult ${i + 1}_last_name';
            var contactName = makeLowerCaseName(values, keyName, keyLname);
            if (contactName == emergencyName) {
              showSameNameError();
              return;
            }
          }

          for (int i = 0; i < childs; i++) {
            var keyName = 'Child ${i + 1}_first_name';
            var keyLname = 'Child ${i + 1}_last_name';
            var contactName = makeLowerCaseName(values, keyName, keyLname);
            if (contactName == emergencyName) {
              showSameNameError();
              return;
            }
          }

          for (int i = 0; i < infant; i++) {
            var keyName = 'Infant ${i + 1}_first_name';
            var keyLname = 'Infant ${i + 1}_last_name';
            var contactName = makeLowerCaseName(values, keyName, keyLname);
            if (contactName == emergencyName) {
              showSameNameError();
              return;
            }
          }
        }
      }

      final bookingState = context.read<BookingCubit>().state;
      final state = context.read<SearchFlightCubit>().state;
      final verifyToken = bookingState.verifyResponse?.token;
      final flightSeats = bookingState.verifyResponse?.flightSeat;
      final flightInfant = bookingState.verifyResponse?.flightSSR?.infantGroup;
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
      final value = BookingDetailsView.fbKey.currentState!.value;

      String? companyName = value[formNameCompanyName];
      String? emailCompany;

      if ((companyName ?? '').isNotEmpty) {

        emailCompany = value[formNameCompanyEmailAddress];

        if ((emailCompany ?? '').isEmpty) {
          BookingDetailsView.fbKey.currentState!.invalidateField(
              name: formNameCompanyEmailAddress,
              errorText: 'Email address is mandatory for company Tax Invoice.');
          return;
        }
      }

      List<Passenger> passengers = [];
      for (Person person in (persons?.persons ?? [])) {
        final passenger = person.toPassenger(
          outboundRows: rowsOutBound ?? [],
          inboundRows: rowsInBound ?? [],
          numberPerson: persons,
          infantGroup: flightInfant,
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
          mYRewardMemberID: (value["${person.toString()}$formNameMYRewardId"]
                          as String?)
                      ?.isEmpty ??
                  true
              ? null
              : (value["${person.toString()}$formNameMYRewardId"] as String?),
          title: (value["${person.toString()}$formNameTitle"] as String?)
              ?.toUpperCase(),
          nationality: value["${person.toString()}$formNameNationality"],
          dob: value["${person.toString()}$formNameDob"],
          gender: "Male",
          relation: "Self",
          wheelChairNeeded: value["${person.toString()}$formNameWheelChair"],
          insuranceSelected: value["${person.toString()}$formNameInsurance"],
          oKUIDNumber: value["${person.toString()}$formNameOkIdNumber"],
        );
        if (filledPassenger.insuranceSelected ?? false) {
          filledPassenger.setInsuranceWith(bookingState
              .verifyResponse!.flightSSR!.insuranceGroup!.outbound!.first);
        }
        passengers.add(filledPassenger);
      }
      final pnrRequest = FlightSummaryPnrRequest(
        contactEmail: value[formNameContactEmail],
        contactFullName:
            "${value[formNameContactFirstName]} ${value[formNameContactLastName]}",
        contactPhoneCode: value[formNameContactPhoneCode],
        contactPhoneNumber: value[formNameContactPhoneNumber],
        displayCurrency: "MYR",
        preferredContactMethod: "Email",
        acceptNewsAndPromotionByEmail:
            value[formNameContactReceiveEmail] ?? false,
        comment: "",
        promoCode: "",
        companyTaxInvoice: CompanyTaxInvoice(
          companyName: value[formNameCompanyName],
          companyAddress: value[formNameCompanyAddress],
          country: value[formNameCompanyCountry],
          state: value[formNameCompanyState],
          city: value[formNameCompanyCity],
          emailAddress: (companyName ?? '').isNotEmpty ? value[formNameCompanyEmailAddress] : null,
          postCode: value[formNameCompanyPostCode],
        ),
        emergencyContact: EmergencyContact(
          firstName: value[formNameEmergencyFirstName],
          lastName: value[formNameEmergencyLastName],
          phoneCode: value[formNameEmergencyCountry],
          phoneNumber: value[formNameEmergencyPhone],
          relationship: value[formNameEmergencyRelation],
          email: value[formNameEmergencyEmail],
        ),
        passengers: passengers,
      );
      final summaryRequest = SummaryRequest(
          token: verifyToken ?? "", flightSummaryPNRRequest: pnrRequest);
      final savedPnr = pnrRequest.copyWith(
        comment: value[formNameContactLastName],
      );
      LocalRepository().setPassengerInfo(savedPnr);
      context.read<SummaryCubit>().submitSummary(summaryRequest);
    }
  }

  String makeLowerCaseName(
      Map<String, dynamic> values, String firstKey, String lastKey) {
    return (values[firstKey].toString() + values[lastKey].toString())
        .toLowerCase();
  }

  void showSameNameError() {
    BookingDetailsView.fbKey.currentState!.invalidateField(
        name: formNameEmergencyFirstName,
        errorText:
            'Emergency contact name should be different from contact name and passenger name.');
    BookingDetailsView.fbKey.currentState!.invalidateField(
        name: formNameEmergencyLastName,
        errorText:
            'Emergency contact name should be different from contact name and passenger name.');
  }
}
