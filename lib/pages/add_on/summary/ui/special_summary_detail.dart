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

class SpecialSummaryDetail extends StatelessWidget {
  final String? currency;
  const  SpecialSummaryDetail({Key? key, this.currency,  this.isManageBooking = false}) : super(key: key);
  final bool isManageBooking;
  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    var numberOfPerson = filter?.numberPerson;
    var persons = List<Person>.from(numberOfPerson?.persons ?? []);
    var totalPrice =
        (filter?.numberPerson.getTotalWheelChairPartial(true) ?? 0) +
            (filter?.numberPerson.getTotalWheelChairPartial(false) ?? 0);

    ManageBookingCubit? manageBookingCubit;

    if(isManageBooking) {
      manageBookingCubit = context.watch<ManageBookingCubit>();


      totalPrice = manageBookingCubit.confirmedWheelChairTotalPrice;

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
      visible: isManageBooking ? (manageBookingCubit?.isThereNewWheelChaie == true) : totalPrice > 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ChildRow(
            child1: Text(
              'passengerDetail.specialAddonsTitle'.tr(),
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
          'departing'.tr(),
            style: kMediumSemiBold,
          ),
          kVerticalSpacerMini,
          ...persons
              .map((e) => buildWheelChairComponent(e, numberOfPerson, true))
              .toList(),
          kVerticalSpacerSmall,
          Visibility(
            visible: (isManageBooking) ? (manageBookingCubit?.state.manageBookingResponse?.result?.isReturn ?? false ) : filter?.flightType == FlightType.round,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'returning'.tr(),
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
            SummaryListItem(text: wheelchair?.description ?? '', isManageBooking: isManageBooking,),
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
          currency: currency,
          amount: wheelchair?.finalAmount,
        ),
      ),
    );
  }
}
