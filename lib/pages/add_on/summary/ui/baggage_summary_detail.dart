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

          if(isManageBooking) ... [

            ...persons
                .map((e) => buildBaggageComponentMMb(e, numberOfPerson, true))
                .toList(),
          ] else ... [
            Text(
              "departing".tr(),
              style: kMediumSemiBold,
            ),
            kVerticalSpacerMini,

            ...persons
                .map((e) => buildBaggageComponent(e, numberOfPerson, true))
                .toList(),
          ],



          kVerticalSpacerSmall,
          Visibility(
            visible: isManageBooking ? (manageBookingCubit?.state.manageBookingResponse?.result?.isReturn ?? false) : (filter?.flightType == FlightType.round),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                if(isManageBooking) ... [
                  ...persons
                      .map((e) => buildBaggageComponentMMb(e, numberOfPerson, false))
                      .toList(),
                ] else ... [
                  Text(
                    "returning".tr(),
                    style: kMediumSemiBold,
                  ),
                  kVerticalSpacerMini,
                  ...persons
                      .map((e) => buildBaggageComponent(e, numberOfPerson, false))
                      .toList(),
                ],

              ],
            ),
          ),
          kVerticalSpacer,
          const AppDividerWidget(),
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
                  makeRed: this.isManageBooking,
                  text: baggage?.description ?? '', isManageBooking: isManageBooking,
                ),
              ),
            ] else ...[


              Visibility(
                visible: sport != null,
                child: SummaryListItem(
                  makeRed: this.isManageBooking,
                  text: sport?.description ?? '', isManageBooking: isManageBooking,
                ),
              ),
            ],
          ],
        ),
        child2: MoneyWidgetCustom(
          currency: currency,
          textColor: isManageBooking ? Styles.kPrimaryColor : null,
          amount: sports == false
              ? e.getPartialPriceBaggage(isDeparture)
              : e.getPartialPriceSports(isDeparture),
        ),
      ),
    );
  }

   Widget buildBaggageComponentMMb(
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
           if(sports == true) {
             if ((ccc ?? []).first.confirmedDepartSportsSelected == null) {
               return Container();
             }
           }
           else if ((ccc ?? []).first.confirmDepartBaggageSelected == null) {
             return Container();
           }
         }
         else {
           if(sports == true){
             if ((ccc ?? []).first.confirmedReturnSportsSelected == null) {
               return Container();
             }
           } else
           if ((ccc ?? []).first.confirmReturnBaggageSelected == null) {
             return Container();
           }
         }

       }
     }



     //
     return  Visibility(
       visible: sports ? (isDeparture ? manageBookingCubit?.passengerFromPerson(e)?.confirmedDepartSportsSelected != null : manageBookingCubit?.passengerFromPerson(e)?.confirmedReturnSportsSelected != null) : (isDeparture ? manageBookingCubit?.passengerFromPerson(e)?.confirmDepartBaggageSelected != null : manageBookingCubit?.passengerFromPerson(e)?.confirmReturnBaggageSelected != null),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [

           if(isDeparture == true) ... [
             Text(
               "departing".tr(),
               style: kMediumSemiBold,
             ),
             kVerticalSpacerMini,
           ]  else ... [
             Text(
               "returning".tr(),
               style: kMediumSemiBold,
             ),
             kVerticalSpacerMini,
           ],



           if(isManageBooking) ... [
             if(isDeparture && sports == false) ... [
               if(manageBookingCubit?.passengerFromPerson(e)?.previousDepartureBaggage != null && manageBookingCubit?.passengerFromPerson(e)?.confirmDepartBaggageSelected != null) ... [

                 ChildRow(
                   child1: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         e.generateText(numberOfPerson, separator: "& "),
                       ),

                         Visibility(
                           visible: manageBookingCubit?.passengerFromPerson(e)?.previousDepartureBaggage != null,
                           child: SummaryListItem(
                             makeRed: false,
                             text: manageBookingCubit?.passengerFromPerson(e)?.previousDepartureBaggage?.description ?? '', isManageBooking: isManageBooking,
                           ),
                         ),

                     ],
                   ),
                   child2: Padding(
                     padding: const EdgeInsets.only(top: 16),
                     child: MoneyWidgetCustom(
                       currency: currency,
                       amount:  manageBookingCubit?.passengerFromPerson(e)?.baggageDetail?.departureBaggages.first.amount ?? 0.0,
                     ),
                   ),
                 ),


               ],
             ]
             else if(isDeparture == false&& sports == false) ... [
               if(manageBookingCubit?.passengerFromPerson(e)?.previousReturnBaggage != null && manageBookingCubit?.passengerFromPerson(e)?.confirmReturnBaggageSelected != null) ... [

                 ChildRow(
                   child1: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         e.generateText(numberOfPerson, separator: "& "),
                       ),
                       if (sports == false) ...[


                         Visibility(
                           visible: manageBookingCubit?.passengerFromPerson(e)?.previousReturnBaggage != null,
                           child: SummaryListItem(
                             makeRed: false,
                             text: manageBookingCubit?.passengerFromPerson(e)?.previousReturnBaggage?.description ?? '', isManageBooking: isManageBooking,
                           ),
                         ),
                       ],
                     ],
                   ),
                   child2: Padding(
                     padding: const EdgeInsets.only(top: 16),
                     child: MoneyWidgetCustom(
                       currency: currency,
                       amount:  manageBookingCubit?.passengerFromPerson(e)?.baggageDetail?.returnBaggages.first.amount ?? 0.0,

                     ),
                   ),
                 ),


               ],
             ]
             else if(isDeparture && sports == true) ... [
               if(manageBookingCubit?.passengerFromPerson(e)?.previousDepartureSports != null || manageBookingCubit?.passengerFromPerson(e)?.confirmedDepartSportsSelected != null) ... [
                 ChildRow(
                   child1: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(
                         e.generateText(numberOfPerson, separator: "& "),
                       ),

                       Visibility(
                         visible: manageBookingCubit?.passengerFromPerson(e)?.previousDepartureSports != null,
                         child: SummaryListItem(
                           makeRed: false,
                           text: manageBookingCubit?.passengerFromPerson(e)?.previousDepartureSports?.description ?? '', isManageBooking: isManageBooking,
                         ),
                       ),

                       //(manageBookingCubit?.passengerFromPerson(e)?.sportEquipmentDetail.) ? Container() :
                     ],
                   ),
                   child2:  Padding(
                     padding: const EdgeInsets.only(top: 16),
                     child: manageBookingCubit?.passengerFromPerson(e)?.sportEquipmentDetail?.totalAmount == 0 ? Container() : MoneyWidgetCustom(
                       currency: currency,
                       amount:  manageBookingCubit?.passengerFromPerson(e)?.sportEquipmentDetail?.departureBaggages.first.amount ?? 0.0,

                     ),
                   ),
                 ),


               ],
             ]
               else if(isDeparture == false&& sports == true) ... [
                   if(manageBookingCubit?.passengerFromPerson(e)?.previousReturnSports != null && manageBookingCubit?.passengerFromPerson(e)?.confirmedReturnSportsSelected != null) ... [

                     ChildRow(
                       child1: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             e.generateText(numberOfPerson, separator: "& "),
                           ),


                             Visibility(
                               visible: manageBookingCubit?.passengerFromPerson(e)?.previousReturnSports != null,
                               child: SummaryListItem(
                                 makeRed: false,
                                 text: manageBookingCubit?.passengerFromPerson(e)?.previousReturnSports?.description ?? '', isManageBooking: isManageBooking,
                               ),
                             ),

                         ],
                       ),
                       child2: Padding(
                         padding: const EdgeInsets.only(top: 16),
                         child: manageBookingCubit?.passengerFromPerson(e)?.sportEquipmentDetail?.totalAmount == 0 ? Container() : MoneyWidgetCustom(
                           currency: currency,
                           amount:  manageBookingCubit?.passengerFromPerson(e)?.sportEquipmentDetail?.returnBaggages.first.amount ?? 0.0,

                         ),
                       ),
                     ),


                   ],
                 ]
             else ...[

             ],

           ],



           ChildRow(
             child1: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [

                 if(this.isManageBooking == true && isDeparture == true &&this.sports == false && (manageBookingCubit?.passengerFromPerson(e)?.previousDepartureBaggage != null)) ... [

                 ]
                 else if(this.isManageBooking == true && isDeparture == false &&this.sports == false && (manageBookingCubit?.passengerFromPerson(e)?.previousReturnBaggage != null)) ... [

                 ]
                 else if(this.isManageBooking == true && isDeparture == true &&this.sports == true && (manageBookingCubit?.passengerFromPerson(e)?.previousDepartureSports != null)) ... [

                 ]
                 else if(this.isManageBooking == true && isDeparture == false &&this.sports == true && (manageBookingCubit?.passengerFromPerson(e)?.previousReturnSports != null)) ... [

                 ]
                 else ... [
                   Text(
                     e.generateText(numberOfPerson, separator: "& "),
                   ),
                 ] ,


                 if (sports == false) ...[

//manageBookingCubit?.passengerFromPerson(e)?.previousDepartureBaggage
                   /*Visibility(
                     visible: isDeparture ?  baggage != null,
                     child: SummaryListItem(
                       makeRed: isManageBooking,
                       text: baggage?.description ?? '', isManageBooking: isManageBooking,
                     ),
                   ),*/
                   Visibility(
                     visible: isDeparture ?  (manageBookingCubit?.passengerFromPerson(e)?.confirmDepartBaggageSelected != null) : (manageBookingCubit?.passengerFromPerson(e)?.confirmReturnBaggageSelected != null),
                     child: SummaryListItem(
                       makeRed: isManageBooking,
                       text: isDeparture ?  (manageBookingCubit?.passengerFromPerson(e)?.confirmDepartBaggageSelected!.description ?? '') : (manageBookingCubit?.passengerFromPerson(e)?.confirmReturnBaggageSelected!.description ?? ''),
                       isManageBooking: isManageBooking,
                     ),
                   ),

                 ] else ...[


                   Visibility(
                     visible: isDeparture ?  (manageBookingCubit?.passengerFromPerson(e)?.confirmedDepartSportsSelected != null) : (manageBookingCubit?.passengerFromPerson(e)?.confirmedReturnSportsSelected != null),
                     child: SummaryListItem(
                       makeRed: isManageBooking,
                       text: isDeparture ?  (manageBookingCubit?.passengerFromPerson(e)?.confirmedDepartSportsSelected!.description ?? '') : (manageBookingCubit?.passengerFromPerson(e)?.confirmedReturnSportsSelected!.description ?? ''),
                       isManageBooking: isManageBooking,
                     ),
                   ),
                 ],
               ],
             ),
             child2: MoneyWidgetCustom(
               currency: currency,
               textColor: isManageBooking ? Styles.kPrimaryColor : null,
               amount: sports == false
                   ? (isDeparture ?  (manageBookingCubit?.passengerFromPerson(e)?.confirmDepartBaggageSelected!.amount ?? 0.0) : (manageBookingCubit?.passengerFromPerson(e)?.confirmReturnBaggageSelected!.amount ?? 0.0))
                   : (isDeparture ?  (manageBookingCubit?.passengerFromPerson(e)?.confirmedDepartSportsSelected!.amount ?? 0.0) : (manageBookingCubit?.passengerFromPerson(e)?.confirmedReturnSportsSelected!.amount ?? 0.0)),
             ),
           ),
         ],
       ),
     );
   }

}
