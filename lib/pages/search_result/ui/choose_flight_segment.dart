import 'package:app/data/responses/flight_response.dart';
import 'package:app/pages/search_result/ui/segment_card.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/typography.dart';
import 'package:flutter/material.dart';

class ChooseFlightSegment extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dateTitle;
  final List<InboundOutboundSegment> segments;

  const ChooseFlightSegment({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.dateTitle,
    required this.segments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kVerticalSpacer,
        Text(title, style: kGiantHeavy),
        kVerticalSpacer,
        Text(subtitle, style: kMediumMedium),
        kVerticalSpacerBig,
        Text(dateTitle, style: kGiantHeavy),
        kVerticalSpacer,
        Text(
          "Prices are based on an (1) adult passenger. Fares are non-refundable, limited changes are permitted, and charges may apply. ",
          style: kMediumMedium,
        ),
        Column(
          children: segments.map((e) => SegmentCard(segment: e)).toList(),
        ),
      ],
    );
  }
}
