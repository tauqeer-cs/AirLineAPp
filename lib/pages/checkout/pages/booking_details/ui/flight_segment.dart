import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/flight_detail.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlightSegment extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dateTitle;
  final List<InboundOutboundSegment> segments;
  final bool isDeparture;

  const FlightSegment({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.dateTitle,
    required this.segments,
    required this.isDeparture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.w,
      margin: EdgeInsets.symmetric(vertical: 12),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: kHugeSemiBold.copyWith(color: Styles.kPrimaryColor)),
            kVerticalSpacer,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '$subtitle - ',
                    style: kMediumHeavy.copyWith(color: Styles.kTextColor),
                  ),
                  TextSpan(
                    text: ' $dateTitle ',
                    style: kMediumMedium.copyWith(color: Styles.kTextColor),
                  ),
                ],
              ),
              textAlign: TextAlign.left,
            ),
            kVerticalSpacer,
            FlightDetail(isDeparture: isDeparture, segment: segments.first),
          ],
        ),
      ),
    );
  }
}
