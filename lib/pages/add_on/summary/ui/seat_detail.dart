import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/add_on/summary/ui/flight_detail.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../../data/responses/verify_response.dart';
import '../../../../theme/theme.dart';
import '../../ui/summary_list_item.dart';

class SeatSummaryDetail extends StatelessWidget {
  const SeatSummaryDetail(
      {Key? key, this.currency, this.isManageBooking = false})
      : super(key: key);
  final String? currency;
  final bool isManageBooking;

  @override
  Widget build(BuildContext context) {
    ManageBookingCubit? manageBookingCubit;

    num totalPrice = 0;

    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final bookingTotal = context.watch<BookingCubit>().state;
    final numberOfPerson = filter?.numberPerson;
    List<Person> persons = List<Person>.from(numberOfPerson?.persons ?? []);
    totalPrice = ((filter?.numberPerson.getTotalSeatsPartial(true) ?? 0) +
        (filter?.numberPerson.getTotalSeatsPartial(false) ?? 0));
    persons.removeWhere((element) => element.peopleType == PeopleType.infant);
    final flightSeats = bookingTotal.verifyResponse?.flightSeat;
    var rowsDeparture = flightSeats
        ?.outbound
        ?.firstOrNull
        ?.retrieveFlightSeatMapResponse
        ?.physicalFlights
        ?.firstOrNull
        ?.physicalFlightSeatMap
        ?.seatConfiguration
        ?.rows;
    var rowsReturn = flightSeats
        ?.inbound
        ?.firstOrNull
        ?.retrieveFlightSeatMapResponse
        ?.physicalFlights
        ?.firstOrNull
        ?.physicalFlightSeatMap
        ?.seatConfiguration
        ?.rows;
    if (isManageBooking) {
      manageBookingCubit = context.watch<ManageBookingCubit>();

      totalPrice = manageBookingCubit.confirmedSeatsTotalPrice;

      manageBookingCubit.hasAnySeatChanged;

      persons = context
              .watch<ManageBookingCubit>()
              .state
              .manageBookingResponse
              ?.result
              ?.allPersonObject ??
          [];

      rowsDeparture = manageBookingCubit
          .state
          .flightSeats
          ?.outbound
          ?.firstOrNull
          ?.retrieveFlightSeatMapResponse
          ?.physicalFlights
          ?.firstOrNull
          ?.physicalFlightSeatMap
          ?.seatConfiguration
          ?.rows;

      rowsReturn = manageBookingCubit
          .state
          .flightSeats
          ?.inbound
          ?.firstOrNull
          ?.retrieveFlightSeatMapResponse
          ?.physicalFlights
          ?.firstOrNull
          ?.physicalFlightSeatMap
          ?.seatConfiguration
          ?.rows;
    } else {}

    return Visibility(
      visible: totalPrice > 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChildRow(
            child1: Text(
              "seat".tr(),
              style: kLargeHeavy,
            ),
            child2: MoneyWidgetCustom(
              currency: currency,
              amountSize: 16,
              myrSize: 16,
              amount: totalPrice,
              textColor: Styles.kPrimaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          kVerticalSpacerSmall,
          Text(
            "departing".tr(),
            style: kMediumSemiBold,
          ),
          kVerticalSpacerMini,
          ...persons.map(
            (e) {
              num amountToMinus = 0.0;
              final seats = e.departureSeats;

              if (isManageBooking) {
                var ccc = manageBookingCubit
                    ?.state.manageBookingResponse?.result?.passengersWithSSR
                    ?.where((element) => element.personObject == e)
                    .toList();

                if ((ccc ?? []).isNotEmpty) {
                  if ((ccc ?? []).first.confirmedDepartSeatSelected == null) {
                    return Container();
                  } else {

                    var tmpSeat = manageBookingCubit
                        ?.state.manageBookingResponse?.result?.seatDetail?.seats
                        ?.where((element) =>
                            element.givenName ==
                            ccc?.first.passengers?.givenName &&

                                element.surName ==
                                    ccc?.first.passengers?.surname &&
                        element.departReturn == 'Depart'
                    ).toList();

                    if((tmpSeat ?? []).isNotEmpty) {
                      amountToMinus = (tmpSeat ?? []).first.amount ?? 0.0;
                    }




                    print('object');
                    // ccc.first.seat
                  }
                }
              }

              print('');

              Seats? previousSeat;
              Seats? previousReturnSeat;
              num previousDepPrice = 0.0;
              num previousReturnPrice = 0.0;
              if(isManageBooking) {
                previousSeat = manageBookingCubit?.passengerFromPerson(e)?.previousDepartureSeats;

                if(previousSeat != null) {
                  previousDepPrice = manageBookingCubit?.passengerFromPerson(e)?.seatDetail?.departureSeat.first.amount ?? 0.0;
                }

                if(manageBookingCubit?.state.manageBookingResponse?.isTwoWay == true){
                  previousReturnSeat = manageBookingCubit?.passengerFromPerson(e)?.previousReturnSeats;
                  if(previousReturnSeat != null) {
                    previousReturnPrice = manageBookingCubit?.passengerFromPerson(e)?.seatDetail?.returnSeat.first.amount ?? 0.0;

                  }

                }
                print('');

              }


              final allRows = (rowsDeparture ?? []);
              final row = (rowsDeparture ?? [])
                  .firstWhereOrNull((element) => element.rowId == seats?.rowId);
              return Visibility(
                visible: e.getPartialPriceSeatPartial(true) > 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    if(isManageBooking == true) ... [


                      if(previousSeat != null) ... [

                        Text(
                          e.generateText(numberOfPerson, separator: "& "),
                        ),
                        ChildRow(
                          child1: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 6),
                                child: Text(
                                  "- ${previousSeat.seatNameToShow(allRows) ?? ''}",
                                  style: kMediumRegular.copyWith(
                                      color: Styles.kActiveGrey),
                                ),
                              ),
                            ],
                          ),
                          child2: MoneyWidgetCustom(
                            currency: currency,
                            amount: previousDepPrice,
                          ),
                        ),
                      ],

                    ] ,


                    ChildRow(
                      child1: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(previousSeat == null) ... [
                            Text(
                              e.generateText(numberOfPerson, separator: "& "),
                            ),
                          ],

                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Text(
                              "- ${seats?.seatColumn == null ? 'noSeatSelected'.tr() : '${seats?.seatColumn}${row?.rowNumber}'}",
                              style: kMediumRegular.copyWith(
                                  color: isManageBooking ? Styles.kPrimaryColor : Styles.kActiveGrey),

                            ),
                          ),
                        ],
                      ),
                      child2: MoneyWidgetCustom(
                        textColor: isManageBooking ? Styles.kPrimaryColor : null,
                        currency: currency,
                        amount: e.getPartialPriceSeatPartial(true),
                      ),
                    ),
                  ],
                ),
              );
            },
          ).toList(),
          kVerticalSpacerSmall,
          Visibility(
            visible: isManageBooking
                ? (manageBookingCubit
                        ?.state.manageBookingResponse?.result?.isReturn ??
                    false)
                : (filter?.flightType == FlightType.round),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "returning".tr(),
                  style: kMediumSemiBold,
                ),
                kVerticalSpacerMini,
                ...persons.map(
                  (e) {
                    final seats = e.returnSeats;
                    final row = (rowsReturn ?? []).firstWhereOrNull(
                        (element) => element.rowId == seats?.rowId);


                    num amountToMinusReturn = 0.0;
                    Seats? previousReturnSeat;
                    num previousReturnPrice = 0.0;

                    bool hideReturn = false;

                    if (isManageBooking) {



                        if(manageBookingCubit?.state.manageBookingResponse?.isTwoWay == true){
                          previousReturnSeat = manageBookingCubit?.passengerFromPerson(e)?.previousReturnSeats;
                          if(previousReturnSeat != null) {
                            previousReturnPrice = manageBookingCubit?.passengerFromPerson(e)?.seatDetail?.returnSeat.first.amount ?? 0.0;

                          }

                        }
                        print('');



                      var ccc = manageBookingCubit
                          ?.state.manageBookingResponse?.result?.passengersWithSSR
                          ?.where((element) => element.personObject == e)
                          .toList();

                      if ((ccc ?? []).isNotEmpty) {

                        if((ccc ?? []).first.confirmedReturnSeatSelected == null) {

                          hideReturn = true;

                        }
                        if ((ccc ?? []).first.confirmedReturnSeatSelected == null) {
                          return Container();
                        } else {
                          var camountToMinus = e.departureSeats;




                          var  tmpSeat = manageBookingCubit
                              ?.state.manageBookingResponse?.result?.seatDetail?.seats
                              ?.where((element) =>
                          element.givenName ==
                              ccc?.first.passengers?.givenName &&

                              element.surName ==
                                  ccc?.first.passengers?.surname &&
                              element.departReturn != 'Depart'
                          ).toList();

                          if((tmpSeat ?? []).isNotEmpty) {
                            amountToMinusReturn = (tmpSeat ?? []).first.amount ?? 0.0;
                          }
                          // ccc.first.seat
                        }
                      }
                    }

                    return hideReturn ? Container() : Visibility(
                      visible: e.getPartialPriceSeatPartial(false) > 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(isManageBooking == true) ... [

                        if(previousReturnSeat != null) ... [

                              Text(
                                e.generateText(numberOfPerson, separator: "& "),
                              ),
                              ChildRow(
                                child1: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(left: 6),
                                      child: Text(
                                        "- ${previousReturnSeat.seatNameToShow((rowsReturn ?? [])) ?? ''}",
                                        style: kMediumRegular.copyWith(
                                            color: Styles.kActiveGrey),
                                      ),
                                    ),
                                  ],
                                ),
                                child2: MoneyWidgetCustom(
                                  currency: currency,
                                  amount: previousReturnPrice,
                                ),
                              ),
                            ],

                          ] ,
                          ChildRow(
                            child1: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                if(isManageBooking == false &&previousReturnSeat == null) ... [
                                  Text(
                                    e.generateText(numberOfPerson, separator: "& "),
                                  ),
                                ],


                                SummaryListItem(

                                  text: seats?.seatColumn == null
                                      ? 'noSeatSelected'.tr()
                                      : '${seats?.seatColumn}${row?.rowNumber}', isManageBooking: isManageBooking,
                                  makeRed:isManageBooking ,
                                ),
                              ],
                            ),
                            child2: MoneyWidgetCustom(
                              currency: currency,
                              amount: e.getPartialPriceSeatPartial(false) ,
                              textColor: isManageBooking ? Styles.kPrimaryColor : null,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              ],
            ),
          ),
          kVerticalSpacer,
          AppDividerWidget(),
          kVerticalSpacer,
        ],
      ),
    );
  }
}
