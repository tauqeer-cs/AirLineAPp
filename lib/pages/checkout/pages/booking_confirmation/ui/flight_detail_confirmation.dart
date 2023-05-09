import 'package:app/models/confirmation_model.dart';
import 'package:app/models/fare_summary_in_out.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/fare_detail.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/flight_detail.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class FlightDetailConfirmation extends StatefulWidget {
  final String title;
  final String subtitle;
  final String dateTitle;
  final bool isDeparture;
  final Bound bound;
  final BoundBookingSummary bookingSummary;

  const FlightDetailConfirmation({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.dateTitle,
    required this.isDeparture,
    required this.bound,
    required this.bookingSummary,
  }) : super(key: key);

  @override
  State<FlightDetailConfirmation> createState() =>
      _FlightDetailConfirmationState();
}

class _FlightDetailConfirmationState extends State<FlightDetailConfirmation> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,
            style: kHugeHeavy.copyWith(color: Styles.kPrimaryColor)),
        kVerticalSpacerSmall,
        InkWell(
          onTap: () {
            setState(() {
              isExpand = !isExpand;
            });
          },
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.subtitle} -",
                      style: kLargeHeavy.copyWith(color: Styles.kTextColor),
                    ),
                  ],
                ),
              ),
              Icon(
                isExpand ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              ),
            ],
          ),
        ),
        Text(
          widget.dateTitle,
          style: kLargeMedium.copyWith(color: Styles.kTextColor),
        ),
        ExpandedSection(
          expand: isExpand,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kVerticalSpacer,
              const AppDividerWidget(),
              kVerticalSpacer,
              Row(
                children: [
                  Expanded(
                    child: BorderedLeftContainer(
                      title: "${'flight'.tr()}:",
                      content:
                      '${widget.bound.airlineCode}${widget.bound.flightNumber}',
                    ),
                  ),
                   Expanded(
                    child: BorderedLeftContainer(
                      title: "flightSection.cabin".tr(),
                      content: 'flightSection.economyClass'.tr(),
                    ),
                  ),
                ],
              ),
              kVerticalSpacer,
              Row(
                children: [
                  Expanded(
                    child: BorderedLeftContainer(
                      title: "flightResult.duration".tr(),
                      content:
                      NumberUtils.getTimeString(widget.bound.elapsedTime),
                    ),
                  ),
                  Expanded(
                    child: BorderedLeftContainer(
                      title: "flightResult.aircraft".tr(),
                      content: '${widget.bound.aircraftDescription}',
                    ),
                  ),
                ],
              ),
              kVerticalSpacer,
              BorderedLeftContainer(
                title: 'flightResult.departs'.tr(),
                content:
                "${AppDateUtils.formatFullDateWithTime(widget.bound.departureDateTime,locale: locale)}\n${widget.bound.departureAirportLocationName}",
              ),
              kVerticalSpacer,
              BorderedLeftContainer(
                title: "flightResult.arrive".tr(),
                content:
                "${AppDateUtils.formatFullDateWithTime(widget.bound.arrivalDateTime,locale: locale)}\n${widget.bound.arrivalAirportLocationName}",
              ),
              kVerticalSpacer,
              FareDetail(
                bookingSummary: widget.bookingSummary,
                isDeparture: widget.isDeparture,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class FlightDetailFooter extends StatefulWidget {
  final bool isDeparture;
  final Bound bound;

  const FlightDetailFooter(
      {Key? key, required this.isDeparture, required this.bound})
      : super(key: key);

  @override
  State<FlightDetailFooter> createState() => _FlightDetailFooterState();
}

class _FlightDetailFooterState extends State<FlightDetailFooter> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isExpand = !isExpand;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "details".tr(),
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
              const AppDividerWidget(),
              kVerticalSpacer,
              Row(
                children: [
                  Expanded(
                    child: BorderedLeftContainer(
                      title: "Flight:",
                      content:
                      '${widget.bound.operatingCode}${widget.bound.operatingNumber}',
                    ),
                  ),
                  const Expanded(
                    child: BorderedLeftContainer(
                      title: "Cabin:",
                      content: 'Economy',
                    ),
                  ),
                ],
              ),
              kVerticalSpacer,
              Row(
                children: [
                  Expanded(
                    child: BorderedLeftContainer(
                      title: "${"duration".tr()}:",
                      content:
                      NumberUtils.getTimeString(widget.bound.elapsedTime),
                    ),
                  ),
                  Expanded(
                    child: BorderedLeftContainer(
                      title: "${"aircraft".tr()}:",
                      content: '${widget.bound.aircraftDescription}',
                    ),
                  ),
                ],
              ),
              kVerticalSpacer,
              BorderedLeftContainer(
                title: "Departs:",
                content:
                "${AppDateUtils.formatFullDateWithTime(widget.bound.departureDateTime,locale: locale)}\n${widget.bound.departureAirportLocationName}",
              ),
              kVerticalSpacer,
              BorderedLeftContainer(
                title: "${"arrive".tr()}:",
                content:
                "${AppDateUtils.formatFullDateWithTime(widget.bound.arrivalDateTime,locale: locale)}\n${widget.bound.arrivalAirportLocationName}",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
