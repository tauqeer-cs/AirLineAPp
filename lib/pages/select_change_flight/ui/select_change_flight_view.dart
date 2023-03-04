import 'package:auto_route/auto_route.dart';
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

  @override
  void dispose() {
    scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  final scrollController = ScrollController();
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

    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: kPageHorizontalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          child: const FittedBox(
                            child: Text(
                              "Change Search",
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
                  "Your starter fares include 7kg of carry-on baggage. Next, you can purchase additional baggage, select your seat of choice and meal.",
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
                Visibility(
                  visible: false,
                  replacement: Text(
                    "All fares are calculated based on a one-way flight for a single adult passenger. You may make changes to your booking for a nominal fee. All fares are non-refundable, for more information please read our Fare Rules.",
                    style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
                  ),
                  child: Text(
                    "Prices are based on an 'numberPerson.toBeautify()'. Fares are non-refundable, limited changes are permitted, and charges may apply. ",
                    style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),


         if(bloc?.showChangeButton ?? false) ... [
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
                     //const BookingSummary(),
                     (bloc?.state.loadingSelectingFlight == true)
                         ? const AppLoading()
                         : ElevatedButton(
                       onPressed: () async {
                         var flag = await bloc?.changeFlight();
                         if (flag == true) {
                           context.router.push(
                             const ChangeFlightSummaryRoute(),
                           );
                         }
                       },
                       child: const Text("Continue"),
                     ),
                   ],
                 ),
               ),
             ),
           ),
         ],

      ],
    );
  }

  Column buildFlights(ManageBookingState state) {
    return Column(
      children: [
        if (state.checkedDeparture == true) ...[
          ChooseFlightSegment(
            title: "Depart",
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
            segments: state.flightSearchResponse?.searchFlightResponse
                    ?.flightResult?.outboundSegment ??
                [],
            isDeparture: true,
            changeFlight: true,
            visaPromo: false,
          ),
        ],
        kVerticalSpacer,
        if ((state.manageBookingResponse?.isTwoWay ?? true) &&
            state.checkReturn == true) ...[
          Visibility(
            //visible: state.filterState?.flightType == FlightType.round,
            child: ChooseFlightSegment(
              title: "Return",
              subtitle: state
                      .manageBookingResponse?.result?.returnToDestinationCode ??
                  '',
              dateTitle: AppDateUtils.formatFullDate(state
                  .flightSearchResponse
                  ?.searchFlightResponse
                  ?.flightResult
                  ?.inboundSegment
                  ?.first
                  .departureDate),
              segments: state.flightSearchResponse?.searchFlightResponse
                      ?.flightResult?.inboundSegment ??
                  [],
              isDeparture: false,
              changeFlight: true,
              visaPromo: false,
            ),
          ),
        ],
      ],
    );
  }
}
