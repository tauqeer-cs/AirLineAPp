import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/data/requests/update_insurance_request.dart';
import 'package:app/pages/checkout/pages/booking_details/bloc/summary_cubit.dart';
import 'package:app/pages/checkout/pages/insurance/bloc/insurance_cubit.dart';
import 'package:app/pages/checkout/pages/insurance/ui/available_insurance.dart';
import 'package:app/pages/checkout/pages/insurance/ui/insurance_terms.dart';
import 'package:app/pages/checkout/pages/insurance/ui/zurich_container.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/pages/search_result/ui/summary_container_listener.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/app_router.dart';
import '../../../../../blocs/cms/agent_sign_up/agent_sign_up_cubit.dart';
import '../../../../../data/requests/flight_summary_pnr_request.dart';
import '../../../../../data/responses/verify_response.dart';
import '../../../ui/empty_addon.dart';

class InsuranceView extends StatefulWidget {
  final bool isManageBooking;

  const InsuranceView({Key? key, this.isManageBooking = false})
      : super(key: key);

  @override
  State<InsuranceView> createState() => _InsuranceViewState();
}

class _InsuranceViewState extends State<InsuranceView> {
  final scrollController = ScrollController();

  bool resetInsurance = false;

  InsuranceCubit? insuranceCubit;
  BundleGroupSeat? insuranceGroup;

  void resetData() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    if (insuranceCubit != null) {
      insuranceCubit?.setLast(insuranceGroup?.outbound?.firstWhereOrNull(
          (element) => element == insuranceGroup?.outbound?.first));
    }
  }

  @override
  void initState() {
    super.initState();

    resetData();
  }

  @override
  Widget build(BuildContext context) {
    BundleGroupSeat? insuranceGroup;
    List<Passenger> passengers = [];
    List<Bundle> insurances = [];
    Bundle? firstInsurance;
    final insuranceState = context.watch<InsuranceCubit>().state;
    if (widget.isManageBooking) {
    } else {
      final bookingState = context.watch<BookingCubit>().state;
      insuranceGroup = bookingState.verifyResponse?.flightSSR?.insuranceGroup;

      insuranceCubit = context.watch<InsuranceCubit>();

      passengers = insuranceState.passengers;

      insurances =
          bookingState.verifyResponse?.flightSSR?.insuranceGroup?.outbound ??
              [];

      firstInsurance = insurances.firstOrNull;
    }

    String? logoImage = '';
    if ((insurances ?? []).isNotEmpty) {
      final agentCms = context.watch<AgentSignUpCubit>().state;

      String insuranceCode = firstInsurance?.codeType ?? '';

      if (agentCms.locationItem != null) {
        if (agentCms.locationItem?.items
                ?.where((e) => e.code == insuranceCode)
                .toList()
                .isNotEmpty ==
            true) {
          logoImage = agentCms.locationItem?.banner;
        }
      }

      if ((logoImage ?? '').isEmpty) {
        if (agentCms.internationalItem != null) {
          if (agentCms.internationalItem?.items
                  ?.where((e) => e.code == insuranceCode)
                  .toList()
                  .isNotEmpty ==
              true) {
            logoImage = agentCms.internationalItem?.banner;
          }
        }
      }

      if ((logoImage ?? '').isEmpty) {
        if (insuranceCode.contains('DL')) {
          logoImage = agentCms.locationItem?.banner;
        }
      }

      if ((logoImage ?? '').isEmpty) {
        logoImage = agentCms.internationalItem?.banner;
      }
    }

     bool hasSeat = false;

    var seat = passengers.firstWhereOrNull((e) => e.seat != null)?.seat;
    if(seat != null) {
      hasSeat = true;

    }

    return Stack(
      children: [
        SummaryContainerListener(
          scrollController: scrollController,
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              if (insurances.isNotEmpty && hasSeat == false) ...[
                Text(
                  "myAirTravelInsurance".tr(),
                  style: kHugeHeavy,
                ),
                kVerticalSpacer,
                ZurichContainer(
                  bannerImageUrl: logoImage,
                ),
                kVerticalSpacer,
                AvailableInsurance(
                  isManageBooking: widget.isManageBooking,
                ),
                InsuranceTerms(
                  isInternational:
                      firstInsurance?.codeType?.contains('SL') == true,
                ),
                kSummaryContainerSpacing,
                kSummaryContainerSpacing,
              ] else ...[
                //icoNoInsurance

                EmptyAddon(
                  icon: "assets/images/icons/icoNoInsurance.png",
                  customText: 'insuranceTempUnavailable'.tr(),
                ),
              ],
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SummaryContainer(
            child: Padding(
              padding: kPagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BookingSummary(
                      additionalNumber: insuranceState.totalInsurance()),
                  ElevatedButton(
                    onPressed: () {

                      if(hasSeat) {
                        context.router.push(const PaymentRoute());
                        return;

                      }
                      final bookingState = context.read<BookingCubit>().state;
                      final token = bookingState.verifyResponse?.token;
                      if (token == null) {
                        Toast.of(context).show(message: "Token is empty");
                        return;
                      }
                      final summaryRequest = InsuranceRequest(
                          token: token,
                          updateInsuranceRequest: UpdateInsuranceRequest(
                            isRemoveInsurance: true,
                            passengers: context
                                .read<InsuranceCubit>()
                                .state
                                .passengersWithOutInfants,
                          ));

                      InsuranceRequest insuranceRequests2 = summaryRequest.copyWith();

                      List<Passenger> allPassengers = [];

                      var updateInsuranceRequest = insuranceRequests2.updateInsuranceRequest;


                      for(Passenger currentItem in insuranceRequests2.updateInsuranceRequest?.passengers ?? []) {

                        allPassengers.add(currentItem.copyWithNull(seat: true));
                      }

                      var cc1 = insuranceRequests2.updateInsuranceRequest?.copyWith(passengers:allPassengers );
                      var finalrequest = summaryRequest.copyWith(updateInsuranceRequest: cc1);



                      context
                          .read<SummaryCubit>()
                          .submitUpdateInsurance(finalrequest);
                    },
                    child: Text(
                      "continue".tr(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
