import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/add_on/summary/ui/flight_detail.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../../theme/theme.dart';
import '../../ui/summary_list_item.dart';

class BaggageSummaryDetail extends StatelessWidget {
   BaggageSummaryDetail(
      {Key? key,
      this.currency,
      required this.sports,
      this.isManageBooking = false})
      : super(key: key);
  final String? currency;
  final bool isManageBooking;

  final bool sports;
  ManageBookingCubit? manageBookingCubit;


  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    var numberOfPerson = filter?.numberPerson;
    var persons = List<Person>.from(numberOfPerson?.persons ?? []);
    num totalPrice = 0;
    if (sports) {
      totalPrice = (filter?.numberPerson.getTotalSportsPartial(true) ?? 0) +
          (filter?.numberPerson.getTotalSportsPartial(false) ?? 0);
    } else {
      totalPrice = (filter?.numberPerson.getTotalBaggagePartial(true) ?? 0) +
          (filter?.numberPerson.getTotalBaggagePartial(false) ?? 0);
    }

    if(isManageBooking) {
      manageBookingCubit = context.watch<ManageBookingCubit>();
      totalPrice = manageBookingCubit?.confirmedBaggageTotalPrice ?? 0.0;
      if(sports) {

        totalPrice = manageBookingCubit?.confirmedSportsTotalPrice ?? 0.0;

      }
      persons =  context
          .watch<ManageBookingCubit>()
          .state
          .manageBookingResponse
          ?.result
          ?.allPersonObject ??
          [];
      numberOfPerson = NumberPerson(persons: persons);

    }

    persons.removeWhere((element) => element.peopleType == PeopleType.infant);

    return Visibility(
      visible: totalPrice > 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChildRow(
            child1: Text(
              sports
                  ? "priceSection.sportsEquipmentTitle".tr()
                  : "baggage".tr(),
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
          ...persons
              .map((e) => buildBaggageComponent(e, numberOfPerson, true))
              .toList(),
          kVerticalSpacerSmall,
          Visibility(
            visible: isManageBooking ? (manageBookingCubit?.state.manageBookingResponse?.result?.isReturn ?? false) : (filter?.flightType == FlightType.round),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "returning".tr(),
                  style: kMediumSemiBold,
                ),
                kVerticalSpacerMini,
                ...persons
                    .map((e) => buildBaggageComponent(e, numberOfPerson, false))
                    .toList(),
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

  Widget buildBaggageComponent(
      Person e, NumberPerson? numberOfPerson, bool isDeparture) {
    final baggage = isDeparture ? e.departureBaggage : e.returnBaggage;
    final sport = isDeparture ? e.departureSports : e.returnSports;

    num amountToMinus = 0.0;
    final seats = e.departureSeats;

    if (isManageBooking) {
      var ccc = manageBookingCubit
          ?.state.manageBookingResponse?.result?.passengersWithSSR
          ?.where((element) => element.personObject == e)
          .toList();

      if ((ccc ?? []).isNotEmpty) {
        if(isDeparture == true) {
          if ((ccc ?? []).first.confirmDepartBaggageSelected == null) {
            return Container();
          }
        }
        else {
          if ((ccc ?? []).first.confirmReturnBaggageSelected == null) {
            return Container();
          }
        }
        if ((ccc ?? []).first.confirmDepartBaggageSelected == null) {
          //return Container();
        }
        else {

          /*
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
*/






          print('object');
          // ccc.first.seat
        }
      }
    }


    return Visibility(
      visible: baggage != null || sport != null,
      child: ChildRow(
        child1: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              e.generateText(numberOfPerson, separator: "& "),
            ),
            if (sports == false) ...[
              Visibility(
                visible: baggage != null,
                child: SummaryListItem(
                  text: baggage?.description ?? '', isManageBooking: isManageBooking,
                ),
              ),
            ] else ...[
              Visibility(
                visible: sport != null,
                child: SummaryListItem(
                  text: sport?.description ?? '', isManageBooking: isManageBooking,
                ),
              ),
            ],
          ],
        ),
        child2: MoneyWidgetCustom(
          currency: currency,
          amount: sports == false
              ? e.getPartialPriceBaggage(isDeparture)
              : e.getPartialPriceSports(isDeparture),
        ),
      ),
    );
  }
}
