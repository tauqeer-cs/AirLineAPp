import 'package:app/widgets/app_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app_router.dart';
import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../utils/date_utils.dart';
import '../../../widgets/app_loading_screen.dart';
import '../../search_result/ui/booking_summary.dart';
import '../../search_result/ui/choose_flight_segment.dart';
import '../../search_result/ui/summary_container_listener.dart';
import 'booking_refrence_label.dart';

class SelectChangeFlightView extends StatefulWidget {
  const SelectChangeFlightView({Key? key}) : super(key: key);

  @override
  State<SelectChangeFlightView> createState() => _SelectChangeFlightViewState();
}

class _SelectChangeFlightViewState extends State<SelectChangeFlightView> {
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

  ManageBookingCubit? bloc;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild());

    bloc = context.watch<ManageBookingCubit>();

    //TODO
    //this need to be done
    String noOfPerson =
        bloc?.state.manageBookingResponse?.result?.toBeautify() ?? '1';

    return Stack(
      children: [
        SummaryContainerListener(
          scrollController: scrollController,
          child: Padding(
            padding: kPageHorizontalPadding,
            child: ListView(
              controller: scrollController,
              children: [
                kVerticalSpacer,

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: BookingReferenceLabel(
                        refText: bloc?.state.pnrEntered,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: OutlinedButton(
                          child: FittedBox(
                            child: Text(
                              'changeSearch'.tr(),
                              style: k18SemiBold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    )
                  ],
                ),

                Text(
                  bloc?.state.manageBookingResponse?.result
                          ?.arrivalAirportName ??
                      '',
                  style: kLargeHeavy,
                ),
//
                kVerticalSpacerSmall,
                Text(
                  'starterFareIncludes'.tr(),
                  textAlign: TextAlign.left,
                  style: kMediumRegular.copyWith(
                    color: Styles.kSubTextColor,
                    height: 1.5,
                  ),
                ),
                if (bloc != null) ...[
                  buildFlights(bloc!.state),
                ],

                kVerticalSpacer,
                // Visibility(
                //   visible: false,
                //   replacement: Text(
                //     "All fares are calculated based on a one-way flight for a single adult passenger. You may make changes to your booking for a nominal fee. All fares are non-refundable, for more information please read our Fare Rules.",
                //     style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
                //   ),
                //   child: Text(
                //     "Prices are based on an 'numberPerson.toBeautify()'. Fares are non-refundable, limited changes are permitted, and charges may apply. ",
                //     style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
                //   ),
                // ),
                /*
                Visibility(
                  visible: false,
                  replacement: Text(
                    'flightSummary.fareRules'.tr(args: [noOfPerson]),
                    style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
                  ),
                  child: Text(
                    'flightSummary.rules'.tr(args: [noOfPerson]),
                    style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
                  ),
                ),*/

                const SizedBox(
                  height: 160,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BookingSummary(
                    isChangeFlight: true,
                    totalAmountToShow: bloc?.totalAmountToShowInChangeFlight,
                  ),
                  (bloc?.state.loadingSelectingFlight == true)
                      ? const AppLoading()
                      : ElevatedButton(
                          onPressed: () async {
                            if (bloc?.showChangeButton == false) {
                              return;
                            }

                            var flag = await bloc?.changeFlight();
                            if (flag == true) {
                              context.router.push(
                                const ChangeFlightSummaryRoute(),
                              );
                            }
                          },
                          child: Text('changeFlightView.continue'.tr()),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column buildFlights(ManageBookingState state) {
    return Column(
      children: [
        if (state.checkedDeparture == true) ...[

          if (state.flightSearchResponse?.searchFlightResponse?.flightResult
              ?.isOutboundNotAvailable ==
              true) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kVerticalSpacer,
                Row(
                  children: [
                    Transform.translate(
                      offset: const Offset(-16, 0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Styles.kDividerColor,
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(50),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('topForm.return'.tr(), style: k18Heavy),
                            Text(
                                state.manageBookingResponse?.result
                                    ?.departureToDestinationCode ??
                                    '',
                                style: kLargeRegular),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
                kVerticalSpacerBig,
                Text(AppDateUtils.formatFullDate(state.manageBookingResponse?.newStartDateSelected ?? DateTime.now()),
                    style: kLargeHeavy.copyWith(color: Styles.kSubTextColor)),
                kVerticalSpacerBig,
                AppCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(state.flightSearchResponse?.searchFlightResponse
                            ?.flightResult?.outboundNotAvailableMessage ??
                            ''),
                        kVerticalSpacerSmall,
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 3,
                              child: ElevatedButton(
                                onPressed: () {

                                  Navigator.pop(context);

                                },
                                child: Text('back'.tr()),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ] else ... [
            ChooseFlightSegment(
              title: 'bundleTab.depart'.tr(),
              subtitle: state.manageBookingResponse?.result
                  ?.departureToDestinationCode ??
                  '',
              dateTitle: AppDateUtils.formatFullDate(state
                  .flightSearchResponse
                  ?.searchFlightResponse
                  ?.flightResult
                  ?.outboundSegment
                  ?.first
                  .departureDate),
              segments: state.selectedDepartureFlight != null
                  ? [state.selectedDepartureFlight!]
                  : state.flightSearchResponse?.searchFlightResponse?.flightResult
                  ?.outboundSegment ??
                  [],
              isDeparture: true,
              changeFlight: true,
              visaPromo: false,
            ),
          ],

        ],
        kVerticalSpacer,
        if ((state.manageBookingResponse?.isTwoWay ?? true) &&
            state.checkReturn == true) ...[
          if (state.flightSearchResponse?.searchFlightResponse?.flightResult
                  ?.isInboundNotAvailable ==
              true) ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kVerticalSpacer,
                Row(
                  children: [
                    Transform.translate(
                      offset: const Offset(-16, 0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Styles.kDividerColor,
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(50),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('bundleTab.return'.tr(), style: k18Heavy),
                            Text(
                                state.manageBookingResponse?.result
                                        ?.returnToDestinationCode ??
                                    '',
                                style: kLargeRegular),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                  ],
                ),
                kVerticalSpacerBig,
                Text(AppDateUtils.formatFullDate(state.manageBookingResponse?.newReturnDateSelected ?? DateTime.now()),
                    style: kLargeHeavy.copyWith(color: Styles.kSubTextColor)),
                kVerticalSpacerBig,
                AppCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(state.flightSearchResponse?.searchFlightResponse
                                ?.flightResult?.inboundNotAvailableMessage ??
                            ''),
                        kVerticalSpacerSmall,
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 3,
                              child: ElevatedButton(
                                onPressed: () {

                                  Navigator.pop(context);

                                },
                                child: Text('back'.tr()),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ] else ...[
            Visibility(
              //visible: state.filterState?.flightType == FlightType.round,
              child: ChooseFlightSegment(
                title: 'bundleTab.return'.tr(),
                subtitle: state.manageBookingResponse?.result
                        ?.returnToDestinationCode ??
                    '',
                dateTitle: AppDateUtils.formatFullDate(state
                    .flightSearchResponse
                    ?.searchFlightResponse
                    ?.flightResult
                    ?.inboundSegment
                    ?.first
                    .departureDate),
                segments: state.selectedReturnFlight != null
                    ? [state.selectedReturnFlight!]
                    : state.flightSearchResponse?.searchFlightResponse
                            ?.flightResult?.inboundSegment ??
                        [],
                isDeparture: false,
                changeFlight: true,
                visaPromo: false,
              ),
            ),
          ],
        ],
      ],
    );
  }
}
