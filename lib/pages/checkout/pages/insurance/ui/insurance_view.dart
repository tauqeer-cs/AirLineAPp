import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/data/requests/summary_request.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InsuranceView extends StatefulWidget {
  const InsuranceView({Key? key}) : super(key: key);

  @override
  State<InsuranceView> createState() => _InsuranceViewState();
}

class _InsuranceViewState extends State<InsuranceView> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final passengers = context.watch<InsuranceCubit>().state.passengers;
    double totalInsurance = 0;
    for (var element in passengers) {
      totalInsurance = totalInsurance + (element.getInsurance?.price ?? 0);
    }
    print("total insurance is $totalInsurance");
    return Stack(
      children: [
        SummaryContainerListener(
          scrollController: scrollController,
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              Text(
                "MYAirline Travel Insurance",
                style: kHugeHeavy,
              ),
              kVerticalSpacer,
              ZurichContainer(),
              kVerticalSpacer,
              AvailableInsurance(),
              InsuranceTerms(),
              kSummaryContainerSpacing,
              kSummaryContainerSpacing,
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
                  BookingSummary(additionalNumber: totalInsurance),
                  ElevatedButton(
                    onPressed: () {
                      final bookingState = context.read<BookingCubit>().state;
                      final token = bookingState.verifyResponse?.token;
                      if(token == null){
                        Toast.of(context).show(message: "Token is empty");
                        return;
                      }
                      final summaryRequest = InsuranceRequest(
                        token: token,
                        updateInsuranceRequest: UpdateInsuranceRequest(
                          isRemoveInsurance: false,
                          passengers: context.read<InsuranceCubit>().state.passengers,
                        )
                      );
                      context
                          .read<SummaryCubit>()
                          .submitUpdateInsurance(summaryRequest);
                    },
                    child: const Text("Continue"),
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
