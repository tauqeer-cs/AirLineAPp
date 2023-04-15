import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/pages/checkout/pages/insurance/bloc/insurance_cubit.dart';
import 'package:app/pages/checkout/pages/insurance/ui/passenger_insurance_selector.dart';
import 'package:app/pages/checkout/ui/empty_addon.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/requests/flight_summary_pnr_request.dart';

class AvailableInsurance extends StatelessWidget {
  const AvailableInsurance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final insuranceCubit = context.watch<InsuranceCubit>().state;
    final selected = insuranceCubit.insuranceType;

    final bookingState = context.watch<BookingCubit>().state;
    final passengers = insuranceCubit.passengers;
    final insurances =
        bookingState.verifyResponse?.flightSSR?.insuranceGroup?.outbound ?? [];
    final selectedPassengers = insuranceCubit.selectedPassenger;
    final firstInsurance = insurances.firstOrNull;
    return Visibility(
      visible: insurances.isNotEmpty,
      replacement: EmptyAddon(),
      child: Column(
        children: InsuranceType.values
            .map(
              (e) => InkWell(
                onTap: () {
                  final bookingState = context.read<BookingCubit>().state;
                  final firstInsurance = bookingState.verifyResponse?.flightSSR
                      ?.insuranceGroup?.outbound?.firstOrNull;
                  if (firstInsurance == null) return;
                  print("first insurance not null $e");
                  context.read<InsuranceCubit>().changeInsuranceType(
                      e, firstInsurance.toBound(isInsurance: true));
                },
                child: AppCard(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Styles.kActiveGrey,
                            ),
                            child: IgnorePointer(
                              ignoring: true,
                              child: Radio<InsuranceType?>(
                                value: e,
                                visualDensity: const VisualDensity(
                                  horizontal: -2,
                                  vertical: -2,
                                ),
                                activeColor: Styles.kActiveGrey,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                groupValue: selected,
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                          kHorizontalSpacerSmall,
                          Expanded(
                            child:
                                getTitle(e, firstInsurance, passengers.length),
                          ),
                          kHorizontalSpacerSmall,
                          SizedBox(
                            height: 56,
                            width: 56,
                            child: getAssets(e) == null
                                ? SizedBox()
                                : Image.asset(getAssets(e)!),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: e == selected && e != InsuranceType.none,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Column(
                            children: [
                              Visibility(
                                visible: e == InsuranceType.selected,
                                child: const PassengerInsuranceSelector(),
                              ),
                              ...insurances.map(
                                (e) {
                                  final bound = e.toBound(isInsurance: true);
                                  return InkWell(
                                    onTap: () {
                                      print("update insurance");
                                      if (selected == InsuranceType.all) {
                                        context
                                            .read<InsuranceCubit>()
                                            .updateInsuranceToAllPassenger(
                                                bound);
                                      } else {

                                        Bound? currentInsurance = passengers[selectedPassengers]
                                            .getInsurance;

                                        if(currentInsurance == null) {
                                          context
                                              .read<InsuranceCubit>()
                                              .updateInsuranceToPassenger(
                                              selectedPassengers, bound);
                                        }
                                        else {
                                          context
                                              .read<InsuranceCubit>()
                                              .updateInsuranceToPassenger(
                                              selectedPassengers, null);
                                        }

                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Styles.kDisabledButton)),
                                      child: Column(
                                        children: [
                                          Text(
                                            e.description ?? "",
                                            style: kLargeHeavy,
                                          ),
                                          kVerticalSpacer,
                                          MoneyWidgetCustom(
                                            myrSize: 20,
                                            amountSize: 20,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            textColor: Styles.kPrimaryColor,
                                            amount: e.finalAmount,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          kVerticalSpacer,
                                          IgnorePointer(
                                            ignoring: true,
                                            child: Radio<Bound?>(
                                              value: bound,
                                              visualDensity:
                                                  const VisualDensity(
                                                horizontal: -2,
                                                vertical: -2,
                                              ),
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              groupValue:
                                                  passengers[selectedPassengers]
                                                      .getInsurance,
                                              onChanged: (value) {},
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ).toList()
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  RichText getTitle(
      InsuranceType insuranceType, Bundle? insurance, int numOfPassengers) {
    switch (insuranceType) {
      case InsuranceType.all:
        return RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'For ',
                style: kMediumMedium.copyWith(color: Styles.kTextColor),
              ),
              TextSpan(
                text: 'ALL ',
                style: kMediumHeavy.copyWith(color: Styles.kTextColor),
              ),
              TextSpan(
                text: 'passengers: ',
                style: kMediumMedium.copyWith(color: Styles.kTextColor),
              ),
              TextSpan(
                text:
                    '${insurance?.currencyCode ?? "MYR"} ${((insurance?.finalAmount ?? 0) * numOfPassengers)}',
                style: kMediumHeavy.copyWith(color: Styles.kTextColor),
              ),
            ],
          ),
        );
      case InsuranceType.selected:
        return RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'For ',
                style: kMediumMedium.copyWith(color: Styles.kTextColor),
              ),
              TextSpan(
                text: 'selected ',
                style: kMediumHeavy.copyWith(color: Styles.kTextColor),
              ),
              TextSpan(
                text: 'passengers.',
                style: kMediumMedium.copyWith(color: Styles.kTextColor),
              ),
            ],
          ),
        );
      case InsuranceType.none:
        return RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'I do not need any travel insurance.',
                style: kMediumMedium.copyWith(color: Styles.kTextColor),
              ),
            ],
          ),
        );
    }
  }

  String? getAssets(InsuranceType insuranceType) {
    switch (insuranceType) {
      case InsuranceType.all:
        return "assets/images/icons/insurance_all.png";
      case InsuranceType.selected:
        return "assets/images/icons/insurance_single.png";
      case InsuranceType.none:
        return null;
    }
  }
}
