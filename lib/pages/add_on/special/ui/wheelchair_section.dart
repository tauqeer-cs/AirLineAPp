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
import 'package:app/widgets/app_image.dart';
import 'package:app/widgets/custom_checkbox.dart';
import 'package:app/widgets/forms/bordered_input_text.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../../widgets/app_money_widget.dart';

class WheelchairSection extends StatelessWidget {
  final bool isDeparture;

  final bool isManageBooking;

  const WheelchairSection({
    Key? key,
    this.isDeparture = true,
    this.isManageBooking = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Person? selectedPerson;
    BundleGroupSeat? wheelChairGroup;
    NumberPerson? persons;
    Person? focusedPerson;
    List<Bundle>? wheelChairs;
    String? okId;
    Bundle? selectedWheelchair;
    ManageBookingCubit? manageBookingCubit;

    if (isManageBooking) {
      manageBookingCubit = context.watch<ManageBookingCubit>();

      var state = context.watch<ManageBookingCubit>().state;
      selectedPerson = state.selectedPax?.personObject;
      wheelChairGroup = state.flightSSR?.wheelChairGroup;
      wheelChairs =
          isDeparture ? wheelChairGroup?.outbound : wheelChairGroup?.inbound;
      var no = context
              .watch<ManageBookingCubit>()
              .state
              .manageBookingResponse
              ?.result
              ?.allPersonObject ??
          [];

      persons = NumberPerson(persons: no);

      focusedPerson =
          context.watch<ManageBookingCubit>().state.selectedPax?.personObject;
      selectedWheelchair = isDeparture
          ? focusedPerson?.departureWheelChair
          : focusedPerson?.returnWheelChair;
      okId = isDeparture
          ? focusedPerson?.departureOkId
          : focusedPerson?.returnOkId;
    } else {
      final bookingState = context.watch<BookingCubit>().state;
      final state = context.watch<SearchFlightCubit>().state;
      selectedPerson = context.watch<SelectedPersonCubit>().state;

      wheelChairGroup = bookingState.verifyResponse?.flightSSR?.wheelChairGroup;

      wheelChairs =
          isDeparture ? wheelChairGroup?.outbound : wheelChairGroup?.inbound;

      persons = state.filterState?.numberPerson;
      focusedPerson = persons?.persons
          .firstWhereOrNull((element) => element == selectedPerson);

      selectedWheelchair = isDeparture
          ? focusedPerson?.departureWheelChair
          : focusedPerson?.returnWheelChair;
      okId = isDeparture
          ? focusedPerson?.departureOkId
          : focusedPerson?.returnOkId;
    }

    return Padding(
      padding: isManageBooking ? EdgeInsets.zero : kPageHorizontalPadding,
      child: Visibility(
        visible: wheelChairs?.isNotEmpty ?? false,
        replacement: const EmptyAddon(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isManageBooking == false) ...[
              PassengerSelector(
                isDeparture: isDeparture,
                addonType: AddonType.special,
              ),
              kVerticalSpacer,
            ],
            wheelChairs?.isEmpty ?? true
                ? Center(
                    child: Text(
                      "noWheelchairAvailable".tr(),
                      style: kLargeHeavy,
                    ),
                  )
                : isManageBooking
                    ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: buildColumn(selectedWheelchair, manageBookingCubit,
                          focusedPerson, wheelChairs, context, okId),
                    )
                    : AppCard(
                        edgeInsets: const EdgeInsets.all(12),
                        child: buildColumn(
                            selectedWheelchair,
                            manageBookingCubit,
                            focusedPerson,
                            wheelChairs,
                            context,
                            okId),
                      ),
            if (isManageBooking) ...[
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                color: const Color.fromRGBO(241, 241, 241, 1.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      kVerticalSpacerSmall,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${'specialAddOn'.tr()}\n${'flightCharge.total'.tr()}',
                            style: kHugeSemiBold.copyWith(color: Styles.kTextColor),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          MoneyWidget(
                            amount:
                            manageBookingCubit?.notConfirmedWheelChairTotalPrice ??
                                0.0,
                            isDense: true,
                            isNormalMYR: true,
                          ),
                        ],
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
                                manageBookingCubit?.wheelChairConfirmSeatChange();

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
                      SizedBox(
                        height: 16
                      ),

                    ],
                  ),
                ),
              ),
              kVerticalSpacer,
            ],
          ],
        ),
      ),
    );
  }

  Column buildColumn(
      Bundle? selectedWheelchair,
      ManageBookingCubit? manageBookingCubit,
      Person? focusedPerson,
      List<Bundle>? wheelChairs,
      BuildContext context,
      String? okId) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCheckBox(
              checkBoxSize: 18,
              checkedFillColor: Styles.kActiveGrey,
              borderColor: Styles.kActiveGrey,
              value: selectedWheelchair != null,
              onChanged: (value) {
                if (isManageBooking) {
                  manageBookingCubit?.addWheelToPerson(value ?? false,
                      focusedPerson, (wheelChairs ?? []).last, isDeparture);

                  return;
                }

                print("value is $value");
                if (value) {
                  context
                      .read<SearchFlightCubit>()
                      .addWheelChairToPersonPartial(
                        person: focusedPerson,
                        wheelChairs: wheelChairs ?? [],
                        isDeparture: isDeparture,
                        okId: okId,
                      );
                } else {
                  context
                      .read<SearchFlightCubit>()
                      .addWheelChairToPersonPartial(
                        person: focusedPerson,
                        wheelChairs: [],
                        isDeparture: isDeparture,
                        okId: okId,
                      );
                }
              },
            ),
            kHorizontalSpacerMini,
            Image.asset("assets/images/design/wheelchair.png", height: 32),
            kHorizontalSpacerSmall,
            Expanded(
              child: Text(
                "wheelChair".tr(),
                style: kLargeMedium,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              left: isManageBooking ? 0 : 50.0,
              top: 10,
              right: isManageBooking ? 0 : 50),
          child: Visibility(
            visible: selectedWheelchair != null,
            child: BorderedAppInputText(
              key: Key("${focusedPerson.toString()}okId"),
              name: "${focusedPerson.toString()}okId",
              hintText: "specialSelection.disabledIDCard".tr(),
              initialValue: okId,
              onChanged: (id) {
                if (isManageBooking) {
                  manageBookingCubit?.addWheelId(
                      true, focusedPerson, isDeparture, id ?? '');
//value ?? false, focusedPerson, (wheelChairs ?? []).first, isDeparture
                  return;
                }
                context.read<SearchFlightCubit>().addWheelChairToPersonPartial(
                      person: focusedPerson,
                      wheelChairs: wheelChairs ?? [],
                      isDeparture: isDeparture,
                      okId: id,
                    );
              },
            ),
          ),
        ),
        if (this.isManageBooking) ...[
          SizedBox(
            height: 16,
          ),
        ],
      ],
    );
  }

  Column buildMealCards(List<Bundle>? bundles, bool isDeparture) {
    bundles?.removeWhere(
        (element) => element.ssrCode == null || element.ssrCode == '');
    return Column(
      children: [
        ...bundles?.map(
              (e) {
                print("wheelchair is ${e.toJson()}");
                return Column(
                  children: [
                    Text(e.description ?? ""),
                  ],
                );
              },
            ).toList() ??
            []
      ],
    );
  }
}

