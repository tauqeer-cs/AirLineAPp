import 'package:app/pages/booking_details/ui/payment_detials_section.dart';
import 'package:app/pages/booking_details/ui/payment_success.dart';
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
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../app/app_bloc_helper.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../blocs/search_flight/search_flight_cubit.dart';
import '../../../app/app_router.dart';
import '../../../blocs/cms/agent_sign_up/agent_sign_up_cubit.dart';
import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../blocs/voucher/voucher_cubit.dart';
import '../../../data/requests/voucher_request.dart';
import '../../../data/responses/change_ssr_response.dart';
import '../../../data/responses/manage_booking_response.dart';
import '../../../data/responses/verify_response.dart';
import '../../../models/number_person.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../utils/constant_utils.dart';
import '../../../utils/custom_segment.dart';
import '../../../widgets/app_divider_widget.dart';
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
import '../../add_on/ui/summary_list_item.dart';
import '../../change_flight_summary/ui/change_flight_summary_view.dart';
import '../../check_in/ui/check_in_view.dart';
import '../../checkout/pages/insurance/bloc/insurance_cubit.dart';
import '../../checkout/pages/insurance/ui/available_insurance.dart';
import '../../checkout/pages/insurance/ui/insurance_view.dart';
import '../../checkout/pages/insurance/ui/passenger_insurance_selector.dart';
import '../../checkout/pages/insurance/ui/zurich_container.dart';
import '../../checkout/pages/payment/ui/discount_summary.dart';
import '../../checkout/pages/payment/ui/voucher_ui.dart';
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
  final VoidCallback reloadView;

  ManageBookingDetailsView(
      {Key? key, required this.onSharedTapped, required this.reloadView})
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

  GlobalKey horizKey1 = GlobalKey();
  GlobalKey horizKey2 = GlobalKey();
  GlobalKey horizKeyS1 = GlobalKey();
  GlobalKey horizKeyS2 = GlobalKey();

  GlobalKey horizKeyW1 = GlobalKey();
  GlobalKey horizKeyW2 = GlobalKey();

  ManageBookingCubit? bloc;
  static final fbKey = GlobalKey<FormBuilderState>();
  static final fbKey2 = GlobalKey<FormBuilderState>();
  static final _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    bloc = context.watch<ManageBookingCubit>();
    final locale = context.locale.toString();
    var selectedPax = context.watch<ManageBookingCubit>().state.selectedPax;

    bool showSsr = true;
    bool showPax = true;

    var voucherBloc = context.watch<VoucherCubit>();
    var voucherState = voucherBloc.state;
    final discount = voucherState.response?.addVoucherResult?.voucherDiscounts
            ?.firstOrNull?.discountAmount ??
        0;

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
        return bloc?.state.extraLoading == true
            ? const Center(
                child: AppLoading(),
              )
            : Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: BookingReferenceLabel(
                                refText: state.pnrEntered,
                              ),
                            ),
                            kVerticalSpacer,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: AppCard(
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
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: state.checkedDeparture,
                                              onChanged: (bool? value) {
                                                bloc?.setCheckDeparture(
                                                    value ?? false);
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: FlightDataInfo(
                                              headingLabel: "departure".tr(),
                                              dateToShow: state
                                                      .manageBookingResponse
                                                      ?.result
                                                      ?.departureDateToShow(
                                                          locale) ??
                                                  '',
                                              departureToDestinationCode: state
                                                      .manageBookingResponse
                                                      ?.result
                                                      ?.departureToDestinationCode ??
                                                  '',
                                              departureDateWithTime: state
                                                      .manageBookingResponse
                                                      ?.result
                                                      ?.departureDateWithTime(
                                                          locale) ??
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
                                                      .manageBookingResponse
                                                      ?.result
                                                      ?.arrivalDateWithTime(
                                                          locale) ??
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
                                      if ((state.manageBookingResponse
                                              ?.isTwoWay ??
                                          false)) ...[
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(0.0),
                                              child: Checkbox(
                                                checkColor: Colors.white,
                                                fillColor: MaterialStateProperty
                                                    .resolveWith(getColor),
                                                value: state.checkReturn,
                                                onChanged: (bool? value) {
                                                  bloc?.setCheckReturn(
                                                      value ?? false);
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: FlightDataInfo(
                                                headingLabel: 'return'.tr(),
                                                dateToShow: state
                                                        .manageBookingResponse
                                                        ?.result
                                                        ?.returnDepartureDateToShow(
                                                            locale) ??
                                                    '',
                                                departureToDestinationCode: state
                                                        .manageBookingResponse
                                                        ?.result
                                                        ?.returnToDestinationCode ??
                                                    '',
                                                departureDateWithTime: state
                                                        .manageBookingResponse
                                                        ?.result
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
                                                        .manageBookingResponse
                                                        ?.result
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: OutlinedButton(
                                          onPressed: () {
                                            onSharedTapped();
                                          }, //isLoading ? null :
                                          child:
                                              Text('flightChange.share'.tr()),
                                          /*
                                    * isLoading
                                        ? const AppLoading(
                                      size: 20,
                                    )*/
                                        ),
                                      ),
                                      kVerticalSpacerSmall,
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: ElevatedButton(
                                          onPressed: ((state.checkedDeparture ||
                                                          state.checkReturn) !=
                                                      true ||
                                                  bloc?.pendingPayOption ==
                                                      true ||
                                                  bloc?.state.showingVoucher ==
                                                      true)
                                              ? null
                                              : () async {
                                                  //   context.router.replaceAll([const NavigationRoute()]);
                                                  final allowedChange =
                                                      isAllowedToContinue(
                                                          state);
                                                  if (!allowedChange) {
                                                    Toast.of(context).show(
                                                        success: false,
                                                        message:
                                                            'flightCharge.twoDayChangeError'
                                                                .tr());
                                                    return;
                                                  }
                                                  bool? check =
                                                      await showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
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
                            ),
                            kVerticalSpacer,
                            if (bloc?.state.showingVoucher == true)
                              ...[]
                            else ...[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: PassengerSelectorManageBooking(
                                  passengersWithSSR: bloc
                                          ?.state
                                          .manageBookingResponse
                                          ?.result
                                          ?.passengersWithSSRWithoutInfant ??
                                      [],
                                ),
                              ),
                              kVerticalSpacer,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: SelectedPassengerInfo(selectedPax),
                              ),
                              kVerticalSpacerSmall,
                              if (showSsr == true) ...[
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: AddOnOptions(),
                                ),
                                kVerticalSpacer,
                                if (bloc?.state.addOnOptionSelected ==
                                    AddonType.seat) ...[
                                  kVerticalSpacerMini,
                                  true ? Container() : kVerticalSpacerSmall,
                                  if (bloc?.state.manageBookingResponse?.result
                                          ?.isReturn ==
                                      true) ...[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: CustomSegmentControl(
                                        optionOneTapped: () {
                                          bloc?.setSelectionDeparture(true,
                                              isSeat: true);
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
                                        customSelectedStyle:
                                            kMediumSemiBold.copyWith(
                                                color: Styles.kPrimaryColor),
                                        customNoSelectedStyle:
                                            kMediumSemiBold.copyWith(
                                                color: Styles.kLightBgColor),
                                      ),
                                    ),
                                    kVerticalSpacer,
                                  ],
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: SeatLegendSimple(),
                                  ),
                                  kVerticalSpacer,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: PassengerViewerForSeats(
                                      passengersWithSSR: bloc
                                              ?.state
                                              .manageBookingResponse
                                              ?.result
                                              ?.passengersWithSSRWithoutInfant ??
                                          [],
                                    ),
                                  ),
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
                                  true
                                      ? Container()
                                      : WarningLabel(
                                          message:
                                              'mealAddOnsAreUnavailable'.tr(),
                                        ),
                                  kVerticalSpacerSmall,
                                  if (bloc?.state.manageBookingResponse?.result
                                          ?.isReturn ==
                                      true) ...[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: CustomSegmentControl(
                                        optionOneTapped: () {
                                          bloc?.setSelectionDeparture(true,
                                              isFood: true);
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
                                        customSelectedStyle:
                                            kMediumSemiBold.copyWith(
                                                color: Styles.kPrimaryColor),
                                        customNoSelectedStyle:
                                            kMediumSemiBold.copyWith(
                                                color: Styles.kLightBgColor),
                                      ),
                                    ),
                                    kVerticalSpacerSmall,
                                  ],
                                  MealsSection(
                                    isDeparture:
                                        bloc?.state.foodDepearture ?? false,
                                    isManageBooking: true,
                                  ),
                                ] else if (bloc?.state.addOnOptionSelected ==
                                    AddonType.baggage) ...[
                                  kVerticalSpacerSmall,
                                  if (bloc?.state.manageBookingResponse?.result
                                          ?.isReturn ==
                                      true) ...[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: CustomSegmentControl(
                                        optionOneTapped: () {
                                          bloc?.setSelectionDeparture(true,
                                              isBaggage: true);
                                        },
                                        optionTwoTapped: () {
                                          bloc?.setSelectionDeparture(false,
                                              isBaggage: true);
                                        },
                                        isSelectedOption1:
                                            bloc?.state.baggageDeparture ??
                                                true,
                                        textOne:
                                            '${'departFlight'.tr()}\n(${bloc?.state.manageBookingResponse?.result?.departureToDestinationCodeDash ?? ''})',
                                        textTwo:
                                            '${'returningFlight'.tr()}\n(${bloc?.state.manageBookingResponse?.result?.returnToDestinationCodeDash ?? ''})',
                                        customRadius: 12,
                                        customBorderWidth: 1,
                                        customVerticalPadding: 8,
                                        customSelectedStyle:
                                            kMediumSemiBold.copyWith(
                                                color: Styles.kPrimaryColor),
                                        customNoSelectedStyle:
                                            kMediumSemiBold.copyWith(
                                                color: Styles.kLightBgColor),
                                      ),
                                    ),
                                    kVerticalSpacerSmall,
                                  ],
                                  BaggageSection(
                                    horiz1: horizKey1,
                                    horiz2: horizKey2,
                                    horizS1: horizKeyS1,
                                    horizS2: horizKeyS2,
                                    isManageBooking: true,
                                    isDeparture:
                                        bloc?.state.baggageDeparture ?? false,
                                    moveToTop: () {},
                                    moveToBottom: () {},
                                  ),
                                ] else if (bloc?.state.addOnOptionSelected ==
                                    AddonType.special) ...[
                                  kVerticalSpacer,
                                  if (bloc?.state.manageBookingResponse?.result
                                          ?.isReturn ==
                                      true) ...[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: CustomSegmentControl(
                                        optionOneTapped: () {
                                          bloc?.setSelectionDeparture(true,
                                              isSpecial: true);
                                        },
                                        optionTwoTapped: () {
                                          bloc?.setSelectionDeparture(false,
                                              isSpecial: true);
                                        },
                                        isSelectedOption1: bloc?.state
                                                .specialAppOpsDeparture ??
                                            true,
                                        textOne:
                                            '${'departFlight'.tr()}\n(${bloc?.state.manageBookingResponse?.result?.departureToDestinationCodeDash ?? ''})',
                                        textTwo:
                                            '${'returningFlight'.tr()}\n(${bloc?.state.manageBookingResponse?.result?.returnToDestinationCodeDash ?? ''})',
                                        customRadius: 12,
                                        customBorderWidth: 1,
                                        customVerticalPadding: 8,
                                        customSelectedStyle:
                                            kMediumSemiBold.copyWith(
                                                color: Styles.kPrimaryColor),
                                        customNoSelectedStyle:
                                            kMediumSemiBold.copyWith(
                                                color: Styles.kLightBgColor),
                                      ),
                                    ),
                                    kVerticalSpacerSmall,
                                  ],
                                  if (bloc?.state.specialAppOpsDeparture ==
                                      true) ...[
                                    WheelchairSection(
                                        key: horizKeyW1,
                                        isDeparture: bloc?.state
                                                .specialAppOpsDeparture ??
                                            false,
                                        isManageBooking: true),
                                  ] else ...[
                                    WheelchairSection(
                                        key: horizKeyW2,
                                        isDeparture: bloc?.state
                                                .specialAppOpsDeparture ??
                                            false,
                                        isManageBooking: true),
                                  ],
                                  kVerticalSpacer,
                                ] else if (bloc?.state.addOnOptionSelected ==
                                    AddonType.insurance) ...[
                                  //InsuranceView(isManageBooking: true,),
                                  const InsuranceManageView(),
                                ] else
                                  ...[],
                              ],
                            ],
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: ManageFlightSummary(),
                            ),
                            if (bloc?.state.showingVoucher == true) ...[
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: VoucherCodeUi(
                                  onOnlyTextRemove: () {
                                    _fbKey.currentState!.reset();
                                    voucherBloc.dontShowVoucher();
                                  },
                                  readOnly: false,
                                  blocState: voucherState.blocState,
                                  voucherCodeInitial:
                                      voucherState.dontShowVoucher == true
                                          ? ''
                                          : (voucherState.insertedVoucher
                                                  ?.voucherCode ??
                                              ''),
                                  state: voucherState,
                                  onRemoveTapped: () {
                                    if (voucherState.response != null) {
                                      removeVoucher(
                                          bloc?.currentToken ?? '', context);
                                    } else {
                                      _fbKey.currentState!.reset();
                                    }
                                  },
                                  onButtonTapped: voucherState.blocState ==
                                          BlocState.loading
                                      // || bookingState.superPnrNo != null
                                      ? null
                                      : (voucherState.response != null)
                                          ? () => removeVoucher(
                                              bloc?.currentToken ?? '', context)
                                          : () {
                                              if (_fbKey.currentState!
                                                  .saveAndValidate()) {
                                                if (ConstantUtils
                                                    .showPinInVoucher) {
                                                  final value = _fbKey
                                                      .currentState!.value;
                                                  final voucher =
                                                      value["voucherCode"];
                                                  final voucherPin =
                                                      InsertVoucherPIN(
                                                    voucherCode: voucher,
                                                  );
                                                  bloc?.state.changeSsrResponse
                                                          ?.token ??
                                                      '';

                                                  final token = bloc
                                                          ?.state
                                                          .changeSsrResponse
                                                          ?.token ??
                                                      '';
                                                  final voucherRequest =
                                                      VoucherRequest(
                                                    voucherPins: [voucherPin],
                                                    token: token,
                                                  );
                                                  context
                                                      .read<VoucherCubit>()
                                                      .addVoucher(
                                                          voucherRequest);
                                                } else {
                                                  final value = _fbKey
                                                      .currentState!.value;
                                                  final voucher =
                                                      value["voucherCode"];
                                                  final token =
                                                      bloc?.currentToken ?? '';
                                                  final voucherRequest =
                                                      VoucherRequest(
                                                    insertVoucher: voucher,
                                                    token: token,
                                                  );
                                                  context
                                                      .read<VoucherCubit>()
                                                      .addVoucher(
                                                          voucherRequest);
                                                }
                                              }
                                            },
                                  fbKey: _fbKey,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ] else if (showPax == true) ...[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: ContactsSection(
                                  fbKey: fbKey2,
                                ),
                              ),
                              kVerticalSpacer,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: EmergencyContactsSection(
                                  fbKey: fbKey,
                                ),
                              ),
                              kVerticalSpacer,
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: ComapnyTaxInvoiceSection(),
                              ),
                              kVerticalSpacer,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: PaymentDetailsSecond(),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    if (bloc?.state.showingVoucher == true) ...[
                      if (bloc
                              ?.state
                              .changeSsrResponse
                              ?.assignFlightAddOnResponse
                              ?.totalReservationAmount !=
                          null) ...[
                        DiscountSummary(
                            princToShow: (bloc
                                        ?.state
                                        .changeSsrResponse
                                        ?.assignFlightAddOnResponse
                                        ?.totalReservationAmount ??
                                    0)
                                .toDouble()),
                      ],
                      SummaryContainer(
                        child: bloc?.state.isPaying == true
                            ? const AppLoading()
                            : Padding(
                                padding: kPagePadding,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "flightResult.totalAmountDue".tr(),
                                      style: kMediumRegular.copyWith(
                                          color: Styles.kSubTextColor),
                                    ),
                                    MoneyWidget(
                                      isDense: false,
                                      currency: bloc
                                              ?.state
                                              .manageBookingResponse
                                              ?.result
                                              ?.passengersWithSSR
                                              ?.first
                                              .fareAndBundleDetail
                                              ?.currencyToShow ??
                                          'MYR',
                                      amount: (bloc
                                                  ?.state
                                                  .changeSsrResponse
                                                  ?.assignFlightAddOnResponse
                                                  ?.totalReservationAmount ??
                                              0.0) -
                                          discount,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        BuildContext? cyrreContext =
                                            Scaffold.maybeOf(context)?.context;

                                        ChangeSsrResponse? response =
                                            await bloc?.state.changeSsrResponse;

                                        if (response != null) {
                                          var redirectUrl =
                                              await bloc?.checkOutForPaymentSSR(
                                                  '', response);

                                          if (redirectUrl != null) {
                                            final result =
                                                await cyrreContext?.router.push(
                                              WebViewRoute(
                                                  url: "",
                                                  htmlContent: redirectUrl),
                                            );

                                            if (result != null &&
                                                result is String) {
                                              final urlParsed =
                                                  Uri.parse(result);
                                              var query =
                                                  urlParsed.queryParametersAll;
                                              String? status =
                                                  query['status']?.first;
                                              String? superPNR =
                                                  query['pnr']?.first;

                                              if (status != "FAIL") {
                                                await showDialog(
                                                  context: cyrreContext!,
                                                  builder:
                                                      (BuildContext context) {
                                                    return PaymentSuccessAlert(
                                                      currency: response
                                                              .assignFlightAddOnResponse
                                                              ?.currency ??
                                                          '',
                                                      amount: response
                                                              .assignFlightAddOnResponse
                                                              ?.totalReservationAmount
                                                              ?.toStringAsFixed(
                                                                  2) ??
                                                          '0.00',
                                                    );
                                                  },
                                                );

                                                await bloc
                                                    ?.getBookingInformation(
                                                        state.lastName ?? '',
                                                        state.pnrEntered ?? '');

                                                reloadView();

                                                //// cyrreContext
                                                // .read<VoucherCubit>()
                                                // .resetState();
                                              } else {}
                                            } else {}
                                          }
                                        }

                                        return;
                                      },
                                      child: Text('pay'.tr()),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ] else if (bloc?.pendingPayOption == true) ...[
                      if (bloc?.state.isPaying == true && 1 == 2) ...[
                        const Center(
                          child: AppLoading(),
                        ),
                      ] else ...[
                        SummaryContainer(
                          child: bloc?.state.isPaying == true
                              ? const AppLoading()
                              : Padding(
                                  padding: kPagePadding,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "flightResult.totalAmountDue".tr(),
                                            style: kMediumRegular.copyWith(
                                                color: Styles.kSubTextColor),
                                          ),
                                          MoneyWidget(
                                            isDense: false,
                                            currency: bloc
                                                    ?.state
                                                    .manageBookingResponse
                                                    ?.result
                                                    ?.passengersWithSSR
                                                    ?.first
                                                    .fareAndBundleDetail
                                                    ?.currencyToShow ??
                                                'MYR',
                                            amount:
                                                bloc?.pendingAmountToPay ?? 0.0,
                                          ),
                                          kVerticalSpacerSmall,
                                        ],
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          BuildContext? cyrreContext =
                                              Scaffold.maybeOf(context)
                                                  ?.context;

                                          var redirectUrl =
                                              await bloc?.checkOutPending();

                                          if (bloc?.state.hasPendingError ==
                                              true) {
                                            showErrorDialog(
                                                context, redirectUrl ?? '');

                                            return;
                                          }
                                          //

                                          if (redirectUrl != null) {
                                            final result =
                                                await cyrreContext?.router.push(
                                              WebViewRoute(
                                                  url: "",
                                                  htmlContent: redirectUrl),
                                            );

                                            if (result != null &&
                                                result is String) {
                                              final urlParsed =
                                                  Uri.parse(result);
                                              var query =
                                                  urlParsed.queryParametersAll;
                                              String? status =
                                                  query['status']?.first;
                                              String? superPNR =
                                                  query['pnr']?.first;

                                              if (status != "FAIL") {
                                                await showDialog(
                                                  context: cyrreContext!,
                                                  builder:
                                                      (BuildContext context) {
                                                    return PaymentSuccessAlert(
                                                      currency: bloc
                                                              ?.state
                                                              .manageBookingResponse
                                                              ?.result
                                                              ?.passengersWithSSR
                                                              ?.first
                                                              .fareAndBundleDetail
                                                              ?.currencyToShow ??
                                                          'MYR',
                                                      amount:
                                                          '${bloc?.pendingAmountToPay ?? 0.0}',
                                                    );
                                                  },
                                                );

                                                await bloc
                                                    ?.getBookingInformation(
                                                        state.lastName ?? '',
                                                        state.pnrEntered ?? '');

                                                reloadView();

                                                //// cyrreContext
                                                // .read<VoucherCubit>()
                                                // .resetState();
                                              } else {}
                                            } else {}
                                          }
                                        },
                                        child: Text(
                                          'pay'.tr(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ] else if (bloc?.showPayOption == true) ...[
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

                                        /*
                                        var cc  = state.manageBookingResponse?.result?.superPNRNo;

                                        context.router.replaceAll([
                                          const NavigationRoute(),
                                          BookingConfirmationRoute(
                                              bookingId: 'FBK8H2D' ?? "",
                                              status: 'RHI' ?? '',
                                              isMmb: true,

                                              summary:
                                              const ManageFlightSummary(),

                                          )
                                        ]);

                                        return;*/



                                        BuildContext? cyrreContext =
                                            Scaffold.maybeOf(context)?.context;

                                        ChangeSsrResponse? response =
                                            await bloc?.checkSsrChange();

                                        if (response != null) {
                                          var redirectUrl =
                                              await bloc?.checkOutForPaymentSSR(
                                                  '', response);

                                          if (redirectUrl != null) {
                                            final result =
                                                await cyrreContext?.router.push(
                                              WebViewRoute(
                                                  url: "",
                                                  htmlContent: redirectUrl),
                                            );

                                            if (result != null &&
                                                result is String) {
                                              final urlParsed =
                                                  Uri.parse(result);
                                              var query =
                                                  urlParsed.queryParametersAll;
                                              String? status =
                                                  query['status']?.first;
                                              String? superPNR =
                                                  query['pnr']?.first;

                                              if (status == "CON") {
                                                await showDialog(
                                                  context: cyrreContext!,
                                                  builder:
                                                      (BuildContext context) {
                                                    return PaymentSuccessAlert(
                                                      currency: response
                                                              .assignFlightAddOnResponse
                                                              ?.currency ??
                                                          '',
                                                      amount: response
                                                              .assignFlightAddOnResponse
                                                              ?.totalReservationAmount
                                                              ?.toStringAsFixed(
                                                                  2) ??
                                                          '0.00',
                                                    );
                                                  },
                                                );

                                                await bloc
                                                    ?.getBookingInformation(
                                                        state.lastName ?? '',
                                                        state.pnrEntered ?? '');

                                                reloadView();

                                                //// cyrreContext
                                                // .read<VoucherCubit>()
                                                // .resetState();
                                              } else if (status == 'FAIL') {
                                                Toast.of(context).show(message: 'paymentFailed'.tr());

                                              } else {
                                                context.router.replaceAll([
                                                  const NavigationRoute(),
                                                  BookingConfirmationRoute(
                                                      bookingId: superPNR ?? "",
                                                      status: status ?? '',
                                                      isMmb: true,
                                                      summary:
                                                          const ManageFlightSummary())
                                                ]);
                                              }
                                            } else {}
                                          }
                                        }
                                      },
                                      child: Text(
                                        'pay'.tr(),
                                      ),
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
                                        if (bloc
                                                ?.state
                                                .manageBookingResponse
                                                ?.result
                                                ?.initalEmergencyEmpty ==
                                            true) {
                                          bool checkError = false;

                                          if (fbKey2.currentState?.validate() ==
                                              false) {
                                            checkError = true;
                                            //  bloc?.setEmergenctyError(true, true);

                                            // return;
                                          }

                                          bloc?.setEmergenctyError(
                                              false, checkError);

                                          if (checkError == false) {
                                            bloc?.saveContactChanges();
                                          }
                                        } else {
                                          //fbKey.currentState?.validate() ==
                                          //                                               false &&

                                          bool checkError = false,
                                              checkErrorE = false;

                                          if (fbKey2.currentState?.validate() ==
                                              false) {
                                            checkError = true;
                                            //  bloc?.setEmergenctyError(true, true);

                                            // return;
                                          }

                                          if (fbKey.currentState?.validate() ==
                                              false) {
                                            checkErrorE = true;
                                            //  bloc?.setEmergenctyError(true, true);

                                            //return;
                                          }

                                          bloc?.setEmergenctyError(
                                              checkErrorE, checkError);

                                          if (checkError == false &&
                                              checkErrorE == false) {
                                            bloc?.saveContactChanges();
                                          }
                                        }
                                        return;
                                      },
                                      child: Text(
                                        'accountDetail.save'.tr(),
                                      ),
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

  void removeVoucher(String currentToken, BuildContext context) {
    context.read<VoucherCubit>;

    final token = currentToken;
    final voucherRequest = VoucherRequest(
      token: token,
    );
    context.read<VoucherCubit>().removeVoucher(voucherRequest);
    if (context.read<VoucherCubit>().state.dontShowVoucher == true) {
    } else {
      _fbKey.currentState!.reset();
    }
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

    Bundle? lastInsuranceSelected;
    InsuranceType? selected = state.insuranceType;

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

    bool dontShowAll = bloc.dontShowAllInsuranceOption;

    var insuranceValuesToShow = InsuranceType.values
        .where((element) => element != InsuranceType.none)
        .toList();

    if (dontShowAll == true) {
      insuranceValuesToShow = insuranceValuesToShow
          .where((element) => element != InsuranceType.all)
          .toList();

      print('');
    }

    if (bloc.state.selectedPax?.insuranceSSRDetail != null) {
      if ((bloc.state.selectedPax?.insuranceSSRDetail?.totalAmount ?? 0.0) >
          0.0) {
        insuranceValuesToShow = [];
        insurances = [];
      }
    }

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: insuranceValuesToShow
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          print('');

                          var options =
                              bloc.state.flightSSR?.insuranceGroup?.outbound;

                          if ((options ?? []).isNotEmpty) {
                            var firstInsurance = (options ?? []).first;
                          }

                          bloc.selectInsuranceType(e);

                          print('');

                          /*


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
                                    child: AvailableInsurance.getAssets(e) ==
                                            null
                                        ? const SizedBox()
                                        : Image.asset(
                                            AvailableInsurance.getAssets(e)!),
                                  ),
                                ],
                              ),
                              Visibility(
                                visible:
                                    e == selected && e != InsuranceType.none,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Column(
                                    children: [
                                      Visibility(
                                        visible: e == InsuranceType.selected,
                                        child: Row(
                                          children: [
                                            Text(
                                              'passenger'.tr(),
                                              style: kLargeHeavy,
                                            ),
                                            kHorizontalSpacerSmall,
                                            Text(
                                              state.selectedPax?.passengers
                                                      ?.fullName ??
                                                  '',
                                              style: kLargeHeavy,
                                            ),
                                          ],
                                        ),
                                      ),
                                      ...insurances.map(
                                        (Bundle e) {
                                          final bound =
                                              e.toBound(isInsurance: true);

                                          var tmp = bound;

                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: InkWell(
                                              onTap: () {
                                                if (selected ==
                                                    InsuranceType.all) {
                                                  bloc.addInsuranceToAllPeople(
                                                      e, tmp);
                                                } else if (selected ==
                                                    InsuranceType.selected) {
                                                  bloc.addInsuranceToPeople(e,
                                                      tmp, state.selectedPax);
                                                } else {
                                                  bloc.addInsuranceToPeople(e,
                                                      tmp, state.selectedPax);
                                                }
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
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                        color: Styles
                                                            .kDisabledButton)),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      AvailableInsurance
                                                          .dataTitle(
                                                              e, agentCms),
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                    kVerticalSpacer,
                                                    IgnorePointer(
                                                      ignoring: true,
                                                      child: Radio<bool>(
                                                        value: true,
                                                        visualDensity:
                                                            const VisualDensity(
                                                          horizontal: -2,
                                                          vertical: -2,
                                                        ),
                                                        materialTapTargetSize:
                                                            MaterialTapTargetSize
                                                                .shrinkWrap,
                                                        groupValue: selected ==
                                                                InsuranceType
                                                                    .all
                                                            ? ((bloc
                                                                        .state
                                                                        .manageBookingResponse
                                                                        ?.allInsuranceSelected ??
                                                                    false) &&
                                                                (e.codeType ==
                                                                    state
                                                                        .manageBookingResponse
                                                                        ?.allInsuranceBundleSelected
                                                                        ?.codeType))
                                                            : ((state
                                                                        .selectedPax
                                                                        ?.newInsuranceBundleSelected
                                                                        ?.codeType ??
                                                                    '') ==
                                                                e.codeType),
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
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(),
          ),
          kVerticalSpacerSmall,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Text(
                  'insuranceTotal'.tr(),
                  style: k18SemiBold.copyWith(color: Styles.kTextColor),
                ),
                Expanded(
                  child: Container(),
                ),
                MoneyWidget(
                  amount: bloc.notConfirmedInsruanceTotalPrice ?? 0.0,
                  isDense: true,
                  isNormalMYR: true,
                ),
              ],
            ),
          ),
          kVerticalSpacerSmall,
          Row(
            children: [
              Expanded(
                child: Container(),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: bloc.hasAnySeatChanged == false
                      ? null
                      : () {
                          bloc.insuranceConfirmChange();

                          bloc.changeSelectedAddOnOption(AddonType.none,
                              toNull: true);
                        },
                  child: Text('selectDateView.confirm'.tr()),
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
          kVerticalSpacer,
        ] else ...[
          EmptyAddon(
            icon: "assets/images/icons/icoNoInsurance.png",
            customText: 'insuranceNotUnavailable'.tr(),
            verticalSpace: 20,
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

    var ccc = bloc.noOfNewMeals;

    var totalPrice = bloc.confirmedSeatsTotalPrice +
        bloc.confirmedMealsTotalPrice +
        bloc.confirmedBaggageTotalPrice +
        bloc.confirmedSportsTotalPrice +
        bloc.confirmedWheelChairTotalPrice +
        bloc.confirmedInsruanceTotalPrice;

    return (totalPrice == 0 && bloc.isThereNewWheelChaie == false && ccc == 0)
        ? Container()
        : AppCard(
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
                if (bloc.state.manageBookingResponse?.result?.isReturn ==
                    true) ...[
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
                BaggageSummaryDetail(
                  currency: currency,
                  sports: true,
                  isManageBooking: true,
                ),
                SpecialSummaryDetail(
                  currency: currency,
                  isManageBooking: true,
                ),
                if (bloc.state.insuranceType == InsuranceType.all ||
                    bloc.state.insuranceType == InsuranceType.selected) ...[
                  if (bloc.confirmedInsruanceTotalPrice > 0) ...[
                    InsurancesSummaryDetail(
                      isManageBooking: true,
                    ),
                  ],
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            RedCircle(
                              circleColor: Styles.kPrimaryColor,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              'flightCharge.changes'.tr(),
                              style: kSmallRegular.copyWith(
                                color: Styles.kTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            RedCircle(
                              circleColor: Styles.kTextColor,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              'flightCharge.existingAddons'.tr(),
                              style: kSmallRegular.copyWith(
                                color: Styles.kTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}

class InsurancesSummaryDetail extends StatelessWidget {
  final bool isManageBooking;

  InsurancesSummaryDetail({
    Key? key,
    this.currency,
    required this.isManageBooking,
  }) : super(key: key);
  final String? currency;

  ManageBookingCubit? manageBookingCubit;

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    var numberOfPerson = filter?.numberPerson;
    var persons = List<Person>.from(numberOfPerson?.persons ?? []);
    num totalPrice = 0;

    manageBookingCubit = context.watch<ManageBookingCubit>();
    totalPrice = manageBookingCubit?.confirmedInsruanceTotalPrice ?? 0.0;
    persons = context
            .watch<ManageBookingCubit>()
            .state
            .manageBookingResponse
            ?.result
            ?.allPersonObject ??
        [];
    numberOfPerson = NumberPerson(persons: persons);

    var perPersonAmount = manageBookingCubit
            ?.state.flightSSR?.insuranceGroup?.outbound?.first.finalAmount ??
        0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChildRow(
          child1: Text(
            "insurance".tr(),
            style: kLargeHeavy,
          ),
          child2: MoneyWidgetCustom(
            currency: currency,
            amountSize: 16,
            myrSize: 16,
            amount: totalPrice,
            textColor: Styles.kPrimaryColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (manageBookingCubit?.state.confirmedInsuranceType ==
            InsuranceType.all) ...[
          kVerticalSpacerMini,
          for (PassengersWithSSR currentPerson in manageBookingCubit
                  ?.state.manageBookingResponse?.result?.passengersWithSSR ??
              []) ...[
            ChildRow(
              child1: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentPerson.passengers?.fullName ?? '',
                  ),
                  SummaryListItem(
                    text: manageBookingCubit?.state.manageBookingResponse
                            ?.confirmedInsuranceBoundSelected?.name ??
                        '',
                    isManageBooking: isManageBooking,
                  )
                ],
              ),
              child2: MoneyWidgetCustom(
                currency: currency,
                amount: perPersonAmount,
              ),
            )
          ],
        ] else if (manageBookingCubit?.state.confirmedInsuranceType ==
            InsuranceType.selected) ...[
          kVerticalSpacerMini,
          for (PassengersWithSSR currentPerson in manageBookingCubit
                  ?.state.manageBookingResponse?.result?.passengersWithSSR ??
              []) ...[
            if (currentPerson.confirmedInsuranceBundleSelected != null) ...[
              ChildRow(
                child1: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentPerson.passengers?.fullName ?? '',
                    ),
                    SummaryListItem(
                      text:
                          currentPerson.confirmedInsuranceBoundSelected?.name ??
                              '',
                      isManageBooking: isManageBooking,
                    )
                  ],
                ),
                child2: MoneyWidgetCustom(
                  currency: currency,
                  amount:
                      currentPerson.confirmedInsuranceBoundSelected?.price ??
                          0.0,
                ),
              )
            ],
          ],
        ],
      ],
    );
  }

  Widget allInsurance() {
    return Container();
  }

  Widget buildBaggageComponent(
      Person e, NumberPerson? numberOfPerson, bool isDeparture) {
    final baggage = isDeparture ? e.departureBaggage : e.returnBaggage;
    final sport = isDeparture ? e.departureSports : e.returnSports;

    num amountToMinus = 0.0;
    final seats = e.departureSeats;

    var ccc = manageBookingCubit
        ?.state.manageBookingResponse?.result?.passengersWithSSR
        ?.where((element) => element.personObject == e)
        .toList();

    if ((ccc ?? []).isNotEmpty) {
      if (isDeparture == true) {
        if ((ccc ?? []).first.confirmDepartBaggageSelected == null) {
          return Container();
        }
      } else {
        if ((ccc ?? []).first.confirmReturnBaggageSelected == null) {
          return Container();
        }
      }
      if ((ccc ?? []).first.confirmDepartBaggageSelected == null) {
        //return Container();
      } else {
        /*
          var tmpSeat = manageBookingCubit
              ?.state.manageBookingResponse?.result?.seatDetail?.seats
              ?.where((element) =>
          element.givenName ==
              ccc?.first.passengers?.givenName &&

              element.surName ==
                  ccc?.first.passengers?.surname &&
              element.departReturn == 'Depart'
          ).toList();

          if((tmpSeat ?? []).isNotEmpty) {
            amountToMinus = (tmpSeat ?? []).first.amount ?? 0.0;
          }
*/

        print('object');
        // ccc.first.seat
      }
    }

    return ChildRow(
      child1: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            e.generateText(numberOfPerson, separator: "& "),
          ),
          Visibility(
            visible: sport != null,
            child: SummaryListItem(
              text: sport?.description ?? '',
              isManageBooking: isManageBooking,
            ),
          ),
        ],
      ),
      child2: MoneyWidgetCustom(
        currency: currency,
        amount: e.getPartialPriceSports(isDeparture),
      ),
    );
  }
}
