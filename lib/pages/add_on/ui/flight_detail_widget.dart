import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlightDetailWidget extends StatelessWidget {
  final bool isDeparture;
  const FlightDetailWidget({
    Key? key,
    this.isDeparture = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchFlightCubit, SearchFlightState>(
      builder: (context, state) {
        return blocBuilderWrapper(
          blocState: state.blocState,
          finishedBuilder: Padding(
            padding: kPageHorizontalPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add-On",
                  style: kHugeSemiBold.copyWith(color: Styles.kDarkBgColor),
                ),
                kVerticalSpacer,
                flightDetailContainer(state),
                kVerticalSpacer,
                flightDate(state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget flightDetailContainer(SearchFlightState state) {
    return Transform.translate(
      offset: const Offset(-12, 0),
      child: Container(
        width: 155.w,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Styles.kDividerColor,
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(50),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isDeparture ? "DEP" : "RET", style: kHugeHeavy),
            Text(
                isDeparture
                    ? state.filterState?.beautifyShort ?? ""
                    : state.filterState?.beautifyReverseShort ?? "",
                style: kLargeRegular),
          ],
        ),
      ),
    );
  }

  Widget flightDate(SearchFlightState state) {
    return Text(
      AppDateUtils.formatHalfDateHalfMonth(isDeparture
          ? state.filterState?.departDate
          : state.filterState?.returnDate),
      style: kMediumHeavy.copyWith(color: Styles.kSubTextColor),
    );
  }
}
