import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/models/cms_flight.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeatsLegend extends StatelessWidget {
  const SeatsLegend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingState = context.watch<BookingCubit>().state;
    final seatsSSR = bookingState.verifyResponse?.flightSSR?.seatGroup;
    final isDeparture = context.watch<IsDepartureCubit>().state;
    final availableType = isDeparture ? seatsSSR?.outbound : seatsSSR?.inbound;
    final mapColor = isDeparture
        ? bookingState.departureColorMapping
        : bookingState.returnColorMapping;
    final seatNotice = context.watch<CmsSsrCubit>().state.seatNotice;

    print("available type ${availableType?.length}");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 5,
          children: (availableType ?? []).map(
            (e) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: (mapColor ?? {})[e.serviceID],
                  ),
                  kHorizontalSpacerMini,
                  Text(e.description ?? "")
                ],
              );
            },
          ).toList(),
        ),
        kVerticalSpacer,
        ContainerNotice(sharedNotice: seatNotice),
      ],
    );
  }
}

class ContainerNotice extends StatelessWidget {
  const ContainerNotice({
    Key? key,
    required this.sharedNotice,
  }) : super(key: key);

  final SharedSetting? sharedNotice;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: sharedNotice?.content?.isNotEmpty ?? false,
      child: Container(
        padding: EdgeInsets.all(8),
        width: 500.w,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(sharedNotice?.content ?? ""),
      ),
    );
  }
}
