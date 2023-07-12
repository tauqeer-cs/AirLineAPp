import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/add_on/ui/passenger_selector.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:app/pages/checkout/ui/empty_addon.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_tooltip.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../blocs/cms/agent_sign_up/agent_sign_up_cubit.dart';
import '../../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../../widgets/app_money_widget.dart';

class MealsSection extends StatelessWidget {
  final bool isDeparture;

  final bool isManageBooking;

  MealsSection(
      {Key? key, this.isDeparture = true, this.isManageBooking = false})
      : super(key: key);

  ManageBookingCubit? manageBookingCubit;

  @override
  Widget build(BuildContext context) {
    BundleGroupSeat? mealGroup;
    List<Bundle> meals = [];
    bool isFlightUnderAnHour = false;
    bool isFlightOver24Hour = false;

    if (isManageBooking) {
      var bloc = context.watch<ManageBookingCubit>();
      manageBookingCubit = bloc;

      var state = bloc.state;
      mealGroup = state.flightSSR?.mealGroup;

      meals = (isDeparture ? mealGroup?.outbound : mealGroup?.inbound) ?? [];
      DateTime departDate = state.manageBookingResponse?.result?.flightSegments
              ?.first.outbound![0].departureDateTime ??
          DateTime.now();
      DateTime returnDate = DateTime.now();

      if ((state.manageBookingResponse?.result?.flightSegments?.first.inbound ??
              [])
          .isNotEmpty) {
        returnDate = state.manageBookingResponse?.result?.flightSegments?.first
                .inbound![0].departureDateTime ??
            DateTime.now();
      }

      isFlightUnderAnHour = isDeparture
          ? departDate
                  .difference(
                    DateTime.now(),
                  )
                  .inHours <=
              1
          : returnDate
                  .difference(
                    DateTime.now(),
                  )
                  .inHours <=
              1;

      isFlightOver24Hour = isDeparture
          ? departDate.difference(DateTime.now()).inHours <= 24
          : returnDate.difference(DateTime.now()).inHours <= 1;
    } else {
      final bookingState = context.watch<BookingCubit>().state;
      mealGroup = bookingState.verifyResponse?.flightSSR?.mealGroup;

      final state = context.watch<SearchFlightCubit>().state;

      meals = (isDeparture ? mealGroup?.outbound : mealGroup?.inbound) ?? [];

      isFlightUnderAnHour = isDeparture
          ? state.filterState!.departDate!
                  .difference(
                    DateTime.now(),
                  )
                  .inHours <=
              1
          : state.filterState!.returnDate!
                  .difference(
                    DateTime.now(),
                  )
                  .inHours <=
              1;

      isFlightOver24Hour = isDeparture
          ? state.filterState!.departDate!
                  .difference(
                    DateTime.now(),
                  )
                  .inHours <=
              24
          : state.filterState!.returnDate!
                  .difference(
                    DateTime.now(),
                  )
                  .inHours <=
              1;
    }

    return isFlightOver24Hour
        ? const FlightWithin24Hour()
        : Visibility(
            visible: meals.isNotEmpty ?? false,
            replacement: const EmptyAddon(),
            child: Padding(
              padding: kPageHorizontalPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isManageBooking == false) ...[
                    PassengerSelector(
                      isDeparture: isDeparture,
                      addonType: AddonType.meal,
                    ),
                  ] else
                    ...[],
                  kVerticalSpacer,
                  isFlightUnderAnHour
                      ? const FlightUnderAnHour()
                      : isFlightOver24Hour
                          ? const FlightWithin24Hour()
                          : buildMealCards(meals, isDeparture),
                ],
              ),
            ),
          );
  }

  Column buildMealCards(List<Bundle>? bundles, bool isDeparture) {
    bundles?.removeWhere((element) => (element.ssrCode ?? '').isEmpty);

    return Column(
      children: [
        ...bundles?.map(
              (e) {
                return Column(
                  children: [
                    NewMealCard(
                      meal: e,
                      isDeparture: isDeparture,
                      isManageBooking: isManageBooking,
                    ),
                    kVerticalSpacerSmall,
                  ],
                );
              },
            ).toList() ??
            [],
        if (isManageBooking) ...[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(),
          ),
          kVerticalSpacerSmall,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Text(
                  'mealsSubtotal'.tr(),
                  style: kHugeSemiBold.copyWith(color: Styles.kTextColor),
                ),
                Expanded(
                  child: Container(),
                ),
                const MoneyWidget(
                  amount: 0.00,
                  isDense: true,
                  isNormalMYR: true,
                ),
              ],
            ),
          ),
          kVerticalSpacerSmall,
          Row(
            children: [
              Expanded(
                child: Container(),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: manageBookingCubit?.hasAnySeatChanged == false
                      ? null
                      : () {
                          manageBookingCubit?.seatMealSeatChange();

                          manageBookingCubit?.changeSelectedAddOnOption(
                              AddonType.none,
                              toNull: true);
                        },
                  child: Text('selectDateView.confirm'.tr()),
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
          kVerticalSpacer,
        ],
      ],
    );
  }
}

class NewMealCard extends StatelessWidget {
  final Bundle meal;
  final bool isDeparture;
  final bool isManageBooking;

  NewMealCard(
      {Key? key,
      required this.meal,
      required this.isDeparture,
      required this.isManageBooking})
      : super(key: key);

  changeNumber(
      BuildContext context, Person? person, bool isAdd, bool isDeparture) {
    if (isManageBooking) {
      manageCubit?.addOrRemoveMealFromPerson(
        isDeparture: isDeparture,
        isAdd: isAdd,
        person: person,
        meal: meal,
      );

      return;
    }
    context.read<SearchFlightCubit>().addOrRemoveMealFromPerson(
          isDeparture: isDeparture,
          isAdd: isAdd,
          person: person,
          meal: meal,
        );
  }

