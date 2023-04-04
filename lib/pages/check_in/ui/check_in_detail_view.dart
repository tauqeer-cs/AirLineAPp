import 'package:app/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../../models/number_person.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../utils/form_utils.dart';
import '../../../widgets/forms/app_input_text.dart';
import '../../booking_details/ui/flight_data.dart';
import '../../checkout/pages/booking_details/ui/pessenger_info.dart';
import '../../select_change_flight/ui/booking_refrence_label.dart';
import '../bloc/check_in_cubit.dart';
import 'check_in_steps.dart';
import 'dgnInfo_view.dart';

class CheckInDetailView extends StatelessWidget {
  const CheckInDetailView({Key? key}) : super(key: key);

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Styles.kTextColor;
    }
    return Styles.kPrimaryColor;
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<CheckInCubit>();
    var state = bloc.state;

    return Padding(
      padding: kPageHorizontalPadding,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            const BookingReferenceLabel(
              refText: 'XAS200',
            ),
            SizedBox(
              width: double.infinity,
              child: CheckInSteps(
                passedSteps: const [
                  CheckInStep.itinerary,
                  //            BookingStep.addOn,
//              BookingStep.bookingDetails,
                ],
                onTopStepTaped: (i) {},
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'Itinerary',
              style: kHugeSemiBold.copyWith(
                color: Styles.kTextColor,
              ),
              textAlign: TextAlign.left,
            ),
            kVerticalSpacerSmall,
            AppCard(
              edgeInsets: const EdgeInsets.only(right: 15, top: 15, bottom: 15),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: state.checkedDeparture,
                    onChanged: (bool? value) {
                      bloc.setCheckDeparture(value ?? false);
                    },
                  ),
                  Expanded(
                    child: FlightDataInfo(
                      headingLabel: 'Departure',
                      dateToShow: state.manageBookingResponse?.result
                              ?.departureDateToShow ??
                          '',
                      departureToDestinationCode: state.manageBookingResponse
                              ?.result?.departureToDestinationCode ??
                          '',
                      departureDateWithTime: state.manageBookingResponse?.result
                              ?.departureDateWithTime ??
                          '',
                      departureAirportName: state.manageBookingResponse?.result
                              ?.departureAirportName ??
                          '',
                      journeyTimeInHourMin: state.manageBookingResponse?.result
                              ?.journeyTimeInHourMin ??
                          '',
                      arrivalDateWithTime: state.manageBookingResponse?.result
                              ?.arrivalDateWithTime ??
                          '',
                      arrivalAirportName: state.manageBookingResponse?.result
                              ?.arrivalAirportName ??
                          '',
                    ),
                  ),
                ],
              ),
            ),
            kVerticalSpacerSmall,
            if ((state.manageBookingResponse?.isTwoWay ?? false)) ...[
              AppCard(
                edgeInsets:
                    const EdgeInsets.only(right: 15, top: 15, bottom: 15),
                child: Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: state.checkReturn,
                      onChanged: (bool? value) {
                        bloc.setCheckReturn(value ?? false);
                      },
                    ),
                    Expanded(
                      child: FlightDataInfo(
                        headingLabel: 'Return',
                        dateToShow: state.manageBookingResponse?.result
                                ?.returnDepartureDateToShow ??
                            '',
                        departureToDestinationCode: state.manageBookingResponse
                                ?.result?.returnToDestinationCode ??
                            '',
                        departureDateWithTime: state.manageBookingResponse
                                ?.result?.returnDepartureDateWithTime ??
                            '',
                        departureAirportName: state.manageBookingResponse
                                ?.result?.returnDepartureAirportName ??
                            '',
                        journeyTimeInHourMin: state.manageBookingResponse
                                ?.result?.returnJourneyTimeInHourMin ??
                            '',
                        arrivalDateWithTime: state.manageBookingResponse?.result
                                ?.returnArrivalDateWithTime ??
                            '',
                        arrivalAirportName: state.manageBookingResponse?.result
                                ?.returnArrivalAirportName ??
                            '',
                      ),
                    ),
                  ],
                ),
              ),
            ],
            kVerticalSpacer,
            Text(
              'Passenger',
              style: kHugeSemiBold.copyWith(
                color: Styles.kTextColor,
              ),
              textAlign: TextAlign.left,
            ),
            kVerticalSpacerSmall,
            for (int i = 0;
                i <
                    (state.manageBookingResponse?.result?.passengersWithSSR ??
                            [])
                        .length;
                i++) ...[
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    value: state.checkReturn,
                    onChanged: (bool? value) {
                      bloc.setCheckReturn(value ?? false);
                    },
                  ),
                  Text(
                    state.manageBookingResponse?.result?.passengersWithSSR?[i]
                            .passengers?.fullName ??
                        '',
                    style: kLargeHeavy.copyWith(
                      color: Styles.kTextColor,
                    ),
                    textAlign: TextAlign.left,
                  ),



                ],
              ),

              AppInputText(
                hintText: "First Name/Given Name",
                readOnly: true,
                validators: [FormBuilderValidators.required()],
                initialValue: state.manageBookingResponse?.result
                    ?.passengersWithSSR?[i].passengers?.givenName ??
                    '',
                name: 'firstNameKey',
                fillDisabledColor: true,
              ),
              kVerticalSpacerSmall,

              AppInputText(
                hintText: 'Last Name / Surname',
                readOnly: true,
                validators: [FormBuilderValidators.required()],
                initialValue: state.manageBookingResponse?.result
                    ?.passengersWithSSR?[i].passengers?.surname ??
                    '',
                name: 'lastNameKey',
                fillDisabledColor: true,
              ),
              kVerticalSpacerSmall,
              AppInputText(
                hintText: 'Nationality',
                readOnly: true,
                validators: [FormBuilderValidators.required()],
                initialValue: state.manageBookingResponse?.result
                    ?.passengersWithSSR?[i].passengers?.nationality ??
                    '',
                name: 'lastNameKey',
                fillDisabledColor: true,
              ),


              kVerticalSpacerSmall,
              if(bloc.showPassport) ... [
                AppInputText(
                  name: 'passportKey',
                  initialValue: state.manageBookingResponse?.result
                      ?.passengersWithSSR?[i].passengers?.passport,
                  hintText: 'Passport Number',
                  inputFormatters: [AppFormUtils.onlyNumber()],
                  textInputType: TextInputType.text,
//
                ),
                kVerticalSpacerMini,
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Styles.kTextColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: FormBuilderDateTimePicker(
                    //key: 'dateKey1',
                    name: 'dobKey',
                    firstDate: DateTime.now().add(const Duration(days: 30)),
                    lastDate: DateTime.now().add(const Duration(days: 4120)),
                    initialValue: state.manageBookingResponse?.result
                        ?.passengersWithSSR?[i].passengers?.passportExpiryDate ,
                    format: DateFormat("dd MMMM yyyy"),
                    initialDate: state.manageBookingResponse?.result
                        ?.passengersWithSSR?[i].passengers?.passportExpiryDate ?? DateTime.now().add(const Duration(days: 30)),
                    initialEntryMode: DatePickerEntryMode.calendar,
                    decoration:  InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      labelText: 'Date of Birth',
                      hintText: 'Select Date of Birth',
                    ),
                    inputType: InputType.date,
                    validator: FormBuilderValidators.required(),
                    onChanged: (date) {

                    },

                  ),
                ),
                kVerticalSpacerSmall,

              ],
              if (state.manageBookingResponse?.result
                  ?.passengersWithSSR?[i].passengers?.passengerType != 'INF') ...[
                AppInputText(
                  name: 'rewardKey',
                  initialValue: state.manageBookingResponse?.result
                      ?.passengersWithSSR?[i].passengers?.passengerType,
                  hintText: 'Membership ID',
                  inputFormatters: [AppFormUtils.onlyNumber()],
                  textInputType: TextInputType.number,

                ),
                kVerticalSpacerMini,
              ],
            ],
            kVerticalSpacer,


            ElevatedButton(
              onPressed: () async {

                bool? check = await showDialog(


                  context: context,
                  builder: (BuildContext context) {
                    return const DgnInfoView();
                  },
                );

              },
              child: const Text('Check-In'),
            ),

            kVerticalSpacer,
            kVerticalSpacer,

          ],
        ),
      ),
    );
  }
}

/*
BookingReferenceLabel(
                      refText: bloc?.state.pnrEntered,
                    ),
* */
