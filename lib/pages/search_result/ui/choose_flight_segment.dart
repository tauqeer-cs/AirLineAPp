import 'package:app/app/app_router.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/pages/search_result/ui/segment_card.dart';
import 'package:app/pages/search_result/ui/sort_sheet.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/utils/string_utils.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

enum SortFlight {
  cheapest,
  earliest,
  fastest;

  @override
  String toString() {
    return name.capitalize();
  }
}

class ChooseFlightSegment extends StatefulWidget {
  final String title;
  final String subtitle;
  final String dateTitle;
  final List<InboundOutboundSegment> segments;
  final bool isDeparture;

  final bool visaPromo;

  final bool changeFlight;

  const ChooseFlightSegment(
      {Key? key,
      required this.title,
      required this.visaPromo,
      required this.subtitle,
      required this.dateTitle,
      required this.segments,
      required this.isDeparture,
      this.changeFlight = false})
      : super(key: key);

  @override
  State<ChooseFlightSegment> createState() => _ChooseFlightSegmentState();
}

class _ChooseFlightSegmentState extends State<ChooseFlightSegment> {
  SortFlight selectedSort = SortFlight.cheapest;

  @override
  Widget build(BuildContext context) {
    final sortedSegment = List<InboundOutboundSegment>.from(widget.segments);
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    sort(sortedSegment);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kVerticalSpacer,
        Row(
          children: [
            Transform.translate(
              offset: const Offset(-16, 0),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 40, 16),
                decoration: BoxDecoration(
                  color: Styles.kDividerColor,
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(50),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: k18Heavy),
                    Text(widget.subtitle, style: kLargeRegular),
                  ],
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    onTap: _onOpenSheet,
                    child: Column(
                      children: [
                        Icon(
                          Icons.filter_alt_rounded,
                          color: Styles.kBorderColor,
                          size: 25,
                        ),
                        Text(
                          'sortBy'.tr(),
                          style: kSmallRegular.copyWith(
                              color: Styles.kBorderColor),
                        ),
                        Text(
                          selectedSort.toString(),
                          style: kSmallHeavy,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        kVerticalSpacerBig,
        Row(
          children: [
            Text(
              widget.dateTitle,
              style: kLargeHeavy.copyWith(color: Styles.kSubTextColor),
            ),
            kHorizontalSpacerMini,
            JustTheTooltip(
              triggerMode: TooltipTriggerMode.tap,
              preferredDirection: AxisDirection.up,
              backgroundColor: Color.fromRGBO(237, 242, 244, 1),
              margin: const EdgeInsets.all(16),
              child: Icon(
                Icons.info,
                color: Styles.kPrimaryColor,
              ),
              content: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  text: TextSpan(
                    style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            'All fares are calculated based on a one-way flight for ${filter?.numberPerson.toBeautify()}. You may make changes to your booking for a nominal fee. All fares are non-refundable, for more information please read our ',
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.router.push(
                              WebViewSimpleRoute(url: "/fares-fees"),
                            );
                          },
                        style:
                            kMediumMedium.copyWith(color: Styles.kPrimaryColor),
                        text: 'Fare Rules.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // JustTheTooltipEntry(
            //   tailLength: 10.0,
            //   preferredDirection: AxisDirection.up,
            //   isModal: true,
            //   margin: const EdgeInsets.all(20.0),
            //   child: Icon(
            //     Icons.info,
            //     color: Styles.kPrimaryColor,
            //   ),
            //   backgroundColor: Color.fromRGBO(237,242,244,1),
            //   content: Padding(
            //     padding: EdgeInsets.all(16.0),
            //     child: Text(
            //       "All fares are calculated based on a one-way flight for ${filter?.numberPerson.toBeautify()}. You may make changes to your booking for a nominal fee. All fares are non-refundable, for more information please read our Fare Rules.",
            //       style: kMediumRegular.copyWith(color: Styles.kSubTextColor),
            //     ),
            //   ),
            // )
          ],
        ),
        sortedSegment.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'flight.noAvailable'.tr(),
                    style: kHugeSemiBold,
                  ),
                ),
              )
            : Column(
                children: sortedSegment
                    .map(
                      (e) => SegmentCard(
                        segment: e,
                        isDeparture: widget.isDeparture,
                        changeFlight: widget.changeFlight,
                        showVisa: widget.visaPromo,
                      ),
                    )
                    .toList(),
              ),
      ],
    );
  }

  _onOpenSheet() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (_) => SortSheet(
        defaultValue: selectedSort,
        onChanged: onChangeSort,
      ),
      constraints: BoxConstraints(
        maxWidth: 0.92.sw,
      ),
      backgroundColor: const Color.fromRGBO(235, 235, 235, 0.85),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
    );
  }

  onChangeSort(SortFlight sortFlight) {
    setState(() {
      selectedSort = sortFlight;
      //sort(List<InboundOutboundSegment>.from(widget.segments));
    });
  }

  List<InboundOutboundSegment> sort(List<InboundOutboundSegment> list) {
    switch (selectedSort) {
      case SortFlight.cheapest:
        list.sort(
            (a, b) => a.getTotalPriceDisplay.compareTo(b.getTotalPriceDisplay));
        break;
      case SortFlight.earliest:
        list.sort(
          (a, b) => (a.departureDate ?? DateTime.now()).compareTo(
            b.departureDate ?? DateTime.now(),
          ),
        );
        break;
      case SortFlight.fastest:
        list.sort(
          (a, b) => (a.segmentDetail?.flightTime ?? 0)
              .compareTo(b.segmentDetail?.flightTime ?? 0),
        );
        break;
    }
    return list;
  }
}
