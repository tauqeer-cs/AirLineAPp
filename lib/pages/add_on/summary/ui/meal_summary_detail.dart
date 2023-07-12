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

class MealSummaryDetail extends StatelessWidget {
  final bool isManageBooking;

  const MealSummaryDetail(
      {Key? key, this.currency, this.isManageBooking = false})
      : super(key: key);
  final String? currency;

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final bookingTotal = context.watch<BookingCubit>().state;
    var numberOfPerson = filter?.numberPerson;
    var persons = List<Person>.from(numberOfPerson?.persons ?? []);
    var totalPrice = ((filter?.numberPerson.getTotalMealPartial(true) ?? 0) +
        (filter?.numberPerson.getTotalMealPartial(false) ?? 0));
    persons.removeWhere((element) => element.peopleType == PeopleType.infant);
    ManageBookingCubit? manageBookingCubit;

    if(isManageBooking) {
      manageBookingCubit = context.watch<ManageBookingCubit>();


      totalPrice = manageBookingCubit.confirmedMealsTotalPrice;

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

  Visibility buildMealComponent(
      Person e, NumberPerson? numberOfPerson, bool isDeparture) {
    final meal = e.groupedMeal(isDeparture);
    return Visibility(
      visible: e.getPartialPriceMeal(isDeparture) > 0,
      child: ChildRow(
        child1: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              e.generateText(numberOfPerson, separator: "& "),
            ),
            ...meal.entries
                .map(
                  (e) => SummaryListItem(
                    text:
                        "${e.value.first.description} ${e.value.length > 1 ? 'x ${e.value.length}' : ''}",
                  ),
                )
                .toList()
          ],
        ),
        child2: MoneyWidgetCustom(
          currency: currency,
          amount: e.getPartialPriceMeal(isDeparture),
        ),
      ),
    );
  }
}
