import 'package:app/data/responses/flight_response.dart';
import 'package:app/pages/search_result/ui/segment_card.dart';
import 'package:app/pages/search_result/ui/sort_sheet.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                      "Sort by",
                      style: kSmallRegular.copyWith(color: Styles.kBorderColor),
                    ),
                    Text(
                      selectedSort.toString(),
                      style: kSmallHeavy,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        kVerticalSpacerBig,
        Text(widget.dateTitle,
            style: kLargeHeavy.copyWith(color: Styles.kSubTextColor)),
        sortedSegment.isEmpty
            ? const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "No flight available for this date",
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
                          showVisa :  widget.visaPromo,
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
      builder: (_) =>
          SortSheet(defaultValue: selectedSort, onChanged: onChangeSort),
      constraints: BoxConstraints(
        maxWidth: 0.9.sw,
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
