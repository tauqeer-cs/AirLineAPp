import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/pages/checkout/ui/baggage_fee_detail.dart';
import 'package:app/pages/checkout/ui/cubit/is_payment_page_cubit.dart';
import 'package:app/pages/checkout/ui/fee_and_taxes.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/utils/string_utils.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../theme/theme.dart';

class FlightDetail extends StatefulWidget {
  final bool isDeparture;
  final InboundOutboundSegment segment;
  final bool showFees;

  const FlightDetail({
    Key? key,
    required this.isDeparture,
    required this.segment,
    this.showFees = false,
  }) : super(key: key);

  @override
  State<FlightDetail> createState() => _FlightDetailState();
}

class _FlightDetailState extends State<FlightDetail> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final detail = widget.segment.segmentDetail;
    final info = widget.segment.fareTypeWithTaxDetails?.firstOrNull
        ?.fareInfoWithTaxDetails?.firstOrNull;
    final filter = context.watch<SearchFlightCubit>().state.filterState;

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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Details",
                style: kSmallRegular.copyWith(
                    color: Color.fromRGBO(243, 110, 56, 1)),
              ),
              kHorizontalSpacerMini,
              Icon(
                isExpand ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Color.fromRGBO(243, 110, 56, 1),
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
              Row(
                children: [
                  Expanded(
                    child: BorderedLeftContainer(
                      title: "Flight:",
                      content: '${detail?.carrierCode}${detail?.flightNum}',
                    ),
                  ),
                  Expanded(
                    child: BorderedLeftContainer(
                      title: "Aircraft:",
                      content: '${detail?.aircraftType}',
                    ),
                  ),
                ],
              ),
              kVerticalSpacer,
              // BorderedLeftContainer(
              //   title: "Cabin:", content: '${info?.cabin}',
              // ),
              // kVerticalSpacer,
              BorderedLeftContainer(
                title: "Duration:",
                content: '${NumberUtils.getTimeString(detail?.flightTime)}',
              ),
              kVerticalSpacer,

              BorderedLeftContainer(
                title: "DEP:",
                content:
                    "${AppDateUtils.formatFullDateWithTime(detail?.departureDate)}\n${widget.isDeparture ? filter?.origin?.name?.camelCase() : filter?.destination?.name?.camelCase()}",
              ),
              kVerticalSpacer,
              BorderedLeftContainer(
                title: "ARR:",
                content:
                    "${AppDateUtils.formatFullDateWithTime(detail?.arrivalDate)}\n${widget.isDeparture ? filter?.destination?.name?.camelCase() : filter?.origin?.name?.camelCase()}",
              ),
              Visibility(
                visible: widget.showFees,
                child: BlocProvider(
                  create: (context) => IsPaymentPageCubit(true),
                  child: FeeAndTaxes(isDeparture: widget.isDeparture),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class BorderedLeftContainer extends StatelessWidget {
  final String title;
  final String content;

  const BorderedLeftContainer(
      {Key? key, required this.title, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Styles.kPrimaryColor, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: kLargeHeavy),
          kVerticalSpacerSmall,
          Text(content, style: kLargeRegular),
        ],
      ),
    );
  }
}