  ManageBookingCubit? manageCubit;

  @override
  Widget build(BuildContext context) {
    Person? selectedPerson;
    NumberPerson? persons;
    bool isDeparture = false;

    if (isManageBooking == true) {
      manageCubit = context.watch<ManageBookingCubit>();

      isDeparture = context.watch<ManageBookingCubit>().state.foodDepearture;
      var no = context
              .watch<ManageBookingCubit>()
              .state
              .manageBookingResponse
              ?.result
              ?.allPersonObject ??
          [];

      persons = NumberPerson(persons: no);
      selectedPerson =
          context.watch<ManageBookingCubit>().state.selectedPax?.personObject;
    } else {
      selectedPerson = context.watch<SelectedPersonCubit>().state;
      final state = context.watch<SearchFlightCubit>().state;
      persons = state.filterState?.numberPerson;

      isDeparture = context.watch<IsDepartureCubit>().state;
    }

    final focusedPerson = persons?.persons
        .firstWhereOrNull((element) => element == selectedPerson);

    final meals =
        isDeparture ? focusedPerson?.departureMeal : focusedPerson?.returnMeal;
    final length = meals?.where((element) => element == meal).length;
    final cmsMeals = context.watch<CmsSsrCubit>().state.mealGroups;
    final cmsDetail =
        cmsMeals.firstWhereOrNull((element) => element.code == meal.codeType);
    //const mealSoldOut = false;
    print(" image is ${cmsDetail?.image}");
    return AppCard(
      edgeInsets: EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                kVerticalSpacer,
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Image.network(
                      cmsDetail?.image ?? "",
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: progress.expectedTotalBytes != null
                                ? progress.cumulativeBytesLoaded /
                                    progress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      kVerticalSpacer,
                      Wrap(
                        children: [
                          Text(
                            meal.description ?? "",
                            style: kMediumRegular,
                            textAlign: TextAlign.center,
                          ),
                          kHorizontalSpacerMini,
                          AppTooltip(child: Text(cmsDetail?.description ?? "")),
                        ],
                      ),
                      Text(
                        "${meal.currencyCode ?? "MYR"} ${NumberUtils.formatNumber(meal.finalAmount.toDouble())}",
                        style:
                            kLargeHeavy.copyWith(color: Styles.kPrimaryColor),
                      ),
                    ],
                  ),
                ),
                kVerticalSpacer,
                InputWithPlusMinus(
                  number: length ?? 0,
                  handler: changeNumber,
                  person: focusedPerson,
                  isManageBooking: isManageBooking,
                ),
                kVerticalSpacer,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InputWithPlusMinus extends StatelessWidget {
  final int number;
  final Person? person;
  final Function(BuildContext, Person?, bool, bool) handler;
  final bool isManageBooking;

  const InputWithPlusMinus({
    Key? key,
    required this.number,
    required this.handler,
    required this.person,
    required this.isManageBooking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDeparture = false;

    if (isManageBooking) {
      isDeparture = context.watch<ManageBookingCubit>().state.foodDepearture;
    } else {
      isDeparture = context.watch<IsDepartureCubit>().state;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kHorizontalSpacer,
              SizedBox(
                width: 105.h,
                height: 35.h,
                child: OutlinedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Styles.kPrimaryColor),
                      ),
                    ),
                  ),
                  onPressed: number > 0
                      ? () => handler(context, person, false, isDeparture)
                      : null,
                  child: Icon(
                    Icons.remove,
                    size: 20,
                    color: number == 0
                        ? Styles.kBorderColor
                        : Styles.kPrimaryColor,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  number.toString(),
                  style: kGiantSemiBold.copyWith(color: Styles.kSubTextColor),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                width: 105.h,
                height: 35.h,
                child: OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Styles.kPrimaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Styles.kPrimaryColor),
                      ),
                    ),
                  ),
                  onPressed: () => handler(context, person, true, isDeparture),
                  child: const Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              kHorizontalSpacer,
            ],
          ),
        ),
      ],
    );
  }
}

class FlightUnderAnHour extends StatelessWidget {
  const FlightUnderAnHour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kPageHorizontalPadding,
      child: Column(
        children: [
          kVerticalSpacer,
          const Text(
            "Oh, your flight is 1 hour or less.",
            style: kHugeHeavy,
            textAlign: TextAlign.center,
          ),
          kVerticalSpacerSmall,
          const Padding(
            padding: kPageHorizontalPaddingBig,
            child: Text(
              "Just buy your munchies and drinks on board your flight.",
              style: kLargeRegular,
              textAlign: TextAlign.center,
            ),
          ),
          kVerticalSpacer,
        ],
      ),
    );
  }
}

class FlightWithin24Hour extends StatelessWidget {
  const FlightWithin24Hour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final agentCms = context.watch<AgentSignUpCubit>().state;

    return Padding(
      padding: kPageHorizontalPadding,
      child: Column(
        children: [
          kVerticalSpacer,
          Text(
            agentCms.meal24Title ?? 'flight24warning'.tr(),
            style: kHugeHeavy,
            textAlign: TextAlign.center,
          ),
          kVerticalSpacerSmall,
          Padding(
            padding: kPageHorizontalPaddingBig,
            child: Text(
              agentCms.mean24Content ?? 'buyMunchiesOnBoard'.tr(),
              style: kLargeRegular,
              textAlign: TextAlign.center,
            ),
          ),
          kVerticalSpacer,
        ],
      ),
    );
  }
}
