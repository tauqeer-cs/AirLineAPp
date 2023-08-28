import 'package:app/utils/utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../app/app_bloc_helper.dart';
import '../../../app/app_flavor.dart';
import '../../../app/app_router.dart';
import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../blocs/voucher/voucher_cubit.dart';
import '../../../data/requests/voucher_request.dart';
import '../../../data/responses/change_flight_response.dart';
import '../../../models/confirmation_model.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../utils/constant_utils.dart';
import '../../../utils/date_utils.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_loading_screen.dart';
import '../../booking_details/ui/flight_data.dart';
import '../../checkout/pages/payment/ui/discount_summary.dart';
import '../../checkout/pages/payment/ui/redeem_voucher.dart';
import '../../checkout/pages/payment/ui/voucher_ui.dart';
import '../../search_result/ui/booking_summary.dart';
import '../../search_result/ui/summary_container_listener.dart';
import '../../select_change_flight/ui/booking_refrence_label.dart';
import 'package:collection/collection.dart';

class ChangeFlightSummaryView extends StatefulWidget {
  const ChangeFlightSummaryView({Key? key}) : super(key: key);

  @override
  State<ChangeFlightSummaryView> createState() =>
      _ChangeFlightSummaryViewState();
}

class _ChangeFlightSummaryViewState extends State<ChangeFlightSummaryView> {
  ManageBookingCubit? bloc;

  bool conditionsCheckOne = false;
  bool conditionsCheckTwo = false;
  bool conditionsCheckThree = false;

  final _fbKey = GlobalKey<FormBuilderState>();

  void removeVoucher(String currentToken, BuildContext context) {
    _fbKey.currentState!.reset();
    final token = currentToken;
    final voucherRequest = VoucherRequest(
      token: token,
    );
    context.read<VoucherCubit>().removeVoucher(voucherRequest);
  }

  @override
  void initState() {
    super.initState();
  }

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

  final scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  bool isScrollable = false;

