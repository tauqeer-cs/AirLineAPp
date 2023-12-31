import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/pages/checkout/pages/payment/ui/summary/fee_and_taxes.dart';
import 'package:app/pages/checkout/ui/cubit/is_payment_page_cubit.dart';
import 'package:app/pages/search_result/bloc/summary_container_cubit.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/utils/string_utils.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../theme/theme.dart';
import 'fee_expanded/fee_and_taxes.dart';

class FlightDetail extends StatefulWidget {
  final bool isDeparture;
  final InboundOutboundSegment segment;
  final bool showFees;
  final bool showDetailPayment;
  final String? currency;

  const FlightDetail({
    Key? key,
    required this.isDeparture,
    required this.segment,
    this.showFees = false,
    this.currency,
    this.showDetailPayment = true,
  }) : super(key: key);

  @override
  State<FlightDetail> createState() => _FlightDetailState();
}

class _FlightDetailState extends State<FlightDetail> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final detail = widget.segment.segmentDetail;
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final locale = context.locale.toString();

    return BlocListener<BookingCubit, BookingState>(
      listenWhen: (prev, curr) {
        if (prev.selectedReturn != curr.selectedReturn) return true;
        if (prev.selectedDeparture != curr.selectedDeparture) return true;
        return false;
      },
      listener: (context, state) {
        setState(() {
          isExpand = false;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kVerticalSpacerMini,
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: widget.showFees ? 0 : 0.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  isExpand = !isExpand;
                });
                context
                    .read<SummaryContainerCubit>()
                    .changeVisibility(!isExpand);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: widget.showDetailPayment && !widget.showFees
                            ? 15.0
                            : 0),
                    child: Text(
                      "details".tr(),
                      style: kSmallRegular.copyWith(
                          color: const Color.fromRGBO(243, 110, 56, 1)),
                    ),
                  ),
                  kHorizontalSpacerMini,
                  Icon(
                    isExpand
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: const Color.fromRGBO(243, 110, 56, 1),
                  ),
                ],
              ),
            ),
          ),
          kVerticalSpacerMini,

          ExpandedSection(
            expand: isExpand,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.showFees ? 0 : 15.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: BorderedLeftContainer(
                          title: "${'flights'.tr()}:",
                          content: '${detail?.carrierCode}${detail?.flightNum}',
                        ),
                      ),



                    ],
                  ),
                ),
                kVerticalSpacer,

                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widget.showFees ? 0 : 15.0),
                  child: BorderedLeftContainer(
                    title: "${"duration".tr()}:",
                    content: NumberUtils.getTimeString(detail?.flightTime),
                  ),
                ),
                kVerticalSpacer,

                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widget.showFees ? 0 : 15.0),
                  child: BorderedLeftContainer(
                    title: "${'departure'.tr()}:",
                    content:
                        "${AppDateUtils.formatFullDateWithTime(detail?.departureDate,locale: locale)}\n${widget.isDeparture ? filter?.origin?.name?.camelCase() : filter?.destination?.name?.camelCase()}",
                  ),
                ),
                kVerticalSpacer,
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: widget.showFees ? 0 : 15.0),
                  child: BorderedLeftContainer(
                    title: "${"arrival".tr()}:",
                    content:
                        "${AppDateUtils.formatFullDateWithTime(detail?.arrivalDate,locale: locale)}\n${widget.isDeparture ? filter?.destination?.name?.camelCase() : filter?.origin?.name?.camelCase()}",
                  ),
                ),
                kVerticalSpacer,
               Visibility(
                  visible: widget.showDetailPayment,
                  child: BlocProvider(
                    create: (context) => IsPaymentPageCubit(true),
                    child: widget.showFees
                        ? FeeAndTaxesPayment(isDeparture: widget.isDeparture,currency: widget.currency,)
                        : Container(
                            padding: const EdgeInsets.all(12),
                            color: const Color.fromRGBO(229, 229, 229, 0.53),
                            child:    FeeAndTaxes(isDeparture: widget.isDeparture),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
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
          Text(content, style: kLargeRegular.copyWith(color: Styles.kBlack)),
        ],
      ),
    );
  }
}
