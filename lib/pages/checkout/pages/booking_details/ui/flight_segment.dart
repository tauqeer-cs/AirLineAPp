import 'package:app/data/responses/flight_response.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/flight_detail.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlightSegment extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dateTitle;
  final List<InboundOutboundSegment> segments;
  final bool isDeparture;
  final bool showFees;

  const FlightSegment({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.dateTitle,
    required this.segments,
    required this.isDeparture,
    this.showFees = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.w,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: AppCard(
        edgeInsets: showFees ? null : EdgeInsets.zero,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(showFees ? 0 : 15),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(title, style: kHugeSemiBold.copyWith(color: Styles.kPrimaryColor)),
                        // kVerticalSpacer,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: subtitle,
                                style: kLargeHeavy.copyWith(
                                    color: Styles.kTextColor),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.left,
                        ),
                        kVerticalSpacerMini,
                        Text(
                          dateTitle,
                          style: kLargeRegular,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    title,
                    style: kGiantHeavy.copyWith(
                        color: Styles.kDisabledButton, fontSize: 32),
                  )
                ],
              ),
            ),
            kVerticalSpacerSmall,
            FlightDetail(
              isDeparture: isDeparture,
              segment: segments.first,
              showFees: showFees,
            ),
          ],
        ),
      ),
    );
  }
}
