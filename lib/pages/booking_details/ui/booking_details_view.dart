import 'package:app/models/confirmation_model.dart';
import 'package:app/pages/booking_details/ui/payment_detials_section.dart';
import 'package:app/pages/booking_details/ui/selected_passenger_info.dart';
import 'package:app/pages/booking_details/ui/warning_before_proceed.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app_router.dart';
import '../../../blocs/cms/agent_sign_up/agent_sign_up_cubit.dart';
import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../data/responses/change_ssr_response.dart';
import '../../../data/responses/manage_booking_response.dart';
import '../../../data/responses/verify_response.dart';
import '../../../models/number_person.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../utils/custom_segment.dart';
import '../../../widgets/app_money_widget.dart';
import '../../add_on/baggage/ui/baggage_section.dart';
import '../../add_on/baggage/ui/baggage_view.dart';
import '../../add_on/meals/ui/meals_section.dart';
import '../../add_on/seats/ui/seat_legend_simple.dart';
import '../../add_on/seats/ui/seat_plan.dart';
import '../../add_on/special/ui/wheelchair_section.dart';
import '../../add_on/summary/ui/baggage_summary_detail.dart';
import '../../add_on/summary/ui/flight_detail.dart';
import '../../add_on/summary/ui/meal_summary_detail.dart';
import '../../add_on/summary/ui/seat_detail.dart';
import '../../add_on/summary/ui/special_summary_detail.dart';
import '../../add_on/ui/passenger_selector.dart';
import '../../checkout/pages/insurance/bloc/insurance_cubit.dart';
import '../../checkout/pages/insurance/ui/available_insurance.dart';
import '../../checkout/pages/insurance/ui/insurance_view.dart';
import '../../checkout/pages/insurance/ui/passenger_insurance_selector.dart';
import '../../checkout/pages/insurance/ui/zurich_container.dart';
import '../../checkout/ui/empty_addon.dart';
import '../../search_result/ui/booking_summary.dart';
import '../../select_change_flight/ui/booking_refrence_label.dart';
import 'add_on_options.dart';
import 'add_ons_card_items.dart';
import 'company_tax_invoice_section.dart';
import 'contants_section.dart';
import 'double_line_text.dart';
import 'emergency_contect_section.dart';
import 'flight_data.dart';
import 'package:app/data/responses/verify_response.dart' as VRR;

class ManageBookingDetailsView extends StatelessWidget {
  final VoidCallback onSharedTapped;

  ManageBookingDetailsView({Key? key, required this.onSharedTapped})
      : super(key: key);

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

  ManageBookingCubit? bloc;

