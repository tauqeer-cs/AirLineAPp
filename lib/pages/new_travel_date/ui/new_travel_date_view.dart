import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:paged_vertical_calendar/paged_vertical_calendar.dart';
import 'package:paged_vertical_calendar/utils/date_utils.dart';

import '../../../app/app_router.dart';
import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../utils/date_utils.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_loading_screen.dart';


class SelectNewTravelDatesView extends StatefulWidget {
  const SelectNewTravelDatesView({Key? key}) : super(key: key);

  @override
  State<SelectNewTravelDatesView> createState() =>
      _SelectNewTravelDatesViewState();
}

class _SelectNewTravelDatesViewState extends State<SelectNewTravelDatesView> {
  bool isInRange(DateTime date, DateTime? start, DateTime? end) {
    // if start is null, no date has been selected yet
    if (start == null) return false;
    // if only end is null only the start should be highlighted
    if (end == null) return date == start;
    return ((date == start || date.isAfter(start)) &&
        (date == end || date.isBefore(end)));
  }

  Widget weekText(String text) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: kMediumSemiBold,
        ),
      ),
    );
  }

  bool loadDate = false;

  @override
  Widget build(BuildContext context) {
    //final filterCubit = context.watch<FilterCubit>();
    ManageBookingCubit bloc = context.watch<ManageBookingCubit>();

    final locale = context.locale.toString();

    var state = bloc.state;

    var departDate = bloc.state.manageBookingResponse
        ?.currentStartDate; //filterCubit.state.departDaconst te;
    var returnDate = bloc.state.manageBookingResponse
        ?.currentEndDate; //filterCubit.state.returnDate;
    bool isRoundTrip = bloc.state.manageBookingResponse?.isTwoWay ??
        false; // filterCubit.state.flightType == FlightType.round;

    if (state.checkedDeparture && state.checkReturn) {
    } else if (state.checkedDeparture) {
      isRoundTrip = false;
      returnDate = null;
    } else if (state.checkReturn) {
      isRoundTrip = false;
      departDate = returnDate;
      returnDate = null;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                state.manageBookingResponse?.result?.departureAirportName ?? '',
                style: k18SemiBold.copyWith(
                  color: Styles.kPrimaryColor,
                ),
                overflow: TextOverflow.visible,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Icon(
                Icons.arrow_forward,
                color: Styles.kPrimaryColor,
              ),
            ),
            Expanded(
              child: Text(
                state.manageBookingResponse?.result?.arrivalAirportName ?? '',
                style: k18SemiBold.copyWith(
                  color: Styles.kPrimaryColor,
                ),
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                Column(
                  children: [
                    kVerticalSpacerSmall,
                    AppCardCalendar(
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: AutoSizeText(
                               "${'departureShort'.tr()} ${AppDateUtils.formatDateWithoutLocale(departDate,locale:locale)}",
                                style: departDate == null
                                    ? kMediumRegular
                                    : kMediumSemiBold,
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isRoundTrip,
                            child: const Icon(Icons.chevron_right),
                          ),
                          Visibility(
                            visible: isRoundTrip,
                            child: Expanded(
                              child: Center(
                                child: AutoSizeText(
                                    maxLines: 1,
                                   "${'returnShort'.tr()} ${AppDateUtils.formatDateWithoutLocale(returnDate,locale: locale)}",
                                    style: returnDate == null
                                        ? kMediumRegular
                                        : kMediumSemiBold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    kVerticalSpacer,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        weekText('calendar.daySundayShort'.tr()),
                        weekText('calendar.dayMondayShort'.tr()),
                        weekText('calendar.dayTuesdayShort'.tr()),
                        weekText('calendar.dayWednesdayShort'.tr()),
                        weekText('calendar.dayThursdayShort'.tr()),
                        weekText('calendar.dayFridayShort'.tr()),
                        weekText('calendar.daySaturdayShort'.tr()),
                      ],
                    ),
                    kVerticalSpacerMini,
                    Expanded(
                      child: PagedVerticalCalendar(
                        invisibleMonthsThreshold: 12,
                        minDate: bloc.minDate,
                        maxDate: bloc.maxDate,
                        initialDate: initialDate(departDate,),
                        startWeekWithSunday: true,
                        onDayPressed: (value) async {

                          final isBefore = value.isBefore(
                            bloc.minDate
                          );

                          if (isBefore) return;
                          if (isRoundTrip) {
                            setState(() {
                              bloc.updateStartDate(value);
                            });
                          } else {
                            setState(() {
                              bloc.updateStartDate(value);
                            });
                          }
                        },
                        onPaginationCompleted: (direction) {},
                        monthBuilder: (context, month, year) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              DateFormat("MMM yyyy",locale).format(
                                DateTime(year, month),
                              ),
                              style: kMediumMedium.copyWith(
                                  color: Styles.kPrimaryColor),
                            ),
                          );
                        },
                        dayBuilder: (context, date) {
                          final inRange =
                              isInRange(date, departDate, returnDate);

                          final isBefore = date.isBefore(
                           bloc.minDate
                          );
                          return Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: inRange
                                  ? Styles.kPrimaryColor
                                  : Colors.transparent,
                              border: Border.all(
                                color: Colors.white,
                                width: 0.3,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${date.day}",
                                  style: kSmallRegular.copyWith(
                                    color: inRange
                                        ? Colors.white
                                        : isBefore
                                            ? Styles.kBorderColor
                                            : null,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 25),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(24)),
                        color: Colors.white.withOpacity(0.75),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            spreadRadius: 0,
                            offset: const Offset(0, -2),
                          )
                        ]),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () async {


                              setState(() {
                                bloc.setFlightDates();

                              });


                            },
                            child:  Text('changeFlightView.reset'.tr()),
                          ),
                        ),
                        kHorizontalSpacer,
                        if (loadDate) ...[
                          const Expanded(
                            child: AppLoading(),
                          ),
                        ] else ...[
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                //                context.router.push(const SelectChangeFlightRoute());

                                setState(() {
                                  loadDate = true;
                                });

                                String? response =
                                    await bloc.getAvailableFlights(null, null);

                                if (response == null) {
                                  setState(() {
                                    loadDate = false;
                                  });
                                  context.router.push(
                                    const SelectChangeFlightRoute(),
                                  );
                                } else {

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return  NoFlightsFound(
                                        message: response ,
                                      );
                                    },
                                  );

                                  setState(() {
                                    loadDate = false;
                                  });

                                }
                              },
                              child:  Text('apply'.tr()),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  DateTime initialDate(DateTime? departDate,) {

    return departDate?.removeTime() ??
                          DateTime.now().removeTime();
  }
}

class NoFlightsFound extends StatelessWidget {
  const NoFlightsFound({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  //red-plane
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Center(
        child: Image.asset(
          "assets/images/design/red-plane.png",
          height: 50,
          width: 50,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 12,),
          Text(
            'flightChange.weSorry'.tr(),
            textAlign: TextAlign.center,
            style: k18Heavy.copyWith(color: Styles.kTextColor),
          ),
          const SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: kSmallSemiBold.copyWith(color: Styles.kTextColor),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    child:  Text('back'.tr()),
                    onPressed: () async {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
