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
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../blocs/cms/agent_sign_up/agent_sign_up_cubit.dart';
import '../../../../../data/responses/verify_response.dart';
import '../../../ui/empty_addon.dart';

class InsuranceView extends StatefulWidget {
  const InsuranceView({Key? key}) : super(key: key);

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
    final bookingState = context.watch<BookingCubit>().state;

    insuranceGroup = bookingState.verifyResponse?.flightSSR?.insuranceGroup;

    insuranceCubit = context.watch<InsuranceCubit>();

    final insuranceState = context.watch<InsuranceCubit>().state;
    final passengers = insuranceState.passengers;

    final insurances =
        bookingState.verifyResponse?.flightSSR?.insuranceGroup?.outbound ?? [];

    final firstInsurance = insurances.firstOrNull;

    String? logoImage = '';
    if(insurances.isNotEmpty) {
      final agentCms = context.watch<AgentSignUpCubit>().state;

      String insuranceCode = firstInsurance?.codeType ?? '';

      if(agentCms.locationItem != null) {
        if(agentCms.locationItem?.items?.where((e) => e.code == insuranceCode).toList().isNotEmpty == true){
          logoImage = agentCms.locationItem?.banner;
        }
      }

      if((logoImage ?? '').isEmpty) {
        if(agentCms.internationalItem != null) {
          if(agentCms.internationalItem?.items?.where((e) => e.code == insuranceCode).toList().isNotEmpty == true){
            logoImage = agentCms.internationalItem?.banner;
          }
        }
      }

      if((logoImage ?? '').isEmpty){
        if(insuranceCode.contains('DL')){
          logoImage = agentCms.locationItem?.banner;
        }

      }

      if((logoImage ?? '').isEmpty){
        logoImage = agentCms.internationalItem?.banner;
      }




    }

    print("insurance is ${insuranceState.totalInsurance()}");
    return Stack(
      children: [
        SummaryContainerListener(
          scrollController: scrollController,
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [

              if(insurances.isNotEmpty) ... [
                Text(
                  "myAirTravelInsurance".tr(),
                  style: kHugeHeavy,
                ),
                kVerticalSpacer,
                 ZurichContainer(bannerImageUrl: logoImage,),
                kVerticalSpacer,

                const AvailableInsurance(),

                InsuranceTerms(
                  isInternational:
                  firstInsurance?.codeType?.contains('SL') == true,
                ),
                kSummaryContainerSpacing,
                kSummaryContainerSpacing,
              ] else ... [
                //icoNoInsurance

                 EmptyAddon(icon : "assets/images/icons/icoNoInsurance.png" ,customText: 'insuranceTempUnavailable'.tr(),),
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
                      final bookingState = context.read<BookingCubit>().state;
                      final token = bookingState.verifyResponse?.token;
                      if (token == null) {
                        Toast.of(context).show(message: "Token is empty");
                        return;
                      }
                      final summaryRequest = InsuranceRequest(
                          token: token,
                          updateInsuranceRequest: UpdateInsuranceRequest(
                            isRemoveInsurance: false,
                            passengers: context
                                .read<InsuranceCubit>()
                                .state
                                .passengersWithOutInfants,
                          ));
                      context
                          .read<SummaryCubit>()
                          .submitUpdateInsurance(summaryRequest);
                    },
                    child: Text("continue".tr()),
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