  @override
  Widget build(BuildContext context) {
    bloc = context.watch<ManageBookingCubit>();
    final locale = context.locale.toString();
    var selectedPax = context.watch<ManageBookingCubit>().state.selectedPax;

    bool showSsr = true;
    bool showPax = true;

    if (selectedPax == null) {
      print('');

      var tmpSelectedPax = context
          .watch<ManageBookingCubit>()
          .state
          .manageBookingResponse
          ?.result
          ?.passengersWithSSR
          ?.first;

      if (tmpSelectedPax != null) {
        bloc?.changeSelectedPax(tmpSelectedPax);
      }
    }
    return BlocBuilder<ManageBookingCubit, ManageBookingState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BookingReferenceLabel(
                        refText: state.pnrEntered,
                      ),
                      kVerticalSpacer,
                      AppCard(
                        edgeInsets: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Checkbox(
                                      checkColor: Colors.white,
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                              getColor),
                                      value: state.checkedDeparture,
                                      onChanged: (bool? value) {
                                        bloc?.setCheckDeparture(value ?? false);
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: FlightDataInfo(
                                      headingLabel: "departure".tr(),
                                      dateToShow: state
                                              .manageBookingResponse?.result
                                              ?.departureDateToShow(locale) ??
                                          '',
                                      departureToDestinationCode: state
                                              .manageBookingResponse
                                              ?.result
                                              ?.departureToDestinationCode ??
                                          '',
                                      departureDateWithTime: state
                                              .manageBookingResponse?.result
                                              ?.departureDateWithTime(locale) ??
                                          '',
                                      departureAirportName: state
                                              .manageBookingResponse
                                              ?.result
                                              ?.departureAirportName ??
                                          '',
                                      journeyTimeInHourMin: state
                                              .manageBookingResponse
                                              ?.result
                                              ?.journeyTimeInHourMin ??
                                          '',
                                      arrivalDateWithTime: state
                                              .manageBookingResponse?.result
                                              ?.arrivalDateWithTime(locale) ??
                                          '',
                                      arrivalAirportName: state
                                              .manageBookingResponse
                                              ?.result
                                              ?.arrivalAirportName ??
                                          '',
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Divider(),
                              ),
                              if ((state.manageBookingResponse?.isTwoWay ??
                                  false)) ...[
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Checkbox(
                                        checkColor: Colors.white,
                                        fillColor:
                                            MaterialStateProperty.resolveWith(
                                                getColor),
                                        value: state.checkReturn,
                                        onChanged: (bool? value) {
                                          bloc?.setCheckReturn(value ?? false);
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: FlightDataInfo(
                                        headingLabel:
                                            'flightCharge.return'.tr(),
                                        dateToShow: state
                                                .manageBookingResponse?.result
                                                ?.returnDepartureDateToShow(
                                                    locale) ??
                                            '',
                                        departureToDestinationCode: state
                                                .manageBookingResponse
                                                ?.result
                                                ?.returnToDestinationCode ??
                                            '',
                                        departureDateWithTime: state
                                                .manageBookingResponse?.result
                                                ?.returnDepartureDateWithTime(
                                                    locale) ??
                                            '',
                                        departureAirportName: state
                                                .manageBookingResponse
                                                ?.result
                                                ?.returnDepartureAirportName ??
                                            '',
                                        journeyTimeInHourMin: state
                                                .manageBookingResponse
                                                ?.result
                                                ?.returnJourneyTimeInHourMin ??
                                            '',
                                        arrivalDateWithTime: state
                                                .manageBookingResponse?.result
                                                ?.returnArrivalDateWithTime(
                                                    locale) ??
                                            '',
                                        arrivalAirportName: state
                                                .manageBookingResponse
                                                ?.result
                                                ?.returnArrivalAirportName ??
                                            '',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              kVerticalSpacer,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: OutlinedButton(
                                  onPressed: () {
                                    onSharedTapped();
                                  }, //isLoading ? null :
                                  child: Text('flightChange.share'.tr()),
                                  /*
                                  * isLoading
                                      ? const AppLoading(
                                    size: 20,
                                  )*/
                                ),
                              ),
                              kVerticalSpacerSmall,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: ElevatedButton(
                                  onPressed: (state.checkedDeparture ||
                                              state.checkReturn) !=
                                          true
                                      ? null
                                      : () async {
                                          //   context.router.replaceAll([const NavigationRoute()]);
                                          final allowedChange =
                                              isAllowedToContinue(state);
                                          if (!allowedChange) {
                                            Toast.of(context).show(
                                                success: false,
                                                message:
                                                    'flightCharge.twoDayChangeError'
                                                        .tr());
                                            return;
                                          }
                                          bool? check = await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const AlertWarningBeforeProceed();
                                            },
                                          );
                                          bloc?.setFlightDates();

                                          if (check == true) {
                                            context.router.push(
                                              const NewTravelDatesRoute(),
                                            );
                                          }
                                        },
                                  child: Text(
                                    'flightResult.changeFlight'.tr(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      kVerticalSpacer,
                      if (showPax == true) ...[
                        PassengerSelectorManageBooking(
                          passengersWithSSR: bloc?.state.manageBookingResponse
                                  ?.result?.passengersWithSSRWithoutInfant ??
                              [],
                        ),
                        kVerticalSpacer,
                        SelectedPassengerInfo(selectedPax),
                        kVerticalSpacerSmall,
                      ],
                      if (showSsr == true) ...[
                        const AddOnOptions(),
                        kVerticalSpacer,
                        if (bloc?.state.addOnOptionSelected ==
                            AddonType.seat) ...[
                          kVerticalSpacerMini,
                          WarningLabel(
                            message: 'weSorrySeatSelected'.tr(),
                          ),
                          kVerticalSpacerSmall,
                          if (bloc?.state.manageBookingResponse?.result
                                  ?.isReturn ==
                              true) ...[
                            CustomSegmentControl(
                              optionOneTapped: () {
                                bloc?.setSelectionDeparture(true, isSeat: true);
                              },
                              optionTwoTapped: () {
                                bloc?.setSelectionDeparture(false,
                                    isSeat: true);
                              },
                              isSelectedOption1:
                                  bloc?.state.seatDeparture ?? true,
                              textOne:
                                  '${'departFlight'.tr()}\n(${bloc?.state.manageBookingResponse?.result?.departureToDestinationCodeDash ?? ''})',
                              textTwo:
                                  '${'returningFlight'.tr()}\n(${bloc?.state.manageBookingResponse?.result?.returnToDestinationCodeDash ?? ''})',
                              customRadius: 12,
                              customBorderWidth: 1,
                              customVerticalPadding: 8,
                              customSelectedStyle: kMediumSemiBold.copyWith(
                                  color: Styles.kPrimaryColor),
                              customNoSelectedStyle: kMediumSemiBold.copyWith(
                                  color: Styles.kLightBgColor),
                            ),
                            kVerticalSpacer,
                          ],
                          const SeatLegendSimple(),
                          kVerticalSpacer,
                          SeatPlan(
                            moveToTop: () {
                              //moveToTop?.call();
                            },
                            moveToBottom: () {
                              //  moveToBottom?.call();
                            },
                            isManageBooking: true,
                          ),
                          kVerticalSpacer,
                        ] else if (bloc?.state.addOnOptionSelected ==
                            AddonType.meal) ...[
                          false
                              ? Container()
                              : WarningLabel(
                                  message: 'mealAddOnsAreUnavailable'.tr(),
                                ),
                          kVerticalSpacerSmall,
                          if (bloc?.state.manageBookingResponse?.result
                                  ?.isReturn ==
                              true) ...[
                            CustomSegmentControl(
                              optionOneTapped: () {
                                bloc?.setSelectionDeparture(true, isFood: true);
                              },
                              optionTwoTapped: () {
                                bloc?.setSelectionDeparture(false,
                                    isFood: true);
                              },
                              isSelectedOption1:
                                  bloc?.state.foodDepearture ?? true,
                              textOne:
                                  '${'departFlight'.tr()}\n(${bloc?.state.manageBookingResponse?.result?.departureToDestinationCodeDash ?? ''})',
                              textTwo:
                                  '${'returningFlight'.tr()}\n(${bloc?.state.manageBookingResponse?.result?.returnToDestinationCodeDash ?? ''})',
                              customRadius: 12,
                              customBorderWidth: 1,
                              customVerticalPadding: 8,
                              customSelectedStyle: kMediumSemiBold.copyWith(
                                  color: Styles.kPrimaryColor),
                              customNoSelectedStyle: kMediumSemiBold.copyWith(
                                  color: Styles.kLightBgColor),
                            ),
                            kVerticalSpacerSmall,
                          ],
                          MealsSection(
                            isDeparture: bloc?.state.foodDepearture ?? false,
                            isManageBooking: true,
                          ),
                        ] else if (bloc?.state.addOnOptionSelected ==
                            AddonType.baggage) ...[
                          kVerticalSpacerSmall,
                          if (bloc?.state.manageBookingResponse?.result
                                  ?.isReturn ==
                              true) ...[
                            CustomSegmentControl(
                              optionOneTapped: () {
                                bloc?.setSelectionDeparture(true,
                                    isBaggage: true);
                              },
                              optionTwoTapped: () {
                                bloc?.setSelectionDeparture(false,
                                    isBaggage: true);
                              },
                              isSelectedOption1:
                                  bloc?.state.baggageDeparture ?? true,
                              textOne:
                                  '${'departFlight'.tr()}\n(${bloc?.state.manageBookingResponse?.result?.departureToDestinationCodeDash ?? ''})',
                              textTwo:
                                  '${'returningFlight'.tr()}\n(${bloc?.state.manageBookingResponse?.result?.returnToDestinationCodeDash ?? ''})',
                              customRadius: 12,
                              customBorderWidth: 1,
                              customVerticalPadding: 8,
                              customSelectedStyle: kMediumSemiBold.copyWith(
                                  color: Styles.kPrimaryColor),
                              customNoSelectedStyle: kMediumSemiBold.copyWith(
                                  color: Styles.kLightBgColor),
                            ),
                            kVerticalSpacerSmall,
                          ],
                          BaggageSection(
                            isManageBooking: true,
                            isDeparture: bloc?.state.baggageDeparture ?? false,
                            moveToTop: () {},
                            moveToBottom: () {},
                          ),
                        ] else if (bloc?.state.addOnOptionSelected ==
                            AddonType.special) ...[
                          kVerticalSpacer,
                          if (bloc?.state.manageBookingResponse?.result
                                  ?.isReturn ==
                              true) ...[
                            CustomSegmentControl(
                              optionOneTapped: () {
                                bloc?.setSelectionDeparture(true,
                                    isSpecial: true);
                              },
                              optionTwoTapped: () {
                                bloc?.setSelectionDeparture(false,
                                    isSpecial: true);
                              },
                              isSelectedOption1:
                                  bloc?.state.specialAppOpsDeparture ?? true,
                              textOne:
                                  '${'departFlight'.tr()}\n(${bloc?.state.manageBookingResponse?.result?.departureToDestinationCodeDash ?? ''})',
                              textTwo:
                                  '${'returningFlight'.tr()}\n(${bloc?.state.manageBookingResponse?.result?.returnToDestinationCodeDash ?? ''})',
                              customRadius: 12,
                              customBorderWidth: 1,
                              customVerticalPadding: 8,
                              customSelectedStyle: kMediumSemiBold.copyWith(
                                  color: Styles.kPrimaryColor),
                              customNoSelectedStyle: kMediumSemiBold.copyWith(
                                  color: Styles.kLightBgColor),
                            ),
                            kVerticalSpacerSmall,
                          ],
                          WheelchairSection(
                              isDeparture:
                                  bloc?.state.specialAppOpsDeparture ?? false,
                              isManageBooking: true),
                          kVerticalSpacer,
                        ] else if (bloc?.state.addOnOptionSelected ==
                            AddonType.insurance) ...[
                          //InsuranceView(isManageBooking: true,),
                          const InsuranceManageView(),
                        ] else ...[
                          const ManageFlightSummary(),
                        ],
                      ],
                      if (showPax == true) ...[
                        const ContactsSection(),
                        kVerticalSpacer,
                        const EmergencyContactsSection(),
                        kVerticalSpacer,
                        const ComapnyTaxInvoiceSection(),
                        kVerticalSpacer,
                        //  const PaymentDetailsSecond(),
                      ],
                    ],
                  ),
                ),
              ),
              if (bloc?.showPayOption == true) ...[
                SummaryContainer(
                  child: bloc?.state.isPaying == true
                      ? const AppLoading()
                      : Padding(
                          padding: kPagePadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  //bloc?.saveContactChanges();

                                  //return;
                                  ChangeSsrResponse? response =
                                      await bloc?.checkSsrChange();

                                  if (response != null) {
                                    var redirectUrl = await bloc
                                        ?.checkOutForPaymentSSR('', response);

                                    if (redirectUrl != null) {
                                      final result = await context.router.push(
                                        WebViewRoute(
                                            url: "", htmlContent: redirectUrl),
                                      );

                                      if (result != null && result is String) {
                                        final urlParsed = Uri.parse(result);
                                        var query =
                                            urlParsed.queryParametersAll;
                                        String? status = query['status']?.first;
                                        String? superPNR = query['pnr']?.first;

                                        if (status != "FAIL") {
                                          bloc?.reloadDataForConfirmation(
                                              status ?? '', superPNR ?? '');

                                          if (true) {
                                            //mounted
                                            /*final filter = context
                                    .read<SearchFlightCubit>()
                                    .state
                                    .filterState;

                                final bookingLocal = BookingLocal(
                                  bookingId: superPNR,
                                  departureDate: filter?.departDate,
                                  returnDate: filter?.returnDate,
                                  departureString: filter?.beautify,
                                  returnString: filter?.beautifyReverse,
                                );

                                context
                                    .read<BookingLocalCubit>()
                                    .saveBooking(bookingLocal);

                                FlutterInsider.Instance.itemPurchased(
                                  superPNR.setNoneIfNullOrEmpty,
                                  UserInsider.of(context).generateProduct(),
                                );*/
                                          }

                                          context.router.replaceAll([
                                            const NavigationRoute(),
                                            ChangeFlightConfirmationRoute(
                                              bookingId: superPNR ?? "",
                                              status: status ?? '',
                                            ),
                                          ]);
                                        } else {}
                                      } else {}
                                    }
                                  }
                                },
                                child: const Text('Pay'),
                              ),
                            ],
                          ),
                        ),
                ),
              ] else if (bloc?.state.anyContactValueChange == true) ...[
                SummaryContainer(
                  child: bloc?.state.savingContactChanges == true
                      ? const AppLoading()
                      : Padding(
                          padding: kPagePadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  //bloc?.saveContactChanges();

                                  //return;
                                  ChangeSsrResponse? response =
                                      await bloc?.checkSsrChange();

                                  if (response != null) {
                                    var redirectUrl = await bloc
                                        ?.checkOutForPaymentSSR('', response);

                                    if (redirectUrl != null) {
                                      final result = await context.router.push(
                                        WebViewRoute(
                                            url: "", htmlContent: redirectUrl),
                                      );

                                      if (result != null && result is String) {
                                        final urlParsed = Uri.parse(result);
                                        var query =
                                            urlParsed.queryParametersAll;
                                        String? status = query['status']?.first;
                                        String? superPNR = query['pnr']?.first;

                                        if (status != "FAIL") {
                                          bloc?.reloadDataForConfirmation(
                                              status ?? '', superPNR ?? '');

                                          if (true) {
                                            //mounted
                                            /*final filter = context
                                    .read<SearchFlightCubit>()
                                    .state
                                    .filterState;

                                final bookingLocal = BookingLocal(
                                  bookingId: superPNR,
                                  departureDate: filter?.departDate,
                                  returnDate: filter?.returnDate,
                                  departureString: filter?.beautify,
                                  returnString: filter?.beautifyReverse,
                                );

                                context
                                    .read<BookingLocalCubit>()
                                    .saveBooking(bookingLocal);

                                FlutterInsider.Instance.itemPurchased(
                                  superPNR.setNoneIfNullOrEmpty,
                                  UserInsider.of(context).generateProduct(),
                                );*/
                                          }

                                          context.router.replaceAll([
                                            const NavigationRoute(),
                                            ChangeFlightConfirmationRoute(
                                              bookingId: superPNR ?? "",
                                              status: status ?? '',
                                            ),
                                          ]);
                                        } else {}
                                      } else {}
                                    }
                                  }
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  bool isAllowedToContinue(ManageBookingState manageBookingState) {
    if (manageBookingState.checkedDeparture &&
        !(manageBookingState.manageBookingResponse?.result?.flightSegments
                ?.firstOrNull?.outbound?.firstOrNull?.isChangeAllowed ??
            true)) {
      return false;
    }
    if (manageBookingState.checkReturn &&
        !(manageBookingState.manageBookingResponse?.result?.flightSegments
                ?.firstOrNull?.inbound?.firstOrNull?.isChangeAllowed ??
            true)) {
      return false;
    }
    return true;
  }
}

class WarningLabel extends StatelessWidget {
  final String message;

  const WarningLabel({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Styles.kActiveGrey),
        color: Styles.kActiveGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Text(
          message,
          style: kMediumMedium.copyWith(
            color: Styles.kCanvasColor,
          ),
        ),
      ),
    );
  }
}

