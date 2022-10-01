import 'package:app/data/responses/flight_response.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SegmentCard extends StatelessWidget {
  final InboundOutboundSegment segment;

  const SegmentCard({Key? key, required this.segment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.w,
      margin: EdgeInsets.symmetric(vertical: 12),
      child: AppCard(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SegmentHeader(
                    segmentDetail: segment.segmentDetail,
                    isDeparture: true,
                  ),
                ),
                kHorizontalSpacer,
                Expanded(
                  child: SegmentHeader(
                    segmentDetail: segment.segmentDetail,
                    isDeparture: false,
                  ),
                ),
              ],
            ),
            kVerticalSpacerBig,
            Row(
              children: [
                Expanded(
                  child: Text("Direct flight - ${NumberUtils.getTimeString(segment.segmentDetail?.flightTime)}  travel"),
                ),
                kHorizontalSpacer,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("from"),
                      Text("MYR ${NumberUtils.formatNumber(segment.adultPricePerPax?.toDouble())}", style: kLargeSemiBold.copyWith(color: Styles.kPrimaryColor),),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SegmentHeader extends StatelessWidget {
  final SegmentDetail? segmentDetail;
  final bool isDeparture;

  const SegmentHeader({
    Key? key,
    this.segmentDetail,
    required this.isDeparture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppDateUtils.formatHalfDate(isDeparture
              ? segmentDetail?.departureDate
              : segmentDetail?.arrivalDate),
        ),
        kVerticalSpacerMini,
        Text(
          AppDateUtils.formatJM(isDeparture
              ? segmentDetail?.departureDate
              : segmentDetail?.arrivalDate),
        ),
        kVerticalSpacerMini,
        Text(
            "${isDeparture ? segmentDetail?.origin : segmentDetail?.destination} - ${isDeparture ? 'Departure' : 'Arrival'}")
      ],
    );
  }
}
