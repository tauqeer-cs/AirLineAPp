
import 'package:app/data/responses/manage_booking_response.dart';
import 'package:app/widgets/app_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';

import '../../../blocs/countries/countries_cubit.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../utils/form_utils.dart';
import '../../../widgets/app_countries_dropdown.dart';
import '../../../widgets/app_loading_screen.dart';
import '../../../widgets/containers/app_expanded_section.dart';
import '../../../widgets/forms/app_input_text.dart';
import '../../booking_details/ui/flight_data.dart';
import '../../checkout/pages/booking_details/ui/shadow_input.dart';
import '../../select_change_flight/ui/booking_refrence_label.dart';
import '../bloc/check_in_cubit.dart';
import 'boarding_pass_view.dart';
import 'check_in_steps.dart';
import 'dgnInfo_view.dart';

class CheckInDetailView extends StatefulWidget {
final bool isPast;
static final _fbKey = GlobalKey<FormBuilderState>();

const CheckInDetailView({Key? key, required this.isPast}) : super(key: key);

@override
State<CheckInDetailView> createState() => _CheckInDetailViewState();
}

class _CheckInDetailViewState extends State<CheckInDetailView> {
  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<CheckInCubit>();

    if (bloc.showCheckInButton == true) {
      bloc.loadBoardingDate();
    }
    final locale = context.locale.toString();
    CountriesCubit? cbloc = context.read<CountriesCubit>();


