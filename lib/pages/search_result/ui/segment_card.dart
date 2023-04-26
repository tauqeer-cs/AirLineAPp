import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/flight_detail.dart';
import 'package:app/pages/search_result/bloc/summary_container_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/utils/user_insider.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../blocs/manage_booking/manage_booking_cubit.dart';

class SegmentCard extends StatelessWidget {
  final InboundOutboundSegment segment;
  final bool isDeparture;
  final bool changeFlight;

  final bool showVisa;

  const SegmentCard(
      {Key? key,
      required this.segment,
      required this.isDeparture,
      required this.showVisa,
      this.changeFlight = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isVerify = context.watch<BookingCubit>().state.isVerify;
    var selected = isDeparture
        ? context.watch<BookingCubit>().state.selectedDeparture
        : context.watch<BookingCubit>().state.selectedReturn;
    ManageBookingCubit? bloc;

    if (changeFlight) {
      bloc = context.watch<ManageBookingCubit>();
      selected = null;
      if (isDeparture) {
        if (segment.lfid == bloc.state.selectedDepartureFlight?.lfid) {
          selected = bloc.state.selectedDepartureFlight;
        }
      } else {
        if (segment.lfid == bloc.state.selectedReturnFlight?.lfid) {
          selected = bloc.state.selectedReturnFlight;
        }
      }
    }
    return Container(
      width: 500.w,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: InkWell(
        onTap: () {
          if (isDeparture) {
            if (changeFlight) {
              bloc?.setDepartureFlight(segment);
            } else {
              context.read<BookingCubit>().selectDeparture(segment);
            }
          } else {
            if (changeFlight) {
              bloc?.setReturnFlight(segment);
            } else {
              context.read<BookingCubit>().selectReturn(segment);
            }
          }
        },
        child: AppCard(
          isHighlighted: isHighlighted(selected, isVerify),
          edgeInsets: EdgeInsets.zero,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SegmentHeader(
                            segmentDetail: segment.segmentDetail,
                            isDeparture: true,
                          ),
                        ),
                        kHorizontalSpacer,
                        if (showVisa) ...[
                          ClipOval(
                            child: Image.asset(
                              "assets/images/icons/iconFlight.png",
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ] else ...[
                          Visibility(
                            visible: segment.discountPCT != null &&
                                segment.discountPCT! > 0,
                            replacement: Image.asset(
                              "assets/images/icons/iconFlight.png",
                              width: 32,
                              height: 32,
                            ),
                            child: buildCircleAvatar(),
                          ),
                        ],
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
                    if (showVisa) ...[
                      Transform.translate(
                        offset: const Offset(0, 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Direct flight\n${NumberUtils.getTimeString(segment.segmentDetail?.flightTime)} ",
                                style: kSmallMedium,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: ClipOval(
                                child: Image.asset(
                                  "assets/images/icons/icoVisa.png",
                                  width: 32,
                                  height: 32,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "from".tr(),
                                  style: kTinyHeavy,
                                ),
                                MoneyWidget(
                                    amount: changeFlight
                                        ? segment.changeFlightAmountToShow
                                        : segment
                                            .totalSegmentFareAmtWithInfantSSR,
                                    isDense: true,
                                    showPlus: changeFlight),
                                Visibility(
                                  visible: segment.discountPCT != null &&
                                      segment.discountPCT! > 0,
                                  child: Text(
                                    "MYR ${segment.beforeDiscountTotalAmt}",
                                    style: kSmallRegular.copyWith(
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      Transform.translate(
                        offset: const Offset(0, 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    'flightSummary.directFlight'.tr() + " ${NumberUtils.getTimeString(segment.segmentDetail?.flightTime)} ",
                                    style: kSmallMedium,
                                  ),
                                ),
                              ),
                            ),
                            kHorizontalSpacer,
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "from".tr(),
                                    style: kTinyHeavy,
                                  ),
                                  MoneyWidget(
                                      amount: changeFlight
                                          ? segment.changeFlightAmountToShow
                                          : segment
                                              .totalSegmentFareAmtWithInfantSSR,
                                      isDense: true,
                                      showPlus: changeFlight),
                                  Visibility(
                                    visible: segment.discountPCT != null &&
                                        segment.discountPCT! > 0,
                                    child: Text(
                                      "MYR ${segment.beforeDiscountTotalAmt}",
                                      style: kSmallRegular.copyWith(
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    FlightDetail(
                      isDeparture: isDeparture,
                      segment: segment,
                      showFees: false,
                      showDetailPayment: false,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: selected != null,
                replacement: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(15)),
                    ),
                  ),
                  onPressed: () {
                    if (!changeFlight) {
                      context
                          .read<SummaryContainerCubit>()
                          .changeVisibility(true);
                    }

                    if (isDeparture) {
                      UserInsider.of(context).registerEventWithParameterProduct(
                        InsiderConstants.flightSelected,
                        aircraft: segment.segmentDetail?.aircraftDescription,
                        flightNumber: segment.segmentDetail?.flightNum,
                      );
                      if (changeFlight) {
                        bloc?.setDepartureFlight(segment);
                      } else {
                        context.read<BookingCubit>().selectDeparture(segment);
                      }
                    } else {
                      UserInsider.of(context).registerEventWithParameterProduct(
                        InsiderConstants.flightSelected,
                        aircraft: segment.segmentDetail?.aircraftDescription,
                        flightNumber: segment.segmentDetail?.flightNum,
                      );
                      if (changeFlight) {
                        bloc?.setReturnFlight(segment);
                      } else {
                        context.read<BookingCubit>().selectReturn(segment);
                      }
                    }
                  },
                  child: Text('flightSummary.select'.tr()),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                  child: OutlinedButton(
                    onPressed: () {
                      //context.read<BookingCubit>().changeFlight();

                      if (changeFlight) {
                        if (isDeparture) {
                          bloc?.removeDepartureFlight(segment);
                        } else {
                          bloc?.removeReturnFlight(segment);
                        }
                        return;
                      }
                      if (isDeparture) {
                        context.read<BookingCubit>().removeDeparture();
                      } else {
                        context.read<BookingCubit>().removeReturn();
                      }

                      context
                          .read<SummaryContainerCubit>()
                          .changeVisibility(true);
                      //context.router.pop();
                    },
                    child: Text("changeFlight".tr()),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCircleAvatar() {
    return CircleAvatar(
      backgroundColor: Styles.kPrimaryColor,
      child: Text(
        "-${segment.discountPCT}%",
        style: kTinyHeavy.copyWith(color: Colors.white),
      ),
    );
  }

  bool isHighlighted(InboundOutboundSegment? selected, bool isVerify) {
    if (changeFlight) {
      return selected == segment;
    }
    return selected == segment && !isVerify && false;
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
      mainAxisAlignment: MainAxisAlignment.start,
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
