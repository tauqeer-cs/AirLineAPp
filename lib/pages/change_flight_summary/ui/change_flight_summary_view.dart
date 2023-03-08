import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../app/app_bloc_helper.dart';
import '../../../app/app_flavor.dart';
import '../../../app/app_router.dart';
import '../../../blocs/booking/booking_cubit.dart';
import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../blocs/voucher/voucher_cubit.dart';
import '../../../data/requests/voucher_request.dart';
import '../../../data/responses/change_flight_response.dart';
import '../../../data/responses/manage_booking_response.dart';
import '../../../models/confirmation_model.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../utils/constant_utils.dart';
import '../../../utils/date_utils.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_loading_screen.dart';
import '../../booking_details/ui/booking_details_view.dart';
import '../../booking_details/ui/flight_data.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild());

    bloc = context.watch<ManageBookingCubit>();
    var state = bloc?.state;
    var voucherBloc = context.watch<VoucherCubit>();

    var voucherState = voucherBloc.state;

    final discount = voucherState.response?.addVoucherResult?.voucherDiscounts
            ?.firstOrNull?.discountAmount ??
        0.0;

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




      }
      else {

         departureDate = state?.changeFlightResponse?.result
            ?.flightVerifyResponse?.result?.flightSegments?.first.departureDate;

         returnDate = state?.changeFlightResponse?.result?.flightVerifyResponse
            ?.result?.flightSegments?.last.departureDate;

      }
    }

    void removeVoucher(String currentToken, BuildContext context) {
      _fbKey.currentState!.reset();
      final token = currentToken;
      final voucherRequest = VoucherRequest(
        token: token,
      );
      context.read<VoucherCubit>().removeVoucher(voucherRequest);
    }

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
                      crossAxisAlignment : CrossAxisAlignment.start,
                            children: [
                              if (bloc?.state.checkedDeparture == true &&
                                  bloc?.state.checkReturn == true) ...[
                                Text(
                                  '${AppDateUtils.formatFullDate(
                                    DateTime.parse(departureDate ?? '') ,
                                  )} -',
                                  style: kSmallRegular.copyWith(
                                    color: Styles.kTextColor,
                                    height: 1.5,
                                  ),
                                ),
                                Text(
                                  AppDateUtils.formatFullDate(
                                    DateTime.parse(returnDate ?? ''),
                                  ),
                                  style: kSmallRegular.copyWith(
                                    color: Styles.kTextColor,
                                    height: 1.5,
                                  ),
                                ),
                              ] else ...[
                                Text(
                                  AppDateUtils.formatFullDate(
                                    DateTime.parse(departureDate ?? ''),
                                  ),
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
                            headingLabel: 'Departure',
                            dateToShow:
                                flightSectionGoing?.departureDateToShow ?? '',
                            departureToDestinationCode: state
                                    ?.manageBookingResponse
                                    ?.result
                                    ?.departureToDestinationCode ??
                                '',
                            departureDateWithTime:
                                flightSectionGoing?.departureDateToTwoLine ??
                                    '',
                            departureAirportName: state?.manageBookingResponse
                                    ?.result?.departureAirportName ??
                                '',
                            journeyTimeInHourMin: state?.manageBookingResponse
                                    ?.result?.journeyTimeInHourMin ??
                                '',
                            arrivalDateWithTime:
                                flightSectionGoing?.arrivalDateToTwoLine ?? '',
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
                            headingLabel: 'Return',
                            dateToShow:
                                flightSectionBack?.departureDateToShow ?? '',
                            departureToDestinationCode: state
                                    ?.manageBookingResponse
                                    ?.result
                                    ?.returnToDestinationCode ??
                                '',
                            departureDateWithTime:
                                flightSectionBack?.departureDateToTwoLine ?? '',
                            departureAirportName: state?.manageBookingResponse
                                    ?.result?.returnDepartureAirportName ??
                                '',
                            journeyTimeInHourMin: state?.manageBookingResponse
                                    ?.result?.returnJourneyTimeInHourMin ??
                                '',
                            arrivalDateWithTime:
                                flightSectionBack?.arrivalDateToTwoLine ?? '',
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
                            const Text(
                              'Summary',
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
                          ),
                          kVerticalSpacerSmall,
                        ],
                        kVerticalSpacerSmall,
                        Row(
                          children: [
                            const Text(
                              'Flight Change Fee',
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
                                      'Changes',
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
                                      'Existing Add-Ons',
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
                if (AppFlavor.appFlavor == Flavor.staging) ...[
                  VoucherCodeUi(
                    readOnly: false,
                    blocState: voucherState.blocState,
                    voucherCodeInitial:
                        voucherState.insertedVoucher?.voucherCode ?? '',
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
                                      voucherPin: pin,
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
                  ),
                ],
                const SizedBox(
                  height: 200,
                ),
              ],
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    BookingSummary(
                      labelToShow: 'Total Amount Due',
                      totalAmountToShow: calculateMoneyToShow(
                          changeFlightRequestResponse, discount),
                    ),
                    (bloc?.state.loadingCheckoutPayment == true)
                        ? const AppLoading()
                        : ElevatedButton(
                            onPressed: () async {
                              final voucher = context
                                  .read<VoucherCubit>()
                                  .state
                                  .appliedVoucher;

                              var redirectUrl =
                                  await bloc?.checkOutForPayment(voucher);

                              if (redirectUrl != null) {
                                final result = await context.router.push(
                                  WebViewRoute(
                                      url: "", htmlContent: redirectUrl),
                                );

                                if (result != null && result is String) {
                                  bloc?.reloadDataForConfirmation();

                                  final urlParsed = Uri.parse(result);
                                  var query = urlParsed.queryParametersAll;
                                  String? status = query['status']?.first;
                                  String? superPNR = query['superPNR']?.first;
                                  if (status != "FAIL") {
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

                                    //context.router.popUntilRoot();
                                    context.router.replaceAll([
                                      const NavigationRoute(),
                                      ChangeFlightConfirmationRoute(
                                        bookingId: superPNR ?? "",
                                      ),
                                    ]);
                                  } else {
                                    //    if (mounted) {
                                    //     Toast.of(context).show(message: "Payment failed");
                                    // }

                                  }
                                } else {}
                              }
                              //if (flag == true) {}
                            },
                            child: const Text("Continue"),
                          ),
                  ],
                ),
              ),
            ),
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

  const PersonDeparture({
    Key? key,
    required this.changeFlightRequestResponse,
    required this.currentPerson,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (bloc.state.checkedDeparture) ...[
          Row(
            children: [
              Text(
                data(true),
                style: kSmallRegular,
              ),
              const Spacer(),
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
              Text(
                data(false),
                style: kSmallRegular,
              ),
              const Spacer(),
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
              'Seats',
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
              'Meals',
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
                'Baggage',
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
              'Sports Equipment',
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
                'Insurance',
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
          SizedBox(
            height: 4,
          ),
          if (currentPerson.wheelChairDepart != null) ...[
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const Text(
                  'Wheel Chair',
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
                  'Wheel Chair',
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
      return 'Departure Flight ${changeFlightRequestResponse.result?.changeFlightResponse?.flightBreakDown?.departDetail?.routeNameToShow ?? ''}';
    }
    return 'Return Flight ${changeFlightRequestResponse.result?.changeFlightResponse?.flightBreakDown?.returnDetail?.routeNameToShow ?? ''}';
  }
}
