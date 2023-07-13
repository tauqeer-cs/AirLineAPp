import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/models/confirmation_model.dart';
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

class MealSummaryDetail extends StatelessWidget {
  final bool isManageBooking;

   MealSummaryDetail(
      {Key? key, this.currency, this.isManageBooking = false})
      : super(key: key);
  final String? currency;
  ManageBookingCubit? manageBookingCubit;

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final bookingTotal = context.watch<BookingCubit>().state;
    var numberOfPerson = filter?.numberPerson;
    var persons = List<Person>.from(numberOfPerson?.persons ?? []);
    var totalPrice = ((filter?.numberPerson.getTotalMealPartial(true) ?? 0) +
        (filter?.numberPerson.getTotalMealPartial(false) ?? 0));
    persons.removeWhere((element) => element.peopleType == PeopleType.infant);

    if(isManageBooking) {
      manageBookingCubit = context.watch<ManageBookingCubit>();


      totalPrice = manageBookingCubit!.confirmedMealsTotalPrice;

      persons =  context
          .watch<ManageBookingCubit>()
          .state
          .manageBookingResponse
          ?.result
          ?.allPersonObject ??
          [];

      numberOfPerson = NumberPerson(persons: persons);

    }
      return Visibility(
      visible: totalPrice > 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChildRow(
            child1: Text(
              "meal".tr(),
              style: kLargeHeavy,
            ),
            child2: MoneyWidgetCustom(
              amountSize: 16,
              currency: currency,
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
              .map((e) => buildMealComponent(e, numberOfPerson, true))
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
                    .map((e) => buildMealComponent(e, numberOfPerson, false))
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

  Widget buildMealComponent(
      Person eP, NumberPerson? numberOfPerson, bool isDeparture) {
    final meal = eP.groupedMeal(isDeparture);

    num amountToMinus = 0.0;

    bool hideMeal = false;

    if (isManageBooking) {
      var ccc = manageBookingCubit
                          ?.state.manageBookingResponse?.result?.passengersWithSSR
                          ?.where((element) => element.personObject == eP)
                          .toList();



      if ((ccc ?? []).isNotEmpty){

        if(isDeparture) {
          if ((ccc ?? []).first.confirmedDepartMeals == null) {
            hideMeal = true;
          }
          else {
            if((ccc ?? []).first.confirmedDepartMeals?.isEmpty == true) {
              hideMeal = true;

            }

            var stringDepart = 'Depart';
            if(isDeparture == false) {

              stringDepart = 'Return';

            }
            //double totalAmount = (ccc ?? []).first.mealDetail.fold(0.0, (previousValue, obj) => previousValue + obj.amount);
            var cc1 = (ccc ?? []).first.mealDetail?.departureMeals.first.mealList?.where((element) => element.departReturn == stringDepart).toList();


            List<MealList> finalVar = (cc1 ?? []).where((e) => e.departReturn == stringDepart).toList();

            for(MealList currentMeal in finalVar ?? []){
              amountToMinus = amountToMinus + (currentMeal.amount ?? 0.0);

            }
            print('');



          }
        }
        else {
          if ((ccc ?? []).first.confirmedReturnMeals == null) {
            hideMeal = true;
          }
          else {
            if((ccc ?? []).first.confirmedReturnMeals?.isEmpty == true) {
              hideMeal = true;

            }

            var stringDepart = 'Depart';
            if(isDeparture == false) {

              stringDepart = 'Return';

            }
            //double totalAmount = (ccc ?? []).first.mealDetail.fold(0.0, (previousValue, obj) => previousValue + obj.amount);
            var cc1 = (ccc ?? []).first.mealDetail?.departureMeals.first.mealList?.where((element) => element.departReturn == stringDepart).toList();


            List<MealList> finalVar = (cc1 ?? []).where((e) => e.departReturn == stringDepart).toList();

            for(MealList currentMeal in finalVar ?? []){
              amountToMinus = amountToMinus + (currentMeal.amount ?? 0.0);

            }
            print('');



          }
        }

      }
    }

    return hideMeal ? Container() : Visibility(
      visible: eP.getPartialPriceMeal(isDeparture) > 0,
      child: ChildRow(
        child1: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eP.generateText(numberOfPerson, separator: "& "),
            ),
            ...meal.entries
                .map(
                  (e) {

                    return SummaryListItem(
                    text:
                        "${e.value.first.description} ${e.value.length > 1 ? 'x ${e.value.length}' : ''}",
                  );
                  }
                )
                .toList()
          ],
        ),
        child2: MoneyWidgetCustom(
          currency: currency,
          amount: eP.getPartialPriceMeal(isDeparture) - amountToMinus,
        ),
      ),
    );
  }
}
