import 'package:app/app/app_router.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/add_on/bundle/ui/bundle_section.dart';
import 'package:app/pages/add_on/ui/flight_detail_widget.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BundleView extends StatefulWidget {
  final bool isDeparture;

  const BundleView({Key? key, this.isDeparture = true}) : super(key: key);

  @override
  State<BundleView> createState() => _BundleViewState();
}

class _BundleViewState extends State<BundleView> {
  final scrollController = ScrollController();
  bool isScrollable = false;



  @override
  Widget build(BuildContext context) {
    final flightType =
        context.watch<SearchFlightCubit>().state.filterState?.flightType;
    return Column(
      children: [
        Expanded(
          child: ListView(
            controller: scrollController,
            shrinkWrap: true,
            children: [
              kVerticalSpacer,
              FlightDetailWidget(isDeparture: widget.isDeparture),
              kVerticalSpacer,
              BundleSection(isDeparture: widget.isDeparture),
              kVerticalSpacer,
              Stack(
                children: [
                  const CheckoutSummary(),
                  Positioned(
                    bottom: 0,
                    right: 15,
                    child: FloatingActionButton(
                      onPressed: () {
                        scrollController.animateTo(
                          scrollController.position.minScrollExtent,
                          duration: const Duration(seconds: 1),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                      backgroundColor: Styles.kPrimaryColor,
                      child: const Icon(Icons.keyboard_arrow_up),
                    ),
                  )
                ],
              ),
              kVerticalSpacer,
              SummaryContainer(
                child: Padding(
                  padding: kPagePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const BookingSummary(),
                      ContinueButton(
                        flightType: flightType,
                        isDeparture: widget.isDeparture,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        /* if (!isScrollable)
          SummaryContainer(
            child: Padding(
              padding: kPagePadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const BookingSummary(),
                  ContinueButton(
                    flightType: flightType,
                    isDeparture: widget.isDeparture,
                  ),
                ],
              ),
            ),
          ),*/
      ],
    );
  }
}

class ContinueButton extends StatelessWidget {
  final FlightType? flightType;
  final bool isDeparture;

  const ContinueButton({
    Key? key,
    required this.flightType,
    required this.isDeparture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (flightType == FlightType.round && isDeparture) {
          context.router.push(BundleRoute(isDeparture: false));
        } else {
          context.router.push(SeatsRoute());
        }
      },
      child: const Text("Continue"),
    );
  }
}