class InsuranceManageView extends StatelessWidget {
  const InsuranceManageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Bundle? firstInsurance;

    var bloc = context.watch<ManageBookingCubit>();
    var state = bloc.state;

    List<Bundle> insurances = state.flightSSR?.insuranceGroup?.outbound ?? [];
    List<PassengersWithSSR> passengers =
        state.manageBookingResponse?.result?.passengersWithSSRWithoutInfant ??
            [];
    firstInsurance = insurances.firstOrNull;

    String? logoImage = '';

    int selectedPassengers = 0;
    Bundle? lastInsuranceSelected;
    InsuranceType? selected;

    String currency = 'MYR';

    if ((insurances ?? []).isNotEmpty) {
      final agentCms = context.watch<AgentSignUpCubit>().state;

      String insuranceCode = firstInsurance?.codeType ?? '';

      if (agentCms.locationItem != null) {
        if (agentCms.locationItem?.items
                ?.where((e) => e.code == insuranceCode)
                .toList()
                .isNotEmpty ==
            true) {
          logoImage = agentCms.locationItem?.banner;
        }
      }

      if ((logoImage ?? '').isEmpty) {
        if (agentCms.internationalItem != null) {
          if (agentCms.internationalItem?.items
                  ?.where((e) => e.code == insuranceCode)
                  .toList()
                  .isNotEmpty ==
              true) {
            logoImage = agentCms.internationalItem?.banner;
          }
        }
      }

      if ((logoImage ?? '').isEmpty) {
        if (insuranceCode.contains('DL')) {
          logoImage = agentCms.locationItem?.banner;
        }
      }

      if ((logoImage ?? '').isEmpty) {
        logoImage = agentCms.internationalItem?.banner;
      }
    }

