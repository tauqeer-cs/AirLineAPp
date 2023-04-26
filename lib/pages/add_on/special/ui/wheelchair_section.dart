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

class WheelchairSection extends StatelessWidget {
  final bool isDeparture;

  const WheelchairSection({Key? key, this.isDeparture = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedPerson = context.watch<SelectedPersonCubit>().state;
    final bookingState = context.watch<BookingCubit>().state;
    final state = context.watch<SearchFlightCubit>().state;
    final wheelChairGroup =
        bookingState.verifyResponse?.flightSSR?.wheelChairGroup;
    final wheelChairs =
    isDeparture ? wheelChairGroup?.outbound : wheelChairGroup?.inbound;
    final persons = state.filterState?.numberPerson;
    final focusedPerson = persons?.persons
        .firstWhereOrNull((element) => element == selectedPerson);
    final selectedWheelchair = isDeparture
        ? focusedPerson?.departureWheelChair
        : focusedPerson?.returnWheelChair;
    final okId =
    isDeparture ? focusedPerson?.departureOkId : focusedPerson?.returnOkId;
    print("rebuild here $okId");
    print("selectedWheelchair $selectedWheelchair");

    return Padding(
      padding: kPageHorizontalPadding,
      child: Visibility(
        visible: wheelChairs?.isNotEmpty ?? false,
        replacement: EmptyAddon(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PassengerSelector(
              isDeparture: isDeparture,
              addonType: AddonType.special,
            ),
            kVerticalSpacer,
            wheelChairs?.isEmpty ?? true
                ? Center(child: Text("No available wheelchair", style: kLargeHeavy,))
                : AppCard(
              edgeInsets: EdgeInsets.all(12),
              child: Column(
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
                      Image.asset("assets/images/design/wheelchair.png",
                          height: 32),
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
                    padding: const EdgeInsets.only(left: 50.0, top: 10),
                    child: Visibility(
                      visible: selectedWheelchair != null,
                      child: BorderedAppInputText(
                        key: Key("${focusedPerson.toString()}okId"),
                        name: "${focusedPerson.toString()}okId",
                        hintText: "Disabled ID Card No (Optional)",
                        initialValue: okId,
                        onChanged: (id) {
                          context
                              .read<SearchFlightCubit>()
                              .addWheelChairToPersonPartial(
                            person: focusedPerson,
                            wheelChairs: wheelChairs ?? [],
                            isDeparture: isDeparture,
                            okId: id,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildMealCards(List<Bundle>? bundles, bool isDeparture) {
    bundles?.removeWhere((element) => element.serviceID == 0);
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
    return Padding(
      padding: kPageHorizontalPadding,
      child: Column(
        children: [
          kVerticalSpacer,
          const Text(
            "Oh, your flight will depart within 24 hours.",
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
