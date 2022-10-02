import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/data/responses/flight_response.dart';
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
      margin: EdgeInsets.symmetric(vertical: 12),
      child: GestureDetector(
        onTap: () {
          if (isDeparture) {
            context.read<BookingCubit>().selectDeparture(segment);
          } else {
            context.read<BookingCubit>().selectReturn(segment);
          }
        },
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
              kVerticalSpacer,
              Visibility(
                visible: isVerify,
                child: AppDividerWidget(),
              ),
              kVerticalSpacer,
              Row(
                children: [
                  Expanded(
                    child: Text(
                        "Direct flight - ${NumberUtils.getTimeString(segment.segmentDetail?.flightTime)}  travel"),
                  ),
                  kHorizontalSpacer,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("from"),
                        MoneyWidget(amount: segment.getTotalPrice),
                      ],
                    ),
                  ),
                ],
              ),
              kVerticalSpacerBig,
              Visibility(
                visible: isVerify,
                replacement: Radio<InboundOutboundSegment>(
                  value: segment,
                  groupValue: selected,
                  onChanged: (value) {
                    if (value == null) return;
                    if (isDeparture) {
                      context.read<BookingCubit>().selectDeparture(value);
                    } else {
                      context.read<BookingCubit>().selectReturn(value);
                    }
                  },
                ),
                child: ElevatedButton(
                  onPressed: () {
                    context.read<BookingCubit>().changeFlight();
                  },
                  child: Text("Change Flight"),
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
