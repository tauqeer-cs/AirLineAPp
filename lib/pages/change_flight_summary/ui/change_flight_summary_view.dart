import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../app/app_bloc_helper.dart';
import '../../../app/app_router.dart';
import '../../../blocs/booking/booking_cubit.dart';
import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../blocs/voucher/voucher_cubit.dart';
import '../../../data/requests/voucher_request.dart';
import '../../../data/responses/change_flight_response.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../utils/constant_utils.dart';
import '../../../utils/date_utils.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_loading_screen.dart';
import '../../booking_details/ui/booking_details_view.dart';
import '../../checkout/pages/payment/ui/voucher_ui.dart';
import '../../search_result/ui/booking_summary.dart';
import '../../select_change_flight/ui/booking_refrence_label.dart';
import 'package:collection/collection.dart';

class ChangeFlightSummaryView extends StatelessWidget {
  ChangeFlightSummaryView({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    bloc = context.watch<ManageBookingCubit>();
    var state = bloc?.state;
    var voucherBloc = context.watch<VoucherCubit>();

    var voucherState = voucherBloc.state;

    final discount = voucherState.response?.addVoucherResult?.voucherDiscounts
            ?.firstOrNull?.discountAmount ??
        0.0;

    var departureDate = state?.changeFlightResponse?.result
        ?.flightVerifyResponse?.result?.flightSegments?.last.departureDate;
    ChangeFlightRequestResponse? changeFlightRequestResponse =
        state?.changeFlightResponse;

    var flightSectionGoing = state?.changeFlightResponse?.result
        ?.flightVerifyResponse?.result?.flightSegments?.first;
    var flightSectionBack = state?.changeFlightResponse?.result
        ?.flightVerifyResponse?.result?.flightSegments?.last;

    void removeVoucher(String currentToken, BuildContext context) {
      _fbKey.currentState!.reset();
      final token = currentToken;
      final voucherRequest = VoucherRequest(
        token: token,
      );
      context.read<VoucherCubit>().removeVoucher(voucherRequest);
    }

    return SizedBox(
      height: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: kPageHorizontalPadding,
              child: SingleChildScrollView(
                child: Column(
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
                              Text(
                                AppDateUtils.formatFullDate(
                                    DateTime.parse(departureDate ?? '')),
                                style: kSmallRegular.copyWith(
                                  color: Styles.kTextColor,
                                  height: 1.5,
                                ),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: double.infinity,
                              height: 4,
                            ),
                            if ((bloc?.state.checkedDeparture == true)) ...[
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Row(
                                  children: [
                                    Text(
                                      'Departure',
                                      style: kMediumHeavy.copyWith(
                                          color: Styles.kPrimaryColor),
                                    ),
                                    const Spacer(),
                                    Text(
                                      flightSectionGoing?.departureDateToShow ??
                                          '',
                                      style: kMediumMedium.copyWith(
                                          color: Styles.kTextColor),
                                    ),
                                  ],
                                ),
                              ),

                              //],

                              //flightSectionGoing

                              Text(
                                state?.manageBookingResponse?.result
                                        ?.departureToDestinationCode ??
                                    '',
                                style: kMediumSemiBold.copyWith(
                                    color: Styles.kTextColor),
                              ),
                              kVerticalSpacerMini,
                              Row(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: FlightInto(
                                      label: 'Depart',
                                      timeString: flightSectionGoing
                                              ?.departureDateToTwoLine ??
                                          '',
                                      location: state?.manageBookingResponse
                                              ?.result?.departureAirportName ??
                                          '',
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: PlaneWithTime(
                                        time: state
                                                ?.manageBookingResponse
                                                ?.result
                                                ?.journeyTimeInHourMin ??
                                            '',
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: FlightInto(
                                      label: 'Arrive',
                                      timeString: flightSectionGoing
                                              ?.arrivalDateToTwoLine ??
                                          '',
                                      location: state?.manageBookingResponse
                                              ?.result?.arrivalAirportName ??
                                          '',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 8,
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(
                                    width: double.infinity,
                                    height: 4,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Return',
                                          style: kMediumHeavy.copyWith(
                                              color: Styles.kPrimaryColor),
                                        ),
                                        const Spacer(),
                                        Text(
                                          flightSectionBack
                                                  ?.departureDateToShow ??
                                              '',
                                          style: kMediumMedium.copyWith(
                                              color: Styles.kTextColor),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    state?.manageBookingResponse?.result
                                            ?.returnToDestinationCode ??
                                        '',
                                    style: kMediumSemiBold.copyWith(
                                        color: Styles.kTextColor),
                                  ),
                                  kVerticalSpacerMini,
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: FlightInto(
                                          label: 'Depart',
                                          timeString: flightSectionBack
                                                  ?.departureDateToTwoLine ??
                                              '',
                                          location: state
                                                  ?.manageBookingResponse
                                                  ?.result
                                                  ?.returnDepartureAirportName ??
                                              '',
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4),
                                          child: PlaneWithTime(
                                            time: state
                                                    ?.manageBookingResponse
                                                    ?.result
                                                    ?.returnJourneyTimeInHourMin ??
                                                '',
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: FlightInto(
                                          label: 'Arrive',
                                          timeString: flightSectionBack
                                                  ?.arrivalDateToTwoLine ??
                                              '',
                                          location: state
                                                  ?.manageBookingResponse
                                                  ?.result
                                                  ?.returnArrivalAirportName ??
                                              '',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                    ],
                                  ),
                                  kVerticalSpacerSmall,
                                ],
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
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
                            Row(
                              children: [
                                const Text(
                                  'Flight Change',
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
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    ),
                    const SizedBox(
                      height: 16,
                    ),

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
                      onButtonTapped: voucherState.blocState ==
                              BlocState.loading
                          // || bookingState.superPnrNo != null
                          ? null
                          : (voucherState.response != null)
                              ? () => removeVoucher(
                                  bloc?.currentToken ?? '', context)
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

                    ///
                  ],
                ),
              ),
            ),
          ),
          SummaryContainer(
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
        ],
      ),
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
