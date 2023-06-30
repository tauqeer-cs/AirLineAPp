import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/data/responses/universal_shared_settings_routes_response.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/pages/checkout/pages/insurance/bloc/insurance_cubit.dart';
import 'package:app/pages/checkout/pages/insurance/ui/passenger_insurance_selector.dart';
import 'package:app/pages/checkout/ui/empty_addon.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../../blocs/cms/agent_sign_up/agent_sign_up_cubit.dart';
import '../../../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../../../blocs/search_flight/search_flight_cubit.dart';
import '../../../../../data/requests/flight_summary_pnr_request.dart';
import '../../../../../data/responses/manage_booking_response.dart';
import '../../../../../theme/html_style.dart';
import '../../../../../utils/security_utils.dart';

class AvailableInsurance extends StatelessWidget {
  final bool isManageBooking;

  const AvailableInsurance({Key? key,  this.isManageBooking = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final insuranceBloc = context.watch<InsuranceCubit>();
    List<Bundle> insurances = [];
    Bundle? firstInsurance;
    int selectedPassengers = 0;
    Bundle? lastInsuranceSelected;
    InsuranceType? selected;
    List<Passenger> passengers = [];
    List<PassengersWithSSR> passengersWithSSR = [];
    BundleGroupSeat? insurancesGroup;

    String currency = 'MYR';

    final insuranceCubit = context.watch<InsuranceCubit>().state;

    if(isManageBooking) {
      var state = context.watch<ManageBookingCubit>().state;
      selected =  state.insuranceType;
      passengersWithSSR = state.manageBookingResponse?.result?.passengersWithSSR ?? [];
      insurances =
          state.verifyResponse?.flightSSR?.insuranceGroup?.outbound ?? [];
      insurancesGroup =
          state.verifyResponse?.flightSSR?.insuranceGroup;
      selectedPassengers = 0;
      firstInsurance = insurances.firstOrNull;

      currency = state.manageBookingResponse?.result?.superPNROrder?.currencyCode ?? 'MYR';



    }
    else {
      selected = insuranceCubit.insuranceType;
      final bookingState = context.watch<BookingCubit>().state;
      passengers = insuranceCubit.passengersWithOutInfants;
      insurancesGroup =
          bookingState.verifyResponse?.flightSSR?.insuranceGroup;
      insurances =
          bookingState.verifyResponse?.flightSSR?.insuranceGroup?.outbound ?? [];
      selectedPassengers = insuranceCubit.selectedPassenger;
      firstInsurance = insurances.firstOrNull;
      lastInsuranceSelected = insuranceCubit.lastInsuranceSelected;
      currency = context.watch<SearchFlightCubit>().state.flights?.flightResult?.requestedCurrencyOfFareQuote ?? 'MYR';

    }






    final agentCms = context.watch<AgentSignUpCubit>();


    return  Visibility(
      visible: insurances.isNotEmpty,
      replacement: const EmptyAddon(),
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
                child:  AppCard(
                  margin: const EdgeInsets.only(bottom: 10),
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
                                activeColor: Styles.kPrimaryColor,
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
                                getTitle(e, lastInsuranceSelected ?? firstInsurance,  isManageBooking ? passengersWithSSR.length :  passengers.length ),
                          ),

                          kHorizontalSpacerSmall,
                          SizedBox(
                            height: 56,
                            width: 56,
                            child: getAssets(e) == null
                                ? const SizedBox()
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
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: InkWell(
                                      onTap: () {

                                        if (selected == InsuranceType.all) {

                                          insuranceBloc.setLast(insurancesGroup?.outbound?.firstWhereOrNull((element) => element == e));



                                          context
                                              .read<InsuranceCubit>()
                                              .updateInsuranceToAllPassenger(
                                                  bound);

                                        } else {
                                          Bound? currentInsurance =
                                              passengers[selectedPassengers]
                                                  .getInsurance;


                                          if (currentInsurance == null) {

                                            context
                                                .read<InsuranceCubit>()
                                                .updateInsuranceToPassenger(
                                                    selectedPassengers, bound,e.codeType);
                                          } else {

                                            context
                                                .read<InsuranceCubit>()
                                                .updateInsuranceToPassenger(
                                                    selectedPassengers, null,e.codeType);
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
                                              dataTitle(e, agentCms),
                                              style: kLargeHeavy,
                                            ),
                                            buildSubtitle(e, agentCms),
                                            kVerticalSpacerSmall,
                                            MoneyWidgetCustom(
                                              currency: currency,
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

  static Widget buildSubtitle(Bundle e, AgentSignUpCubit? agentCms) {
    if (agentCms != null) {
      if (e.codeType?.toLowerCase().contains('d') == true) {
        Items? item = agentCms.state.locationItem?.items
            ?.firstWhereOrNull((element) => element.code == e.codeType);

        if(item != null) {
          String? cleanedHtmlString = item.description?.replaceAll(RegExp(r'>\s+<'), '><');
          return Column(
            children: [
              //item?.ssrName ?? (e.description ?? '')
              kVerticalSpacerSmall,

              Html(
                data: cleanedHtmlString ?? "",
                style: HtmlStyle.htmlStyleRed(
                  overrideColor: Styles.kTextColor,

                ),
                onLinkTap: (
                    String? url,
                    RenderContext context,
                    Map<String, String> attributes,
                    element,
                    ){
                  if (url != null) {
                    SecurityUtils.tryLaunch(
                        url);

                  }
                },
              ),
            ],
          );
        }

      } else if (e.codeType?.toLowerCase().contains('s') == true) {}

      Items? item = agentCms.state.internationalItem?.items
          ?.firstWhereOrNull((element) => element.code == e.codeType);

      if(item != null) {
        String? cleanedHtmlString = item.description?.replaceAll(RegExp(r'>\s+<'), '><');


          return Column(
            children: [
              //item?.ssrName ?? (e.description ?? '')
              kVerticalSpacerSmall,

              Html(
                data: cleanedHtmlString ?? "",
                style: HtmlStyle.htmlStyleRed(
                  overrideColor: Styles.kTextColor,

                ),
                onLinkTap: (
                    String? url,
                    RenderContext context,
                    Map<String, String> attributes,
                    element,
                    ){
                  if (url != null) {
                    SecurityUtils.tryLaunch(
                        url);

                  }
                },
              ),
            ],
          );

      }

    }

    return const SizedBox(
      height: 0,
    );
  }

  static String dataTitle(Bundle e, AgentSignUpCubit? agentCms) {
    if (agentCms != null) {
      if (e.codeType?.toLowerCase().contains('d') == true) {
        Items? item = agentCms.state.locationItem?.items
            ?.firstWhereOrNull((element) => element.code == e.codeType);

        if(item != null) {
          return item.ssrName ?? (e.description ?? '');

        }
      }
      else if (e.codeType?.toLowerCase().contains('s') == true) {
        Items? item = agentCms.state.internationalItem?.items
            ?.firstWhereOrNull((element) => element.code == e.codeType );

        if(item != null) {
          return item.ssrName ?? (e.description ?? '');

        }
      }
    }
    return e.description ?? "";
  }

  static RichText getTitle(
      InsuranceType insuranceType, Bundle? insurance, int numOfPassengers) {
    switch (insuranceType) {
      case InsuranceType.all:
        return RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: '${'for'.tr()} ',
                style: kMediumMedium.copyWith(color: Styles.kTextColor),
              ),
              TextSpan(
                text: '${'all'.tr()} ',
                style: kMediumHeavy.copyWith(color: Styles.kTextColor),
              ),
              TextSpan(
                text: '${'flightSection.passengers'.tr()}: ',
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
                text: '${'for'.tr()} ',
                style: kMediumMedium.copyWith(color: Styles.kTextColor),
              ),
              TextSpan(
                text: '${'selected'.tr()} ',
                style: kMediumHeavy.copyWith(color: Styles.kTextColor),
              ),
              TextSpan(
                text: '${'flightSection.passengers'.tr()}.',
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
                text: 'notNeedInsurance'.tr(),
                style: kMediumMedium.copyWith(color: Styles.kTextColor),
              ),
            ],
          ),
        );
    }
  }

  static String? getAssets(InsuranceType insuranceType) {
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
