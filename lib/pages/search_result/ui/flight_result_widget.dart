import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/search_result/ui/choose_flight_segment.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/widgets/animations/booking_loader.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/app_router.dart';
import '../bloc/summary_container_cubit.dart';

class FlightResultWidget extends StatelessWidget {
  const FlightResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    return BlocBuilder<SearchFlightCubit, SearchFlightState>(
      builder: (context, state) {
        return blocBuilderWrapper(
          blocState: state.blocState,
          finishedBuilder: Padding(
            padding: kPageHorizontalPadding,
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        state.filterState?.beautify ?? "",
                        style: kHugeHeavy,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    kHorizontalSpacerMini,
                    BlocBuilder<BookingCubit, BookingState>(
                      builder: (context, state) {
                        return Visibility(
                          //visible: !state.isVerify,
                          child: Expanded(
                            flex: 3,
                            child: OutlinedButton(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text("changeSearch".tr()),
                              ),
                              onPressed: () {
                                context
                                    .read<SummaryContainerCubit>()
                                    .changeVisibility(true);
                                context.router.push(const ChangeSearchRoute());
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                kVerticalSpacerSmall,
                Text(
                  'starterFareIncludes'.tr(),
                  textAlign: TextAlign.left,
                  style: kMediumRegular.copyWith(
                    color: Styles.kSubTextColor,
                    height: 1.5,
                  ),
                ),
                BlocBuilder<BookingCubit, BookingState>(
                  builder: (context, bookState) {
                    return blocBuilderWrapper(
                      blocState: bookState.blocState,
                      finishedBuilder: buildFlights(
                        state,
                        bookState,
                      ),
                      initialBuilder: buildFlights(
                        state,
                        bookState,
                      ),
                      loadingBuilder: const BookingLoader(),
                    );
                  },
                ),
                kVerticalSpacer,
                Visibility(
                  visible: false,
                  replacement: Text(
                    'fareCalculation'
                        .tr(args: [filter?.numberPerson.toBeautify() ?? '']),
                    style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
                  ),
                  child: Text(
                    'flightSummary.rules'
                        .tr(args: [filter?.numberPerson.toBeautify() ?? '']),
                    style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Column buildFlights(SearchFlightState state, BookingState bookState) {
    return Column(
      children: [
        ChooseFlightSegment(
          title: "departure".tr(),
          subtitle: state.filterState?.beautifyShort ?? "",
          dateTitle: AppDateUtils.formatHalfDate(state.filterState?.departDate),
          segments: bookState.selectedDeparture != null
              ? [bookState.selectedDeparture!]
              : state.flights?.flightResult?.outboundSegment ?? [],
          isDeparture: true,
          visaPromo: state.isVisaPromo ?? false,
        ),
        kVerticalSpacer,
        Visibility(
          visible: state.filterState?.flightType == FlightType.round,
          child: ChooseFlightSegment(
            title: "return".tr(),
            subtitle: state.filterState?.beautifyReverseShort ?? "",
            dateTitle:
                AppDateUtils.formatHalfDate(state.filterState?.returnDate),
            segments: bookState.selectedReturn != null
                ? [bookState.selectedReturn!]
                : state.flights?.flightResult?.inboundSegment ?? [],
            isDeparture: false,
            visaPromo: state.isVisaPromo ?? false,
          ),
        ),
      ],
    );
  }
}