    return BlocBuilder<CheckInCubit, CheckInState>(
      bloc: bloc,
      builder: (context, state) {
        return Padding(
          padding: kPageHorizontalPadding,
          child: SingleChildScrollView(
            child: FormBuilder(
              autoFocusOnValidationFailure: true,
              key: CheckInDetailView._fbKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  BookingReferenceLabel(
                    refText: state.pnrEntered,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CheckInSteps(
                      passedSteps: const [
                        CheckInStep.itinerary,
                      ],
                      onTopStepTaped: (i) {},
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'flightDetail.itinerary'.tr(),
                    style: kHugeSemiBold.copyWith(
                      color: Styles.kTextColor,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  kVerticalSpacerSmall,
                  AppCard(
                    edgeInsets:
                    const EdgeInsets.only(right: 15, top: 15, bottom: 15),
                    child: Row(
                      children: [
                        if (state.manageBookingResponse?.result
                            ?.outboundCheckingAllowed ==
                            false) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: SizedBox(
                              width: Checkbox.width,
                              height: Checkbox.width,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Styles.kDisabledGrey,
                                    width: 1.6,
                                  ),
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                              ),
                            ),
                          )
                        ] else ...[
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                            MaterialStateProperty.resolveWith(getColor),
                            value: state.checkedDeparture,
                            onChanged: (bool? value) {
                              setState(() {
                                bloc.setCheckDeparture(value ?? false);

                              });
                            },
                          ),
                        ],
                        Expanded(
                          child: FlightDataInfo(
                            headingLabel: 'departure'.tr(),
                            disabledView: state.manageBookingResponse?.result
                                ?.outboundCheckingAllowed ==
                                false,
                            dateToShow: state.manageBookingResponse?.result
                                ?.departureDateToShow(locale) ??
                                '',
                            departureToDestinationCode: state
                                .manageBookingResponse
                                ?.result
                                ?.departureToDestinationCode ??
                                '',
                            departureDateWithTime: state.manageBookingResponse
                                ?.result?.departureDateWithTime(locale) ??
                                '',
                            departureAirportName: state.manageBookingResponse
                                ?.result?.departureAirportName ??
                                '',
                            journeyTimeInHourMin: state.manageBookingResponse
                                ?.result?.journeyTimeInHourMin ??
                                '',
                            arrivalDateWithTime: state.manageBookingResponse
                                ?.result?.arrivalDateWithTime(locale) ??
                                '',
                            arrivalAirportName: state.manageBookingResponse
                                ?.result?.arrivalAirportName ??
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
                          if (state.manageBookingResponse?.result
                              ?.inboundCheckingAllowed ==
                              false) ... [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 14),
                              child: SizedBox(
                                width: Checkbox.width,
                                height: Checkbox.width,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Styles.kDisabledGrey,
                                      width: 1.6,
                                    ),
                                    borderRadius: BorderRadius.circular(2.0),
                                  ),
                                ),
                              ),
                            ),
                          ] else ... [
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                              value: state.checkReturn,
                              onChanged: (bool? value) {
                                setState(() {
                                  bloc.setCheckReturn(value ?? false);

                                });
                              },
                            ),
                          ],
                          Expanded(
                            child: FlightDataInfo(
                              headingLabel: 'return'.tr(),
                              dateToShow: state.manageBookingResponse?.result
                                  ?.returnDepartureDateToShow(locale) ??
                                  '',
                              departureToDestinationCode: state
                                  .manageBookingResponse
                                  ?.result
                                  ?.returnToDestinationCode ??
                                  '',
                              departureDateWithTime: state.manageBookingResponse
                                  ?.result?.returnDepartureDateWithTime(locale) ??
                                  '',
                              departureAirportName: state.manageBookingResponse
                                  ?.result?.returnDepartureAirportName ??
                                  '',
                              journeyTimeInHourMin: state.manageBookingResponse
                                  ?.result?.returnJourneyTimeInHourMin ??
                                  '',
                              arrivalDateWithTime: state.manageBookingResponse
                                  ?.result?.returnArrivalDateWithTime(locale) ??
                                  '',
                              arrivalAirportName: state.manageBookingResponse
                                  ?.result?.returnArrivalAirportName ??
                                  '',
                            ),
                          ),
                        ],
                      ),
                    ),


                  ],

                  if (state.loadBoardingDate == true || state.isDownloading == true) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: AppLoading(),
                    )
                  ] else if (bloc.showCheckInButton) ...[
                    kVerticalSpacer,
                    if ((state.outboundBoardingPassPassenger ?? [])
                        .isNotEmpty) ...[
                      AppCard(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'boardingPass'.tr(),
                                  style: kHugeSemiBold.copyWith(
                                    color: Styles.kTextColor,
                                  ),
                                ),
                                kVerticalSpacerSmall,
                                Text(
                                  'departFlight'.tr(),
                                  style: kMediumHeavy.copyWith(
                                      color: Styles.kPrimaryColor),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: kMediumRegular.copyWith(
                                        color: Styles.kTextColor),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: state.manageBookingResponse?.result
                                            ?.departureAirportToDestinationName,
                                        //'Kuala Lumpur to Penang —'
                                        style: kMediumSemiBold.copyWith(
                                            color: Styles.kTextColor),
                                      ),
                                      TextSpan(
                                        text: state.manageBookingResponse?.result
                                            ?.departureAirportTime(locale) ??
                                            '',
                                      ),
                                    ],
                                  ),
                                ),
                                kVerticalSpacerSmall,
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () async {

                                            await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {

                                                return const EmailBoardingPassView(
                                                  departure: true,
                                                  bothSides: false,
                                                  onlySelected: false,
                                                );
                                              },
                                            );

                                          }, //isLoading ? null :
                                          child:  Text('flightChange.share'.tr()),
                                        ),
                                      ),
                                      kHorizontalSpacerSmall,
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            //Navigator.of(context).pop(true);
                                            bool? check = await bloc
                                                .getBoardingPassPassengers(true);

                                            if (check == true) {
                                              Fluttertoast.showToast(
                                                  msg: 'fileDownloadedSuccessfully'.tr(),
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.SNACKBAR,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }


                                          },
                                          child:  Text('download'.tr()),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    ],
                    if ((state.inboundBoardingPassPassenger ?? [])
                        .isNotEmpty) ...[
                      kVerticalSpacer,
                      AppCard(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'boardingPass'.tr(),
                                  style: kHugeSemiBold.copyWith(
                                    color: Styles.kTextColor,
                                  ),
                                ),
                                kVerticalSpacerSmall,
                                Text(
                                  'seatsSelection.returnFlight'.tr(),
                                  style: kMediumHeavy.copyWith(
                                      color: Styles.kPrimaryColor),
                                ),
                                RichText(
                                  text: TextSpan(
                                    style: kMediumRegular.copyWith(
                                        color: Styles.kTextColor),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: state.manageBookingResponse?.result
                                            ?.returnAirportToDestinationName,
                                        style: kMediumSemiBold.copyWith(
                                            color: Styles.kTextColor),
                                      ),
                                      TextSpan(
                                        text: state.manageBookingResponse?.result
                                            ?.returnAirportTime(locale) ??
                                            '',
                                      ),
                                    ],
                                  ),
                                ),
                                kVerticalSpacerSmall,
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () async {

                                            await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {

                                                return const EmailBoardingPassView(
                                                  departure: false,
                                                  bothSides: false,
                                                  onlySelected: false,

                                                );
                                              },
                                            );
                                          }, //isLoading ? null :
                                          child:  Text('flightChange.share'.tr()),
                                        ),
                                      ),
                                      kHorizontalSpacerSmall,
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            bool? check = await bloc
                                                .getBoardingPassPassengers(false);

                                            if (check == true) {
                                              Fluttertoast.showToast(
                                                  msg: 'fileDownloadedSuccessfully'.tr(),
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.SNACKBAR,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                  fontSize: 16.0);
                                            }

                                          },
                                          child:  Text('download'.tr()),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )),
                    ],
                  ],
                  kVerticalSpacer,
                  Text(
                    'passenger'.tr(),
                    style: kHugeSemiBold.copyWith(
                      color: Styles.kTextColor,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  kVerticalSpacerSmall,
                  for (int i = 0;
                  i <
                      (state.manageBookingResponse?.result
                          ?.passengersWithSSR ??
                          [])
                          .length;
                  i++) ...[

                    if(state.manageBookingResponse?.result
                        ?.passengersWithSSR?[i].passengers?.passengerType != 'INF') ... [
                      Row(
                        children: [


                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: state.manageBookingResponse?.result
                                ?.passengersWithSSR?[i].paxSelected ??
                                false,
                            onChanged: (bool? value) {


                              if(checkDetails(state.manageBookingResponse?.result
                                  ?.passengersWithSSR?[i],state) == false) {
                                return;

                              }
                              setState(() {
                                bloc.setPerson(value ?? false, i);
                              });
                              if(bloc.showPassport) {

                                var natioanlity = state.manageBookingResponse?.result
                                    ?.passengersWithSSR?[i].passengers?.nationality ?? '';

                                var countries = cbloc.state.countries.where((e) => e.country == natioanlity).toList();

                                String newValue = 'MYS';
                                if(countries.isNotEmpty) {
                                  newValue = countries.first.countryCode ?? 'MYS';
                                }

                                state.manageBookingResponse?.result
                                    ?.passengersWithSSR?[i].passportCountry = newValue;
                                if(state.manageBookingResponse?.result
                                    ?.passengersWithSSR?[i].haveInfant == true) {



                                  state.manageBookingResponse?.result
                                      ?.infanct(state.manageBookingResponse?.result
                                      ?.passengersWithSSR?[i].infantGivenName ?? '',
                                      state.manageBookingResponse?.result
                                          ?.passengersWithSSR?[i].infantSurname ?? '',
                                      state.manageBookingResponse?.result
                                          ?.passengersWithSSR?[i].infantDob ?? '')?.passportCountry = newValue;



                                }
                              }


                            },
                          ),

                          Expanded(
                            child: Text(
                              state.manageBookingResponse?.result
                                  ?.passengersWithSSR?[i].passengers?.fullName ??
                                  '',
                              style: kLargeHeavy.copyWith(
                                color: Styles.kTextColor,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      AppInputText(
                        hintText: "firstNameGivenName".tr(),
                        readOnly: true,
                        validators: [FormBuilderValidators.required()],
                        initialValue: state.manageBookingResponse?.result
                            ?.passengersWithSSR?[i].passengers?.givenName ??
                            '',
                        name: 'firstNameKey$i',
                        fillDisabledColor: true,
                      ),
                      kVerticalSpacerSmall,
                      AppInputText(
                        hintText: 'lastNameSurname'.tr(),
                        readOnly: true,
                        validators: [FormBuilderValidators.required()],
                        initialValue: state.manageBookingResponse?.result
                            ?.passengersWithSSR?[i].passengers?.surname ??
                            '',
                        name: 'lastNameKey$i',
                        fillDisabledColor: true,
                      ),
                      kVerticalSpacerSmall,
                      AppInputText(
                        hintText: 'passengerDetail.nationality'.tr(),
                        readOnly: true,
                        validators: [FormBuilderValidators.required()],
                        initialValue: state.manageBookingResponse?.result
                            ?.passengersWithSSR?[i].passengers?.nationality ??
                            '',
                        name: 'nationalityKey$i',
                        fillDisabledColor: true,
                      ),
                      kVerticalSpacerSmall,
                      if (bloc.showPassport) ...[
                        AppInputText(
                          isRequired: true,
                          name: 'passportKey${i.toString()}',
                          hintText: 'passportNo'.tr(),
                          label: 'passportNo'.tr(),
                          onChanged: (newValue){
                            if (newValue != null) {
                              state
                                  .manageBookingResponse
                                  ?.result
                                  ?.passengersWithSSR?[i]
                                  .checkInPassportNo = newValue;
                            }
                          },
                          initialValue: state.manageBookingResponse?.result
                              ?.passengersWithSSR?[i].passengers?.passport,
                          textInputType: TextInputType.text,

                          validators: [
                                (value){

                              if(state.manageBookingResponse?.result
                                  ?.passengersWithSSR?[i].paxSelected == true) {


                                if(value == null) {
                                  return 'passportRequired'.tr();
                                }
                                if(value.isEmpty) {
                                  return 'passportRequired'.tr();
                                }
                              }
                              return null;
                            }
                          ],
                          //validators: [
                          //  FormBuilderValidators.required(),

                          //],

                        ),
                        if(false) ... [
                          kVerticalSpacerSmall,
                          CheckInDropDownCountry(
                            doValidation: state.manageBookingResponse?.result
                                ?.passengersWithSSR?[i].paxSelected == true,
                            keyName: 'passportNation$i', onChange: (String newValue) {

                            if(newValue != null) {
                              state.manageBookingResponse?.result
                                  ?.passengersWithSSR?[i].passportCountry = newValue;
                            }

                          },
                          ),
                        ],

                        kVerticalSpacerSmall,
                        FormBuilderDateTimePicker(
                          name: 'formNameDob${i.toString()}',
                          firstDate: DateTime.now().add(const Duration(days: 1)),
                          lastDate: DateTime.now().add(Duration(days: 5475)),
                          format: DateFormat("dd MMM yyyy"),
                          onChanged: (newData) {

                            if(newData != null) {
                              state.manageBookingResponse?.result
                                  ?.passengersWithSSR?[i].passExpdate = newData.toString();
                            }



                          },
                          initialDate: DateTime.now().add(const Duration(days: 365)),
                          initialEntryMode: DatePickerEntryMode.calendar,
                          validator: (value){

                            if(state.manageBookingResponse?.result
                                ?.passengersWithSSR?[i].paxSelected == true) {


                              if(value == null) {
                                return 'expDateRequired'.tr();
                              }
                            }

                            return null;

                          },

                          decoration:  InputDecoration(
                              hintText: "passportExpiry".tr(),
                              suffixIcon: Icon(Icons.calendar_month_sharp),
                              contentPadding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 12)),
                          inputType: InputType.date,
                        ),
                        kVerticalSpacerSmall,
                      ],
                      if (state.manageBookingResponse?.result?.passengersWithSSR?[i]
                          .passengers?.passengerType !=
                          'INF') ...[
                        AppInputText(
                          name: 'rewardKey${i.toString()}',
                          initialValue: state.manageBookingResponse?.result
                              ?.passengersWithSSR?[i].passengers?.myRewardMemberId,
                          hintText: 'passengerDetail.membershipID'.tr(),
                          inputFormatters: [AppFormUtils.onlyNumber()],
                          textInputType: TextInputType.number,
                          onChanged: (newText){
                            if(newText != null) {
                              state.manageBookingResponse?.result
                                  ?.passengersWithSSR?[i].checkInMemberID = newText;
                            }
                          },
                        ),
                        kVerticalSpacerMini,

                        if(state.manageBookingResponse?.result
                            ?.passengersWithSSR?[i].haveInfant == true) ... [

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  state.manageBookingResponse?.result
                                      ?.passengersWithSSR?[i].infantExpanded = !(state.manageBookingResponse?.result
                                      ?.passengersWithSSR?[i].infantExpanded ?? true);
                                });
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      'paymentView.infant'.tr(),
                                      style: kHugeHeavy.copyWith(color: Styles.kDartBlack),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      (state.manageBookingResponse?.result
                                          ?.passengersWithSSR?[i].infantExpanded ?? true)
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      size: 25,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),

                          ExpandedSection(
                            expand: state.manageBookingResponse?.result
                                ?.passengersWithSSR?[i].infantExpanded ?? true,
                            child: Column(
                              children: [
                                AppInputText(
                                  hintText: "firstNameGivenName".tr(),
                                  readOnly: true,
                                  validators: [FormBuilderValidators.required()],
                                  initialValue: state.manageBookingResponse?.result
                                      ?.passengersWithSSR?[i].infantGivenName ?? '',
                                  name: 'firstNameKeyInfant$i',
                                  fillDisabledColor: true,
                                ),
                                kVerticalSpacerSmall,
                                AppInputText(
                                  hintText: 'lastNameSurname'.tr(),
                                  readOnly: true,
                                  validators: [FormBuilderValidators.required()],
                                  initialValue: state.manageBookingResponse?.result
                                      ?.passengersWithSSR?[i].infantSurname ?? '',
                                  name: 'lastNameKeyInfant$i',
                                  fillDisabledColor: true,
                                ),
                                kVerticalSpacerSmall,
                                AppInputText(
                                  hintText: 'passengerDetail.nationality'.tr(),
                                  readOnly: true,
                                  validators: [FormBuilderValidators.required()],
                                  initialValue: state.manageBookingResponse?.result
                                      ?.infanctWith(state.manageBookingResponse?.result
                                      ?.passengersWithSSR?[i].infantGivenName ?? '',
                                      state.manageBookingResponse?.result
                                          ?.passengersWithSSR?[i].infantSurname ?? '',
                                      state.manageBookingResponse?.result
                                          ?.passengersWithSSR?[i].infantDob ?? '')?.nationality ?? '',
                                  name: 'nationalityKeyInfant$i',
                                  onChanged: (value){
                                  },
                                  fillDisabledColor: true,
                                ),
                                kVerticalSpacer,

                                if(bloc.showPassport == true) ... [

                                  AppInputText(
                                    isRequired: true,
                                    name: 'infpassportKey${i.toString()}',
                                    hintText: 'passportNo'.tr(),
                                    label: 'passportNo'.tr(),
                                    onChanged: (newValue){
                                      if (newValue != null) {

                                        state.manageBookingResponse?.result
                                            ?.infanct(state.manageBookingResponse?.result
                                            ?.passengersWithSSR?[i].infantGivenName ?? '',
                                            state.manageBookingResponse?.result
                                                ?.passengersWithSSR?[i].infantSurname ?? '',
                                            state.manageBookingResponse?.result
                                                ?.passengersWithSSR?[i].infantDob ?? '')?.checkInPassportNo = newValue;




                                      }
                                    },
                                    initialValue: state.manageBookingResponse?.result
                                        ?.passengersWithSSR?[i].passengers?.passport,
                                    textInputType: TextInputType.text,

                                    validators: [
                                          (value){

                                        if(state.manageBookingResponse?.result
                                            ?.passengersWithSSR?[i].paxSelected == true) {


                                          if(value == null) {
                                            return 'passportRequired'.tr();
                                          }
                                          if(value.isEmpty) {
                                            return 'passportRequired'.tr();
                                          }
                                        }
                                        return null;
                                      }
                                    ],
                                    //validators: [
                                    //  FormBuilderValidators.required(),

                                    //],

                                  ),

                                  if(false) ... [
                                    kVerticalSpacerSmall,
                                    CheckInDropDownCountry(
                                      doValidation: state.manageBookingResponse?.result
                                          ?.passengersWithSSR?[i].paxSelected == true,
                                      keyName: 'infpassportNation$i', onChange: (String newValue) {


                                      state.manageBookingResponse?.result
                                          ?.passengersWithSSR?[i].passportCountry = newValue;

                                      state.manageBookingResponse?.result
                                          ?.infanct(state.manageBookingResponse?.result
                                          ?.passengersWithSSR?[i].infantGivenName ?? '',
                                          state.manageBookingResponse?.result
                                              ?.passengersWithSSR?[i].infantSurname ?? '',
                                          state.manageBookingResponse?.result
                                              ?.passengersWithSSR?[i].infantDob ?? '')?.passportCountry = newValue;





                                    },),
                                  ],

                                  kVerticalSpacerSmall,
                                  FormBuilderDateTimePicker(
                                    name: 'infformNameDob${i.toString()}',
                                    firstDate: DateTime.now().add(Duration(days: 1)),
                                    lastDate: DateTime.now().add(Duration(days: 5475)),
                                    format: DateFormat("dd MMM yyyy"),
                                    onChanged: (newData) {

                                      if(newData != null) {

                                        state.manageBookingResponse?.result
                                            ?.infanct(state.manageBookingResponse?.result
                                            ?.passengersWithSSR?[i].infantGivenName ?? '',
                                            state.manageBookingResponse?.result
                                                ?.passengersWithSSR?[i].infantSurname ?? '',
                                            state.manageBookingResponse?.result
                                                ?.passengersWithSSR?[i].infantDob ?? '')?.passExpdate = newData.toString();


                                      }



                                    },
                                    initialDate: DateTime(2000),
                                    initialEntryMode: DatePickerEntryMode.calendar,
                                    validator: (value){

                                      if(state.manageBookingResponse?.result
                                          ?.passengersWithSSR?[i].paxSelected == true) {


                                        if(value == null) {
                                          return 'passportExpiry'.tr();
                                        }
                                      }

                                      return null;

                                    },
                                    decoration:  InputDecoration(
                                        hintText: "passportExpiry".tr(),
                                        suffixIcon: const Icon(Icons.calendar_month_sharp),
                                        contentPadding:
                                        const EdgeInsets.symmetric(vertical: 15, horizontal: 12)),
                                    inputType: InputType.date,
                                  ),
                                  kVerticalSpacerSmall,

                                ],
                              ],
                            ),

                          ),


                        ],
                      ],
                    ],



                  ],
                  kVerticalSpacer,
                  if (widget.isPast == false) ...[
                    ElevatedButton(

                      onPressed: bloc.showCheckIn == false
                          ? null
                          : () async {


                        if( CheckInDetailView._fbKey.currentState?.validate() == true) {

                          bool? check = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 16),
                                child: DgnInfoView(
                                  valueChanged: (bool value) {},
                                ),
                              );
                            },
                          );

                          if (check == true) {
                            //true
                          }

                        }



                      },
                      child:  Text('checkIn'.tr()),
                    ),
                  ],
                  kVerticalSpacer,
                  kVerticalSpacer,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool checkDetails(PassengersWithSSR? passengersWithSSR,state) {
    if(state.checkedDeparture == false && state.checkReturn == false){
      return false;
    }

    else
    if(state.checkedDeparture == true && state.checkReturn == false) {
      var ccc =  passengersWithSSR?.checkInStatusInOut!.outboundCheckInStatus?.allowCheckIn ?? false;;

      return passengersWithSSR?.checkInStatusInOut!.outboundCheckInStatus?.allowCheckIn ?? false;
    }
    else
    if(state.checkedDeparture == false && state.checkReturn == true) {
      return passengersWithSSR?.checkInStatusInOut!.inboundCheckInStatus?.allowCheckIn ?? false;
    }
    else

    if(state.checkedDeparture == true && state.checkReturn == true) {
      return (passengersWithSSR!.checkInStatusInOut!.outboundCheckInStatus?.allowCheckIn ?? false) || (passengersWithSSR.checkInStatusInOut!.inboundCheckInStatus?.allowCheckIn ?? false);
    }
    return true;

  }
}