class NewMealCard extends StatelessWidget {
  final Bundle meal;
  final bool isDeparture;

  const NewMealCard({Key? key, required this.meal, required this.isDeparture})
      : super(key: key);

  changeNumber(
      BuildContext context, Person? person, bool isAdd, bool isDeparture) {
    context.read<SearchFlightCubit>().addOrRemoveMealFromPerson(
          isDeparture: isDeparture,
          isAdd: isAdd,
          person: person,
          meal: meal,
        );
  }

  @override
  Widget build(BuildContext context) {
    final selectedPerson = context.watch<SelectedPersonCubit>().state;
    final state = context.watch<SearchFlightCubit>().state;
    final persons = state.filterState?.numberPerson;
    final focusedPerson = persons?.persons
        .firstWhereOrNull((element) => element == selectedPerson);
    final isDeparture = context.watch<IsDepartureCubit>().state;
    final meals =
        isDeparture ? focusedPerson?.departureMeal : focusedPerson?.returnMeal;
    final length = meals?.where((element) => element == meal).length;
    final cmsMeals = context.watch<CmsSsrCubit>().state.mealGroups;
    //const mealSoldOut = false;
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
                    child: AppImage(
                      imageUrl: cmsMeals
                          .firstWhereOrNull(
                              (element) => element.code == meal.codeType)
                          ?.image,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      kVerticalSpacer,
                      Text(
                        meal.description ?? "",
                        style: kHugeRegular,
                      ),
                      kVerticalSpacer,
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
                ),
                kVerticalSpacer,
              ],
            ),
            // if (mealSoldOut)
            //   ClipRect(
            //     child: BackdropFilter(
            //       filter: ImageFilter.blur(sigmaX: 1.8, sigmaY: 1.8),
            //       child: Container(
            //         color: Colors.grey.shade200.withOpacity(0.1),
            //         child: Center(
            //           child: Text(
            //             "Sold Out",
            //             style:
            //                 kGiantHeavy.copyWith(color: Styles.kPrimaryColor),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
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

  const InputWithPlusMinus({
    Key? key,
    required this.number,
    required this.handler,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDeparture = context.watch<IsDepartureCubit>().state;

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
          Text(
            "oneHourWarning".tr(),
            style: kHugeHeavy,
            textAlign: TextAlign.center,
          ),
          kVerticalSpacerSmall,
          Padding(
            padding: kPageHorizontalPaddingBig,
            child: Text(
              "buyMunchiesOnBoard".tr(),
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
    return Padding(
      padding: kPageHorizontalPadding,
      child: Column(
        children: [
          kVerticalSpacer,
          Text(
            'flight24warning'.tr(),
            style: kHugeHeavy,
            textAlign: TextAlign.center,
          ),
          kVerticalSpacerSmall,
          Padding(
            padding: kPageHorizontalPaddingBig,
            child: Text(
              "buyMunchiesOnBoard".tr(),
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
