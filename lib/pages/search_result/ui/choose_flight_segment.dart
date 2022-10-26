import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/pages/search_result/ui/segment_card.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseFlightSegment extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dateTitle;
  final List<InboundOutboundSegment> segments;
  final bool isDeparture;

  const ChooseFlightSegment({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.dateTitle,
    required this.segments,
    required this.isDeparture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kVerticalSpacer,
        Transform.translate(
          offset: Offset(-12,0),
          child: Container(
            width: 155.w,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color.fromRGBO(237, 242, 244,1 ),
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(50),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: kHugeHeavy),
                Text(subtitle, style: kLargeRegular),
              ],
            ),
          ),
        ),
        kVerticalSpacerBig,
        Text(dateTitle, style: kGiantHeavy),
        kVerticalSpacer,
        Text(
          "Prices are based on an ${filter?.numberPerson.toBeautify()}. Fares are non-refundable, limited changes are permitted, and charges may apply. ",
          style: kMediumMedium,
        ),
        Column(
          children: segments
              .map((e) => SegmentCard(segment: e, isDeparture: isDeparture))
              .toList(),
        ),
      ],
    );
  }
}
