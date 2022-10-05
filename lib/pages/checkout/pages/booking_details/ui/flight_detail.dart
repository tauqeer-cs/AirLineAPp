import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/ui/baggage_fee_detail.dart';
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

  const FlightDetail({Key? key, required this.isDeparture}) : super(key: key);

  @override
  State<FlightDetail> createState() => _FlightDetailState();
}

class _FlightDetailState extends State<FlightDetail> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final segment = widget.isDeparture
        ? context.watch<BookingCubit>().state.selectedDeparture
        : context.watch<BookingCubit>().state.selectedReturn;
    final detail = segment?.segmentDetail;
    final info = segment?.fareTypeWithTaxDetails?.firstOrNull
        ?.fareInfoWithTaxDetails?.firstOrNull;
    final filter = context.watch<SearchFlightCubit>().state.filterState;

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
                style: kLargeMedium,
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
                title: "Flight:", content: '${detail?.carrierCode}${detail?.flightNum}',
              ),
              kVerticalSpacer,
              BorderedLeftContainer(
                title: "Cabin:", content: '${info?.cabin}',
              ),
              kVerticalSpacer,
              BorderedLeftContainer(
                title: "Duration:", content: '${NumberUtils.getTimeString(detail?.flightTime)}',
              ),
              kVerticalSpacer,
              BorderedLeftContainer(
                title: "Aircraft:", content: '${detail?.aircraftType}',
              ),
              kVerticalSpacer,
              BorderedLeftContainer(
                title: "Departs:", content: "${AppDateUtils.formatFullDateWithTime(detail?.departureDate)}\n${widget.isDeparture ? filter?.origin?.name?.camelCase() : filter?.destination?.name?.camelCase()}",
              ),
              kVerticalSpacer,
              BorderedLeftContainer(
                title: "Arrive:", content: "${AppDateUtils.formatFullDateWithTime(detail?.arrivalDate)}\n${widget.isDeparture ? filter?.destination?.name?.camelCase() : filter?.origin?.name?.camelCase()}",
              ),
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
          left: BorderSide(color: Styles.kPrimaryColor, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: kHugeSemiBold),
          kVerticalSpacerSmall,
          Text(content, style: kMediumMedium),
        ],
      ),
    );
  }
}
