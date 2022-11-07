import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/flight_detail.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SegmentCard extends StatelessWidget {
  final InboundOutboundSegment segment;
  final bool isDeparture;

  const SegmentCard(
      {Key? key, required this.segment, required this.isDeparture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isVerify = context.watch<BookingCubit>().state.isVerify;
    final selected = isDeparture
        ? context.watch<BookingCubit>().state.selectedDeparture
        : context.watch<BookingCubit>().state.selectedReturn;
    return Container(
      width: 500.w,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: () {
          if (isDeparture) {
            context.read<BookingCubit>().selectDeparture(segment);
          } else {
            context.read<BookingCubit>().selectReturn(segment);
          }
        },
        child: AppCard(
          isHighlighted: selected == segment && !isVerify,
          edgeInsets: EdgeInsets.zero,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
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
                        Visibility(
                          visible: segment.discountPCT != null &&
                              segment.discountPCT! > 0,
                          replacement: Image.asset(
                            "assets/images/icons/iconFlight.png",
                            width: 32,
                            height: 32,
                          ),
                          child: CircleAvatar(
                            backgroundColor: Styles.kPrimaryColor,
                            child: Text(
                              "-${segment.discountPCT}%",
                              style: kTinyHeavy.copyWith(color: Colors.white),
                            ),
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
                    kVerticalSpacer,
                    const AppDividerWidget(),
                    Transform.translate(
                      offset: const Offset(0, 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Direct flight - ${NumberUtils.getTimeString(segment.segmentDetail?.flightTime)} ",
                                  style: kSmallMedium,
                                ),
                              ],
                            ),
                          ),
                          kHorizontalSpacer,
                          Expanded(
                            flex: 5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "from",
                                  style: kTinyHeavy,
                                ),
                                MoneyWidget(amount: segment.getTotalPrice),
                                Visibility(
                                  visible: segment.discountPCT != null &&
                                      segment.discountPCT! > 0,
                                  child: Text(
                                    "RM ${segment.beforeDiscountTotalAmt}",
                                    style: kSmallRegular.copyWith(
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    FlightDetail(isDeparture: isDeparture, segment: segment),
                    kVerticalSpacerSmall,
                  ],
                ),
              ),
              Visibility(
                visible: isVerify,
                replacement: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(15)),
                    ),
                  ),
                  onPressed: () {
                    if (isDeparture) {
                      context.read<BookingCubit>().selectDeparture(segment);
                    } else {
                      context.read<BookingCubit>().selectReturn(segment);
                    }
                  },
                  child: const Text("Select"),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                  child: OutlinedButton(
                    onPressed: () {
                      context.read<BookingCubit>().changeFlight();
                    },
                    child: const Text("Change Flight"),
                  ),
                ),
              ),
            ],
          ),
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
          style: kSmallMedium.copyWith(color: Styles.kSubTextColor),
        ),
        Text(
          AppDateUtils.formatJM(
            isDeparture
                ? segmentDetail?.departureDate
                : segmentDetail?.arrivalDate,
          ),
          style: kLargeHeavy,
        ),
        Text(
          "${isDeparture ? segmentDetail?.origin : segmentDetail?.destination} - ${isDeparture ? 'Departure' : 'Arrival'}",
          style: kSmallMedium.copyWith(color: Styles.kSubTextColor),
        )
      ],
    );
  }
}
