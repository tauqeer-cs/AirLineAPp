import 'package:app/app/app_router.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/add_on/meals/ui/meals_section.dart';
import 'package:app/pages/add_on/meals/ui/meals_subtotal.dart';
import 'package:app/pages/add_on/ui/flight_detail_widget.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/pages/search_result/ui/summary_container_listener.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MealsView extends StatefulWidget {
  final bool isDeparture;
  const MealsView({Key? key, this.isDeparture = true}) : super(key: key);

  @override
  State<MealsView> createState() => _MealsViewState();
}

class _MealsViewState extends State<MealsView> {
  final scrollController = ScrollController();
  bool isScrollable = false;

  void afterBuild() {
    if (scrollController.hasClients) {
      setState(() {
        isScrollable = scrollController.position.extentAfter > 0;
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild());
    final flightType =
        context.watch<SearchFlightCubit>().state.filterState?.flightType;

    return BlocProvider(
      create: (context) =>
          IsDepartureCubit()..changeDeparture(widget.isDeparture),
      child: Stack(
        children: [
          SummaryContainerListener(
            scrollController: scrollController,
            child: ListView(
              controller: scrollController,
              shrinkWrap: true,
              children: [
                kVerticalSpacer,
                FlightDetailWidget(isDeparture: widget.isDeparture),
                kVerticalSpacer,
                MealsSection(isDeparture: widget.isDeparture),
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
                kSummaryContainerSpacing,
                kSummaryContainerSpacing,
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: MealsSubtotal(
              isDeparture: widget.isDeparture,
              child: SummaryContainer(
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
            ),
          ),
        ],
      ),
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
          context.router.push(MealsRoute(isDeparture: false));
        } else {
          context.router.push(BaggageRoute());
        }
      },
      child: const Text("Continue"),
    );
  }
}
