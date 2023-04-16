import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightSummaryDetail extends StatelessWidget {
  final bool isDeparture;

  const FlightSummaryDetail({Key? key, required this.isDeparture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final bookingTotal = context.watch<BookingCubit>().state;
    final numberOfPerson = filter?.numberPerson;
    final persons = List<Person>.from(numberOfPerson?.persons ?? []);
    persons.removeWhere((element) => element.peopleType == PeopleType.infant);
    final segment = isDeparture
        ? bookingTotal.selectedDeparture
        : bookingTotal.selectedReturn;
    return Visibility(
      visible: isDeparture || filter?.flightType == FlightType.round,
      child: Column(
        children: [
          ChildRow(
            child1: Text(
              isDeparture ? 'flightDetail.departingFlight'.tr() : 'flightDetail.returningFlight'.tr(),
              style: kLargeHeavy,
            ),
            child2: MoneyWidgetCustom(
              amountSize: 16,
              myrSize: 16,
              amount: isDeparture
                  ? bookingTotal.selectedDeparture?.getTotalPriceDisplay
                  : bookingTotal.selectedReturn?.getTotalPriceDisplay,
              textColor: Styles.kPrimaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          kVerticalSpacerMini,
          ChildRow(
            child1: Text(
              'flightDetail.depart'.tr(),
            ),
            child2: FittedBox(
              child: Text(
                "${AppDateUtils.formatFullDateWithTime(segment?.departureDate)}\n${isDeparture ? filter?.origin?.name : filter?.destination?.name}",
                textAlign: TextAlign.end,
              ),
            ),
          ),
          kVerticalSpacerMini,
          ChildRow(
            child1: Text(
            'flightDetail.arrive'.tr(),
            ),
            child2: FittedBox(
              child: Text(
                "${AppDateUtils.formatFullDateWithTime(segment?.arrivalDate)}\n${isDeparture ? filter?.destination?.name : filter?.origin?.name}",
                textAlign: TextAlign.end,
              ),
            ),
          ),
          kVerticalSpacerMini,
          ...persons
              .map(
                (e) => ChildRow(
                  child1: Text(
                    e.generateText(numberOfPerson, separator: "& "),
                  ),
                  child2: MoneyWidgetCustom(
                    amount: e.peopleType == PeopleType.adult
                        ? e.isWithInfant(numberOfPerson)
                            ? (segment?.adultPricePerPax ?? 0) +
                                (segment?.infantPricePerPax ?? 0)
                            : segment?.adultPricePerPax
                        : segment?.childPricePerPax,
                  ),
                ),
              )
              .toList(),
          kVerticalSpacer,
          AppDividerWidget(),
          kVerticalSpacer,
        ],
      ),
    );
  }
}

class ChildRow extends StatelessWidget {
  final Widget child1, child2;

  const ChildRow({Key? key, required this.child1, required this.child2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: child1),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: child2,
            ),
          ),
        ],
      ),
    );
  }
}
