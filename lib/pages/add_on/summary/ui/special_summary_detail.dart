import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/add_on/summary/ui/flight_detail.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/theme.dart';
import '../../ui/summary_list_item.dart';

class SpecialSummaryDetail extends StatelessWidget {
  const SpecialSummaryDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final bookingTotal = context.watch<BookingCubit>().state;
    final numberOfPerson = filter?.numberPerson;
    final persons = List<Person>.from(numberOfPerson?.persons ?? []);
    final totalPrice =
        (filter?.numberPerson.getTotalWheelChairPartial(true) ?? 0) +
            (filter?.numberPerson.getTotalWheelChairPartial(false) ?? 0);
    persons.removeWhere((element) => element.peopleType == PeopleType.infant);

    return Visibility(
      visible: totalPrice > 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChildRow(
            child1: Text(
              "Special Add-On",
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
            "Depart",
            style: kMediumSemiBold,
          ),
          kVerticalSpacerMini,
          ...persons
              .map((e) => buildWheelChairComponent(e, numberOfPerson, true))
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
                    .map((e) => buildWheelChairComponent(e, numberOfPerson, false))
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

  Visibility buildWheelChairComponent(
      Person e, NumberPerson? numberOfPerson, bool isDeparture) {
    final wheelchair = isDeparture ? e.departureWheelChair : e.returnWheelChair;
    final okId = isDeparture ? e.departureOkId : e.returnOkId;

    return Visibility(
      visible: wheelchair!=null,
      child: ChildRow(
        child1: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              e.generateText(numberOfPerson, separator: "& "),
            ),
            SummaryListItem(text: wheelchair?.description ?? '',),
            Visibility(
              visible: okId?.isNotEmpty ?? false,
              child: Text(
                "Disabled id: ${okId}",
                style:
                kMediumRegular.copyWith(color: Styles.kActiveGrey),
              ),
            ),
          ],
        ),
        child2: MoneyWidgetCustom(
          amount: wheelchair?.finalAmount,
        ),
      ),
    );
  }
}
