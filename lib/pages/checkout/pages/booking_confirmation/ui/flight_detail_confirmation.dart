import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/models/confirmation_model.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/flight_detail.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlightDetailConfirmation extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dateTitle;
  final bool isDeparture;
  final Bound bound;

  const FlightDetailConfirmation({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.dateTitle,
    required this.isDeparture,
    required this.bound,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kVerticalSpacer,
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
                text: '\n$dateTitle ',
                style: kMediumMedium.copyWith(color: Styles.kTextColor),
              ),
            ],
          ),
          textAlign: TextAlign.left,
        ),
        kVerticalSpacer,
        FlightDetailFooter(isDeparture: isDeparture, bound: bound),
      ],
    );
  }
}

class FlightDetailFooter extends StatefulWidget {
  final bool isDeparture;
  final Bound bound;
  const FlightDetailFooter({Key? key, required this.isDeparture, required this.bound}) : super(key: key);

  @override
  State<FlightDetailFooter> createState() => _FlightDetailFooterState();
}

class _FlightDetailFooterState extends State<FlightDetailFooter> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){
            setState(() {
              isExpand = !isExpand;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Details",
                style: kLargeMedium.copyWith(color: Colors.orange),
              ),
              kHorizontalSpacerSmall,
              Icon(
                isExpand ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              ),
            ],
          ),
        ),
        ExpandedSection(
          expand: isExpand,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kVerticalSpacer,
              AppDividerWidget(color: Styles.kTextColor),
              kVerticalSpacer,
              BorderedLeftContainer(
                title: "Flight:", content: '${widget.bound.operatingCode}${widget.bound.operatingNumber}',
              ),
              kVerticalSpacer,
              BorderedLeftContainer(
                title: "Cabin:", content: 'Economy',
              ),
              kVerticalSpacer,
              BorderedLeftContainer(
                title: "Duration:", content: '${NumberUtils.getTimeString(widget.bound.elapsedTime)}',
              ),
              kVerticalSpacer,
              BorderedLeftContainer(
                title: "Aircraft:", content: '${widget.bound.aircraftDescription}',
              ),
              kVerticalSpacer,
              BorderedLeftContainer(
                title: "Departs:", content: "${AppDateUtils.formatFullDateWithTime(widget.bound.departureDateTime)}\n${widget.bound.departureAirportLocationName}",
              ),
              kVerticalSpacer,
              BorderedLeftContainer(
                title: "Arrive:", content: "${AppDateUtils.formatFullDateWithTime(widget.bound.arrivalDateTime)}\n${widget.bound.arrivalAirportLocationName}",
              ),
            ],
          ),
        ),
      ],
    );
  }
}