    final agentCms = context.watch<AgentSignUpCubit>();

    return Column(
      children: [
        if (insurances.isNotEmpty) ...[
          Text(
            "myAirTravelInsurance".tr(),
            style: kHugeHeavy,
          ),
          kVerticalSpacer,
          ZurichContainer(
            bannerImageUrl: logoImage,
          ),
          kVerticalSpacer,
          Visibility(
            visible: insurances.isNotEmpty,
            replacement: const EmptyAddon(),
            child: Column(
              children: InsuranceType.values
                  .map(
                    (e) => InkWell(
                      onTap: () {
                        /*
                    final bookingState = context.read<BookingCubit>().state;
                    final firstInsurance = bookingState.verifyResponse?.flightSSR
                        ?.insuranceGroup?.outbound?.firstOrNull;
                    if (firstInsurance == null) return;
                    print("first insurance not null $e");
                    context.read<InsuranceCubit>().changeInsuranceType(
                        e, firstInsurance.toBound(isInsurance: true));*/
                      },
                      child: AppCard(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Theme(
                                  data: ThemeData(
                                    unselectedWidgetColor: Styles.kActiveGrey,
                                  ),
                                  child: IgnorePointer(
                                    ignoring: true,
                                    child: Radio<InsuranceType?>(
                                      value: e,
                                      visualDensity: const VisualDensity(
                                        horizontal: -2,
                                        vertical: -2,
                                      ),
                                      activeColor: Styles.kPrimaryColor,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      groupValue: selected,
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                kHorizontalSpacerSmall,
                                Expanded(
                                  child: AvailableInsurance.getTitle(
                                      e,
                                      lastInsuranceSelected ?? firstInsurance,
                                      passengers.length),
                                ),
                                kHorizontalSpacerSmall,
                                SizedBox(
                                  height: 56,
                                  width: 56,
                                  child: AvailableInsurance.getAssets(e) == null
                                      ? const SizedBox()
                                      : Image.asset(
                                          AvailableInsurance.getAssets(e)!),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: e == selected && e != InsuranceType.none,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Column(
                                  children: [
                                    Visibility(
                                      visible: e == InsuranceType.selected,
                                      child: const PassengerInsuranceSelector(),
                                    ),
                                    ...insurances.map(
                                      (e) {
                                        final bound =
                                            e.toBound(isInsurance: true);

                                        var tmp = Bound();

                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          child: InkWell(
                                            onTap: () {
                                              /*
                                          if (selected == InsuranceType.all) {

                                            insuranceBloc.setLast(insurancesGroup?.outbound?.firstWhereOrNull((element) => element == e));



                                            context
                                                .read<InsuranceCubit>()
                                                .updateInsuranceToAllPassenger(
                                                bound);

                                          } else {
                                            Bound? currentInsurance =
                                                passengers[selectedPassengers]
                                                    .getInsurance;


                                            if (currentInsurance == null) {

                                              context
                                                  .read<InsuranceCubit>()
                                                  .updateInsuranceToPassenger(
                                                  selectedPassengers, bound,e.codeType);
                                            } else {

                                              context
                                                  .read<InsuranceCubit>()
                                                  .updateInsuranceToPassenger(
                                                  selectedPassengers, null,e.codeType);
                                            }
                                          }*/
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: Styles
                                                          .kDisabledButton)),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    AvailableInsurance
                                                        .dataTitle(e, agentCms),
                                                    style: kLargeHeavy,
                                                  ),
                                                  AvailableInsurance
                                                      .buildSubtitle(
                                                          e, agentCms),
                                                  kVerticalSpacerSmall,
                                                  MoneyWidgetCustom(
                                                    currency: currency,
                                                    myrSize: 20,
                                                    amountSize: 20,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    textColor:
                                                        Styles.kPrimaryColor,
                                                    amount: e.finalAmount,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  kVerticalSpacer,
                                                  IgnorePointer(
                                                    ignoring: true,
                                                    child: Radio<Bound?>(
                                                      value: tmp,
                                                      visualDensity:
                                                          const VisualDensity(
                                                        horizontal: -2,
                                                        vertical: -2,
                                                      ),
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      groupValue: passengers[
                                                              selectedPassengers]
                                                          .getInsurance,
                                                      onChanged: (value) {},
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList()
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ] else ...[
          EmptyAddon(
            icon: "assets/images/icons/icoNoInsurance.png",
            customText: 'insuranceTempUnavailable'.tr(),
          ),
        ],
      ],
    );
  }
}

class ManageFlightSummary extends StatelessWidget {
  const ManageFlightSummary({Key? key}) : super(key: key);

  //String currency = 'MYR';

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ManageBookingCubit>();

    String currency =
        bloc.state.manageBookingResponse?.result?.superPNROrder?.currencyCode ??
            'MYR';

    var totalPrice = bloc.confirmedSeatsTotalPrice +
        bloc.confirmedMealsTotalPrice +
        bloc.confirmedBaggageTotalPrice +
        bloc.confirmedWheelChairTotalPrice;

    return totalPrice == 0.0 ? Container() : AppCard(
      child: Column(
        children: [
          ChildRow(
            child1: Text(
              'summary'.tr(),
              style: kHugeHeavy,
            ),
            child2: MoneyWidgetCustom(
              amountSize: 16,
              currency: currency,
              myrSize: 20,
              amount: totalPrice,
              textColor: Styles.kPrimaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          FlightSummaryDetail(
            isDeparture: true,
            currency: currency,
            dontShowAmount: true,
            isManageBooking: true,
          ),
          if (bloc.state.manageBookingResponse?.result?.isReturn == true) ...[
            FlightSummaryDetail(
              isDeparture: false,
              currency: currency,
              dontShowAmount: true,
              isManageBooking: true,
            ),
          ],

          SeatSummaryDetail(
            currency: currency,
            isManageBooking: true,
          ),

          MealSummaryDetail(
            currency: currency,
            isManageBooking: true,
          ),

          BaggageSummaryDetail(
            currency: currency,
            sports: false,
            isManageBooking: true,
          ),
          // BaggageSummaryDetail(currency: currency, sports: true,isManageBooking: true,),
          SpecialSummaryDetail(
            currency: currency,
            isManageBooking: true,
          ),
        ],
      ),
    );
  }
}
