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

import '../../../../theme/theme.dart';

class BaggageSummaryDetail extends StatelessWidget {
  const BaggageSummaryDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final bookingTotal = context.watch<BookingCubit>().state;
    final numberOfPerson = filter?.numberPerson;
    final persons = List<Person>.from(numberOfPerson?.persons ?? []);
    final totalPrice =
        (filter?.numberPerson.getTotalBaggagePartial(true) ?? 0) +
            (filter?.numberPerson.getTotalBaggagePartial(false) ?? 0) +
            (filter?.numberPerson.getTotalSportsPartial(true) ?? 0) +
            (filter?.numberPerson.getTotalSportsPartial(false) ?? 0);
    persons.removeWhere((element) => element.peopleType == PeopleType.infant);

    return Visibility(
      visible: totalPrice > 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChildRow(
            child1: Text(
              "baggage".tr(),
              style: kLargeHeavy,
            ),
            child2: MoneyWidgetCustom(
              amountSize: 16,
              myrSize: 16,
              amount: totalPrice,
              textColor: Styles.kPrimaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          kVerticalSpacerSmall,
          Text(
            "depart".tr(),
            style: kMediumSemiBold,
          ),
          kVerticalSpacerMini,
          ...persons
              .map((e) => buildBaggageComponent(e, numberOfPerson, true))
              .toList(),
          kVerticalSpacerSmall,
          Visibility(
            visible: filter?.flightType == FlightType.round,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Return",
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

  Visibility buildBaggageComponent(
      Person e, NumberPerson? numberOfPerson, bool isDeparture) {
    print("is departure $isDeparture");
    final baggage = isDeparture ? e.departureBaggage : e.returnBaggage;
    final sport = isDeparture ? e.departureSports : e.returnSports;
    print("baggage $baggage");
    print("sport $sport");

    return Visibility(
      visible: baggage != null || sport != null,
      child: ChildRow(
        child1: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              e.generateText(numberOfPerson, separator: "& "),
            ),
            Visibility(
              visible: baggage != null,
              child: Text(
                "-${baggage?.description}",
                style: kMediumRegular.copyWith(color: Styles.kActiveGrey),
              ),
            ),
            Visibility(
              visible: sport != null,
              child: Text(
                "-${sport?.description}",
                style: kMediumRegular.copyWith(color: Styles.kActiveGrey),
              ),
            ),
          ],
        ),
        child2: MoneyWidgetCustom(
          amount: e.getPartialPriceBaggage(isDeparture) +
              e.getPartialPriceSports(isDeparture),
        ),
      ),
    );
  }
}