  void afterBuild() {
    if (scrollController.hasClients) {
      setState(() {
        isScrollable = scrollController.position.extentAfter > 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.toString();

    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild());

    bloc = context.watch<ManageBookingCubit>();

    var state = bloc?.state;
    var voucherBloc = context.watch<VoucherCubit>();
    var voucherState = voucherBloc.state;

    var discount = voucherState.response?.addVoucherResult?.voucherDiscounts
            ?.firstOrNull?.discountAmount ??
        0.0;
    if (bloc?.state.rewardItem != null) {
      discount = discount + (bloc?.state.rewardItem?.redemptionAmount ?? 0.0);
    }

    var departureDate = state?.changeFlightResponse?.result
        ?.flightVerifyResponse?.result?.flightSegments?.last.departureDate;

    var returnDate = state?.changeFlightResponse?.result?.flightVerifyResponse
        ?.result?.flightSegments?.first.departureDate;

    ChangeFlightRequestResponse? changeFlightRequestResponse =
        state?.changeFlightResponse;

    var flightSectionGoing = state?.changeFlightResponse?.result
        ?.flightVerifyResponse?.result?.flightSegments?.first;
    var flightSectionBack = state?.changeFlightResponse?.result
        ?.flightVerifyResponse?.result?.flightSegments?.last;

    //flightSectionBack.flightLegDetails;

    if (flightSectionGoing != null && flightSectionBack != null) {
      if (flightSectionBack.departureDateObject
          .isBefore(flightSectionGoing.departureDateObject)) {
        flightSectionGoing = state?.changeFlightResponse?.result
            ?.flightVerifyResponse?.result?.flightSegments?.last;
        flightSectionBack = state?.changeFlightResponse?.result
            ?.flightVerifyResponse?.result?.flightSegments?.first;
      } else {
        departureDate = state?.changeFlightResponse?.result
            ?.flightVerifyResponse?.result?.flightSegments?.first.departureDate;

        returnDate = state?.changeFlightResponse?.result?.flightVerifyResponse
            ?.result?.flightSegments?.last.departureDate;
      }
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

    String currency = bloc?.state.manageBookingResponse?.result
            ?.fareAndBundleDetail?.currencyToShow ??
        'MYR';

    return Stack(
      children: [
        SummaryContainerListener(
          scrollController: scrollController,
          child: Padding(
            padding: kPageHorizontalPadding,
            child: ListView(
              controller: scrollController,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    BookingReferenceLabel(
                      refText: bloc?.state.pnrEntered,
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          //kDisabledButton
                          color: Styles.kDisabledButton,
                          width: 1,
                        ),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (bloc?.state.checkedDeparture == true &&
                                  bloc?.state.checkReturn == true) ...[
                                Text(
                                  '${AppDateUtils.formatFullDate(DateTime.parse(departureDate ?? ''), locale: locale)} -',
                                  style: kSmallRegular.copyWith(
                                    color: Styles.kTextColor,
                                    height: 1.5,
                                  ),
                                ),
                                Text(
                                  AppDateUtils.formatFullDate(
                                      DateTime.parse(
                                        returnDate ?? '',
                                      ),
                                      locale: locale),
                                  style: kSmallRegular.copyWith(
                                    color: Styles.kTextColor,
                                    height: 1.5,
                                  ),
                                ),
                              ] else ...[
                                Text(
                                  AppDateUtils.formatFullDate(
                                      DateTime.parse(departureDate ?? ''),
                                      locale: locale),
                                  style: kSmallRegular.copyWith(
                                    color: Styles.kTextColor,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.calendar_month,
                            color: Styles.kPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                AppCard(
                  edgeInsets: EdgeInsets.zero,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: double.infinity,
                          height: 4,
                        ),
                        if ((bloc?.state.checkedDeparture == true)) ...[
                          FlightDataInfo(
                            headingLabel: 'departure'.tr(),
                            dateToShow: flightSectionGoing
                                    ?.departureDateToShow(locale) ??
                                '',
                            departureToDestinationCode: state
                                    ?.manageBookingResponse
                                    ?.result
                                    ?.departureToDestinationCode ??
                                '',
                            departureDateWithTime: flightSectionGoing
                                    ?.departureDateToTwoLine(locale) ??
                                '',
                            departureAirportName: state?.manageBookingResponse
                                    ?.result?.departureAirportName ??
                                '',
                            journeyTimeInHourMin: state?.manageBookingResponse
                                    ?.result?.journeyTimeInHourMin ??
                                '',
                            arrivalDateWithTime: flightSectionGoing
                                    ?.arrivalDateToTwoLine(locale) ??
                                '',
                            arrivalAirportName: state?.manageBookingResponse
                                    ?.result?.arrivalAirportName ??
                                '',
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Divider(),
                          ),
                        ],
                        if ((bloc?.state.manageBookingResponse?.isTwoWay ??
                                false) &&
                            (bloc?.state.checkReturn == true)) ...[
                          FlightDataInfo(
                            headingLabel: 'return'.tr(),
                            dateToShow: flightSectionBack
                                    ?.departureDateToShow(locale) ??
                                '',
                            departureToDestinationCode: state
                                    ?.manageBookingResponse
                                    ?.result
                                    ?.returnToDestinationCode ??
                                '',
                            departureDateWithTime: flightSectionBack
                                    ?.departureDateToTwoLine(locale) ??
                                '',
                            departureAirportName: state?.manageBookingResponse
                                    ?.result?.returnDepartureAirportName ??
                                '',
                            journeyTimeInHourMin: state?.manageBookingResponse
                                    ?.result?.returnJourneyTimeInHourMin ??
                                '',
                            arrivalDateWithTime: flightSectionBack
                                    ?.arrivalDateToTwoLine(locale) ??
                                '',
                            arrivalAirportName: state?.manageBookingResponse
                                    ?.result?.returnArrivalAirportName ??
                                '',
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                AppCard(
                  edgeInsets: EdgeInsets.zero,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            Text(
                              'summary'.tr(),
                              style: kLargeHeavy,
                            ),
                            const Spacer(),
                            Text(
                              changeFlightRequestResponse
                                      ?.result
                                      ?.changeFlightResponse
                                      ?.totalReservationAmountString ??
                                  '',
                              style: kLargeHeavy.copyWith(
                                color: Styles.kPrimaryColor,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        for (PassengersWithSSRFareBreakDown currentPerson
                            in changeFlightRequestResponse
                                    ?.result
                                    ?.changeFlightResponse
                                    ?.passengersWithSSRFareBreakDown ??
                                []) ...[
                          PersonHeader(
                              currentPerson: currentPerson, bloc: bloc),
                          kVerticalSpacerMini,
                          PersonDeparture(
                            changeFlightRequestResponse:
                                changeFlightRequestResponse!,
                            currentPerson: currentPerson,
                            bloc: bloc!,
                            local: locale,
                          ),
                          kVerticalSpacerSmall,
                        ],
                        kVerticalSpacerSmall,
                        Row(
                          children: [
                            Text(
                              'flightChange.fee'.tr(),
                              style: kMediumHeavy,
                            ),
                            const Spacer(),
                            Text(
                              changeFlightRequestResponse
                                      ?.result
                                      ?.changeFlightResponse
                                      ?.flightChangAmountString ??
                                  '',
                              style: kMediumHeavy.copyWith(
                                color: Styles.kPrimaryColor,
                              ),
                            )
                          ],
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Divider(),
                        ),
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
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 16,
                ),
                if ((voucherState.response?.addVoucherResult?.voucherDiscounts
                            ?.firstOrNull?.discountAmount ??
                        0.0) ==
                    0.0) ...[
                  RedeemVoucherView(
                    currency: currency,
                    promoReady: true,
                    isManageBooking: true,
                  ),
                ],
                if ((bloc?.state.rewardItem?.redemptionAmount ?? 0.0) == 0.0) ...[
                  VoucherCodeUi(
                    readOnly: false,
                    blocState: voucherState.blocState,
                    voucherCodeInitial:  voucherState.dontShowVoucher == true ? '' :
                    (voucherState.insertedVoucher?.voucherCode ?? ''),
                    state: voucherState,
                    onRemoveTapped: () {
                      if (voucherState.response != null) {
                        removeVoucher(bloc?.currentToken ?? '', context);
                      } else {
                        _fbKey.currentState!.reset();
                      }
                    },
                    onButtonTapped: voucherState.blocState == BlocState.loading
                        // || bookingState.superPnrNo != null
                        ? null
                        : (voucherState.response != null)
                            ? () =>
                                removeVoucher(bloc?.currentToken ?? '', context)
                            : () {
                                if (_fbKey.currentState!.saveAndValidate()) {
                                  if (ConstantUtils.showPinInVoucher) {
                                    final value = _fbKey.currentState!.value;
                                    final voucher = value["voucherCode"];
                                    final pin = value["voucherPin"];
                                    final voucherPin = InsertVoucherPIN(
                                      voucherCode: voucher,
                                    );
                                    final token = bloc?.currentToken ?? '';
                                    final voucherRequest = VoucherRequest(
                                      voucherPins: [voucherPin],
                                      token: token,
                                    );
                                    context
                                        .read<VoucherCubit>()
                                        .addVoucher(voucherRequest);
                                  } else {
                                    final value = _fbKey.currentState!.value;
                                    final voucher = value["voucherCode"];
                                    final token = bloc?.currentToken ?? '';
                                    final voucherRequest = VoucherRequest(
                                      insertVoucher: voucher,
                                      token: token,
                                    );
                                    context
                                        .read<VoucherCubit>()
                                        .addVoucher(voucherRequest);
                                  }
                                }
                              },
                    fbKey: _fbKey,
                    onOnlyTextRemove: () {
                      _fbKey.currentState!.reset();
                      voucherBloc.dontShowVoucher();
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
                const SizedBox(
                  height: 8,
                ),
                const Divider(),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: conditionsCheckOne,
                          onChanged: (bool? value) {
                            setState(() {
                              conditionsCheckOne = value ?? false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: kMediumRegular.copyWith(
                              color: Styles.kTextColor,
                            ),
                            children: [
                              TextSpan(
                                text: 'changeFlightView.changeFlightDesc1'.tr(),
                                style: kMediumSemiBold.copyWith(
                                    color: Styles.kTextColor),
                              ),
                              TextSpan(
                                text: 'changeFlightView.changeFlightDesc2'.tr(),
                              ),
                              TextSpan(
                                text: 'changeFlightView.changeFlightDesc3'.tr(),
                                style: kMediumSemiBold.copyWith(
                                    color: Styles.kPrimaryColor),
                              ),
                              TextSpan(
                                text: 'changeFlightView.changeFlightDesc4'.tr(),
                              ),
                              TextSpan(
                                text: 'changeFlightView.changeFlightDesc5'.tr(),
                                style: kMediumSemiBold.copyWith(
                                    color: Styles.kTextColor),
                              ),
                              TextSpan(
                                text: 'changeFlightView.changeFlightDesc6'.tr(),
                              ),
                              TextSpan(
                                text: 'changeFlightView.changeFlightDesc7'.tr(),
                                style: TextStyle(
                                  color: Styles.kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'changeFlightView.changeFlightDesc8'.tr(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: conditionsCheckTwo,
                          onChanged: (bool? value) {
                            setState(() {
                              conditionsCheckTwo = value ?? false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: kMediumRegular.copyWith(
                              color: Styles.kTextColor,
                            ),
                            children: [
                              TextSpan(
                                text: '${'afterCLicking'.tr()} ',
                              ),

                              TextSpan(
                                text: "'${'continue'.tr()}'",
                                style: kMediumSemiBold.copyWith(
                                    color: Styles.kTextColor),
                              ),

                              TextSpan(
                                text: ' ${'atBottomRight'.tr()}',
                              ),

                              TextSpan(
                                text: " ${'changesAre'.tr()} ",
                                style: kMediumSemiBold.copyWith(
                                    color: Styles.kTextColor),
                              ),

                              TextSpan(
                                text: '${'final'.tr()} ',
                                style: kMediumSemiBold.copyWith(
                                    color: Styles.kPrimaryColor),
                              ),

                              TextSpan(
                                text: "${'andYouWill'.tr()} ",
                                style: kMediumSemiBold.copyWith(
                                    color: Styles.kTextColor),
                              ),

                              TextSpan(
                                text: '${'notCaps'.tr()} ',
                                style: kMediumSemiBold.copyWith(
                                    color: Styles.kPrimaryColor),
                              ),

                              //
                              TextSpan(
                                text: "${'beAbleToRevertBack'.tr()} ",
                                style: kMediumSemiBold.copyWith(
                                    color: Styles.kTextColor),
                              ),

                              TextSpan(text: '${'thereFore'.tr()} '),

                              TextSpan(
                                text: '${'pleaseCheckCaps'.tr()} ',
                                style: kMediumSemiBold.copyWith(
                                    color: Styles.kTextColor),
                              ),

                              TextSpan(text: 'beforeConfirming'.tr()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: Checkbox(
                          checkColor: Colors.white,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: conditionsCheckThree,
                          onChanged: (bool? value) {
                            setState(() {
                              conditionsCheckThree = value ?? false;
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: kMediumRegular.copyWith(
                              color: Styles.kTextColor,
                            ),
                            children: [
                              TextSpan(
                                text: '${'afterPayment'.tr()} ',
                              ),
                              TextSpan(
                                text: " ${'reprintYour'.tr().toUpperCase()} ",
                                style: kMediumSemiBold.copyWith(
                                    color: Styles.kTextColor),
                              ),
                              TextSpan(text: 'reflectYour'.tr()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 200,
                ),

              ],
            ),
          ),
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
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            children: [

              /*if (bloc?.state.changeFlightResponse?.result?.changeFlightResponse

                  ?.totalReservationAmount !=
                  null) ... [
                DiscountSummary(
                  noPadding : true,
                  princToShow: (bloc?.state.changeFlightResponse?.result
                      ?.changeFlightResponse?.totalReservationAmount ??
                      0)
                      .toDouble(),
                  isMMB: true,
                  mmbDiscount:
                  (bloc?.state?.rewardItem?.redemptionAmount ?? 0).toDouble(),
                ),

                SizedBox(height: 8,),
              ],*/



              SummaryContainer(
                child: Padding(
                  padding: kPagePadding,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [


                        BookingSummary(
                          changeFlightCurrency: bloc?.currentCurrency,
                          labelToShow: 'flightResult.totalAmountDue'.tr(),
                          totalAmountToShow: calculateMoneyToShow(
                              changeFlightRequestResponse, discount),
                        ),
                        (bloc?.state.loadingCheckoutPayment == true)
                            ? const AppLoading()
                            : ElevatedButton(
                                onPressed: (conditionsCheckOne == false ||
                                        conditionsCheckTwo == false ||
                                        conditionsCheckThree == false)
                                    ? null
                                    : () async {
                                        final voucher =
                                            voucherBloc.state.appliedVoucher;

                                        var redirectUrl =
                                            await bloc?.checkOutForPayment(voucher);

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
                                        //if (flag == true) {}
                                      },
                                child: Text('continue'.tr()),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  double? calculateMoneyToShow(
      ChangeFlightRequestResponse? changeFlightRequestResponse,
      num calculateMoneyToShow) {
    try {
      return (changeFlightRequestResponse
                  ?.result?.changeFlightResponse?.totalReservationAmount
                  ?.toDouble() ??
              0.0) -
          calculateMoneyToShow.toDouble();
    } catch (e) {
      return 0.0;
    }
  }
}

class PersonHeader extends StatelessWidget {
  const PersonHeader({
    Key? key,
    required this.currentPerson,
    required this.bloc,
  }) : super(key: key);

  final PassengersWithSSRFareBreakDown currentPerson;
  final ManageBookingCubit? bloc;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          currentPerson.passengers?.givenName ?? '',
          style: kMediumHeavy,
        ),
        const Spacer(),
        if (currentPerson.passengers?.isWithinTwoYears == true) ...[
          Text(
            '0.0',
            style: kMediumHeavy.copyWith(
              color: Styles.kPrimaryColor,
            ),
          ),
        ] else ...[
          if (bloc?.state.checkReturn == true &&
              bloc?.state.checkedDeparture == true) ...[
            Text(
              bloc?.onePersonTotalToShow(
                      currentPerson.passengers?.fullName ?? '') ??
                  '',
              style: kMediumHeavy.copyWith(
                color: Styles.kPrimaryColor,
              ),
            ),
          ] else if (bloc?.state.checkReturn == true &&
              bloc?.state.checkedDeparture == false) ...[
            Text(
              (bloc?.onePersonTotalToShowReturn(
                      currentPerson.passengers?.fullName ?? '')) ??
                  '',
              style: kMediumHeavy.copyWith(
                color: Styles.kPrimaryColor,
              ),
            ),
          ] else if (bloc?.state.checkReturn == false &&
              bloc?.state.checkedDeparture == true) ...[
            Text(
              (bloc?.onePersonTotalToShowDepart(
                      currentPerson.passengers?.fullName ?? '')) ??
                  '',
              style: kMediumHeavy.copyWith(
                color: Styles.kPrimaryColor,
              ),
            ),
          ]
        ],
      ],
    );
  }
}

class RedCircle extends StatelessWidget {
  final Color circleColor;

  const RedCircle({super.key, required this.circleColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: circleColor,
      ),
    );
  }
}

class PersonDeparture extends StatelessWidget {
  final ChangeFlightRequestResponse changeFlightRequestResponse;
  final PassengersWithSSRFareBreakDown currentPerson;
  final ManageBookingCubit bloc;

  final String local;

  const PersonDeparture({
    Key? key,
    required this.changeFlightRequestResponse,
    required this.currentPerson,
    required this.bloc,
    required this.local,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (bloc.state.checkedDeparture) ...[
          Row(
            children: [
              Expanded(
                child: Text(
                  data(true),
                  style: kSmallRegular,
                ),
              ),
              Text(
                buildStringAsFixed(true),
                style: kSmallRegular.copyWith(
                  color: buildKPrimaryColor(buildStringAsFixed(true)),
                ),
              ),
            ],
          ),
        ],

        if (bloc.state.checkReturn) ...[
          Row(
            children: [
              Expanded(
                child: Text(
                  data(false),
                  style: kSmallRegular,
                ),
              ),
              Text(
                buildStringAsFixed(false),
                style: kSmallRegular.copyWith(
                  color: buildKPrimaryColor(buildStringAsFixed(false)),
                ),
              ),
            ],
          ),
        ],
        //departUnavaibleSeat

        const SizedBox(
          height: 4,
        ),

        if (availableSeatName(true) != 'N/A' &&
            availableSeatName(false) != 'N/A') ...[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'priceSection.seats'.tr(),
              style: kSmallHeavy.copyWith(color: Styles.kTextColor),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Visibility(
            visible: availableSeatName(true) != 'N/A',
            child: Row(
              children: [
                Text(
                  availableSeatName(true),
                  style: kSmallRegular,
                ),
                const Spacer(),
                Text(
                  availbleAmount(true),
                  style: kSmallRegular.copyWith(
                    color: buildKPrimaryColor(availbleAmount(false)),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: availableSeatName(false) != 'N/A',
            child: Row(
              children: [
                Text(
                  availableSeatName(false),
                  style: kSmallRegular,
                ),
                const Spacer(),
                Text(
                  availbleAmount(false),
                  style: kSmallRegular.copyWith(
                    color: buildKPrimaryColor(availbleAmount(false)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),
        ],

        if (currentPerson.myDepartMeals.isNotEmpty ||
            currentPerson.myReturnMeals.isNotEmpty) ...[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'priceSection.mealsTitle'.tr(),
              style: kSmallHeavy.copyWith(color: Styles.kTextColor),
            ),
          ),
          if (currentPerson.myDepartMeals.isNotEmpty) ...[
            const SizedBox(
              height: 4,
            ),
            for (MealList meal in currentPerson.myDepartMeals) ...[
              Row(
                children: [
                  Text(
                    meal.mealName ?? '',
                    style: kSmallRegular,
                  ),
                  const Spacer(),
                  Text(
                    (meal.amount ?? 0.0).toStringAsFixed(2),
                    style: kSmallRegular.copyWith(
                      color: buildKPrimaryColor(
                          (meal.amount ?? 0.0).toStringAsFixed(2)),
                    ),
                  ),
                ],
              ),
            ],
          ],
          if (currentPerson.myReturnMeals.isNotEmpty) ...[
            const SizedBox(
              height: 4,
            ),
            for (MealList meal in currentPerson.myReturnMeals) ...[
              Row(
                children: [
                  Text(
                    meal.mealName ?? '',
                    style: kSmallRegular,
                  ),
                  const Spacer(),
                  Text(
                    (meal.amount ?? 0.0).toStringAsFixed(2),
                    style: kSmallRegular.copyWith(
                      color: buildKPrimaryColor(
                          (meal.amount ?? 0.0).toStringAsFixed(2)),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ],

        if ((currentPerson.departureBag != null) ||
            (currentPerson.returnBag != null)) ...[
          if (currentPerson.departureBag != null) ...[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'baggage'.tr(),
                style: kSmallHeavy.copyWith(color: Styles.kTextColor),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            if (currentPerson.departureBag != null) ...[
              Row(
                children: [
                  Text(
                    currentPerson.departureBag!.baggageName ?? '',
                    style: kSmallRegular,
                  ),
                  const Spacer(),
                  Text(
                    (currentPerson.departureBag!.amount ?? 0.0)
                        .toStringAsFixed(2),
                    style: kSmallRegular.copyWith(
                      color: buildKPrimaryColor(
                          (currentPerson.departureBag!.amount ?? 0.0)
                              .toStringAsFixed(2)),
                    ),
                  ),
                ],
              ),
            ],
            if (currentPerson.returnBag != null) ...[
              Row(
                children: [
                  Text(
                    currentPerson.returnBag!.baggageName ?? '',
                    style: kSmallRegular,
                  ),
                  const Spacer(),
                  Text(
                    (currentPerson.returnBag!.amount ?? 0.0).toStringAsFixed(2),
                    style: kSmallRegular.copyWith(
                      color: buildKPrimaryColor(
                          (currentPerson.returnBag!.amount ?? 0.0)
                              .toStringAsFixed(2)),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ],

        if ((currentPerson.departureSport != null) ||
            (currentPerson.returnSport != null)) ...[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'priceSection.sportsEquipmentTitle'.tr(),
              style: kSmallHeavy.copyWith(color: Styles.kTextColor),
            ),
          ),
          if (currentPerson.departureSport != null) ...[
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  currentPerson.departureSport!.sportEquipmentName ?? '',
                  style: kSmallRegular,
                ),
                const Spacer(),
                Text(
                  (currentPerson.departureSport!.amount ?? 0.0)
                      .toStringAsFixed(2),
                  style: kSmallRegular.copyWith(
                    color: buildKPrimaryColor(
                        (currentPerson.departureSport!.amount ?? 0.0)
                            .toStringAsFixed(2)),
                  ),
                ),
              ],
            ),
          ],
          if ((currentPerson.returnSport != null)) ...[
            Row(
              children: [
                Text(
                  currentPerson.returnSport!.sportEquipmentName ?? '',
                  style: kSmallRegular,
                ),
                const Spacer(),
                Text(
                  (currentPerson.returnSport!.amount ?? 0.0).toStringAsFixed(2),
                  style: kSmallRegular.copyWith(
                    color: buildKPrimaryColor(
                        (currentPerson.returnSport!.amount ?? 0.0)
                            .toStringAsFixed(2)),
                  ),
                ),
              ],
            ),
          ],
        ],

        if ((currentPerson.insuranceDepart != null)) ...[
          if (currentPerson.insuranceDepart != null) ...[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'priceSection.insuranceTitle'.tr(),
                style: kSmallHeavy.copyWith(color: Styles.kTextColor),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  currentPerson.insuranceDepart?.insuranceSSRName ?? '',
                  style: kSmallRegular,
                ),
                const Spacer(),
                Text(
                  (currentPerson.insuranceDepart!.amount ?? 0.0)
                      .toStringAsFixed(2),
                  style: kSmallRegular.copyWith(
                    color: buildKPrimaryColor(
                        (currentPerson.insuranceDepart!.amount ?? 0.0)
                            .toStringAsFixed(2)),
                  ),
                ),
              ],
            ),
          ],
        ],

        //insuranceDepart
        if ((currentPerson.wheelChairDepart != null) ||
            (currentPerson.wheelChairReturn != null)) ...[
          const SizedBox(
            height: 4,
          ),
          if (currentPerson.wheelChairDepart != null) ...[
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  'priceSection.wheelchair'.tr(),
                  style: kSmallRegular,
                ),
                const Spacer(),
                Text(
                  (currentPerson.wheelChairDepart!.amount ?? 0.0)
                      .toStringAsFixed(2),
                  style: kSmallRegular.copyWith(
                    color: buildKPrimaryColor(
                        (currentPerson.wheelChairDepart!.amount ?? 0.0)
                            .toStringAsFixed(2)),
                  ),
                ),
              ],
            ),
          ],
          if ((currentPerson.wheelChairReturn != null)) ...[
            Row(
              children: [
                Text(
                  'priceSection.wheelchair'.tr(),
                  style: kSmallRegular,
                ),
                const Spacer(),
                Text(
                  (currentPerson.wheelChairReturn!.amount ?? 0.0)
                      .toStringAsFixed(2),
                  style: kSmallRegular.copyWith(
                    color: buildKPrimaryColor(
                        (currentPerson.wheelChairReturn!.amount ?? 0.0)
                            .toStringAsFixed(2)),
                  ),
                ),
              ],
            ),
          ],
        ],

        if (currentPerson.notAvailableSeatDetail != null) ...[
          if ((currentPerson.notAvailableSeatDetail?.departUnavaibleSeat !=
              null)) ...[
            Row(
              children: [
                Text(
                  seatName(true),
                  style: kSmallRegular,
                ),
                const Spacer(),
                Text(
                  seatAmount(true),
                  style: kSmallRegular.copyWith(
                    color: buildKPrimaryColor(seatAmount(true)),
                  ),
                ),
              ],
            )
          ],
        ],

        if (currentPerson.notAvailableSeatDetail != null) ...[
          if ((currentPerson.notAvailableSeatDetail?.departUnavaibleSeat !=
              null)) ...[
            Row(
              children: [
                Text(
                  seatName(false),
                  style: kSmallRegular,
                ),
                const Spacer(),
                Text(
                  seatAmount(false),
                  style: kSmallRegular.copyWith(
                    color: buildKPrimaryColor(seatAmount(false)),
                  ),
                ),
              ],
            )
          ],
        ],
      ],
    );
  }

  Color buildKPrimaryColor(String amount) {
    if (amount == '0.00') {
      return Styles.kTextColor;
    }
    return Styles.kPrimaryColor;
  }

  String seatAmount(bool flag) {
    if (flag == true) {
      return currentPerson.notAvailableSeatDetail?.departSeatAmount ?? '';
    }
    return currentPerson.notAvailableSeatDetail?.returnSeatAmount ?? '';
  }

  String availbleAmount(bool flag) {
    if (flag == true) {
      return currentPerson.seatDetail?.departSeatAmount ?? '';
    }
    return currentPerson.seatDetail?.returnSeatAmount ?? '';
  }

  String availableMealName() {
    /*
    if(isDeparture == true) {
      return currentPerson.mealDetail
          ?.departSeatName ?? '';
    }
    return currentPerson.mealDetail
        ?.returnSeatName ??
        '';*/

    return '';
  }

  String availableSeatName(bool flag) {
    if (flag == true) {
      return currentPerson.seatDetail?.departSeatName ?? '';
    }
    return currentPerson.seatDetail?.returnSeatName ?? '';
  }

  String seatName(bool flag) {
    if (flag == true) {
      return currentPerson.notAvailableSeatDetail?.departSeatName ?? '';
    }
    return currentPerson.notAvailableSeatDetail?.returnSeatName ?? '';
  }

  String buildStringAsFixed(bool flag) {
    if (flag == true) {
      return (bloc.onePersonTotalToShowDepart(
          currentPerson.passengers?.fullName ?? ''));
    }
    return (bloc
        .onePersonTotalToShowReturn(currentPerson.passengers?.fullName ?? ''));
  }

  String data(bool flag) {
    if (flag == true) {
      return '${'specialSelection.departureFlight'.tr()} ${changeFlightRequestResponse.result?.changeFlightResponse?.flightBreakDown?.departDetail?.routeNameToShow(local) ?? ''}';
    }
    return '${'specialSelection.returnFlight'.tr()} ${changeFlightRequestResponse.result?.changeFlightResponse?.flightBreakDown?.returnDetail?.routeNameToShow(local) ?? ''}';
  }
}