/*
BookingReferenceLabel(
                      refText: bloc?.state.pnrEntered,
                    ),
* */


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

class BorderContainer extends StatelessWidget {
  final Widget child;

  const BorderContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Styles.kTextColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
  }
}




class CheckInDropDownCountry extends StatefulWidget {

  final Function(String) onChange;

  final bool doValidation;

  final String keyName;


  const CheckInDropDownCountry({Key? key, required this.keyName, required this.onChange,
    this.doValidation = false}) : super(key: key);

  @override
  State<CheckInDropDownCountry> createState() => _CheckInDropDownCountryState();
}

class _CheckInDropDownCountryState extends State<CheckInDropDownCountry> {

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      ShadowInput(
        name: widget.keyName,
        textEditingController: _controller,
        validators: [
              (value) {
            if(widget.doValidation == true){

              if(value == null) {
                return 'passportCountryRequired'.tr();
              }
            }
          },
        ],
        child: AppCountriesDropdown(
          validators: [
                (value) {
              if(widget.doValidation == true){

                if(value == null) {
                  return 'passportCountryRequired'.tr();
                }
              }
            },
          ],
          hintText: "passportIssuingCountry".tr(),
          customSheetTitle: 'passportIssuingCountry'.tr(),
          dropdownDecoration: Styles.getDefaultFieldDecoration(),
          hideDefualttValue: true,
          isPhoneCode: false,
          onChanged: (value) {
            //nationalityController.text = value?.countryCode2 ?? "";
            widget.onChange(value?.countryCode ?? '');
            _controller.text = value?.country ?? '';
          },
        ),
      );
  }
}

