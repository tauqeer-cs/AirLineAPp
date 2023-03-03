import 'package:app/app/app_router.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/add_on/meals/ui/meals_section.dart';
import 'package:app/pages/add_on/meals/ui/meals_subtotal.dart';
import 'package:app/pages/add_on/seats/ui/seats_view.dart';
import 'package:app/pages/add_on/special/ui/special_addon_subtotal.dart';
import 'package:app/pages/add_on/special/ui/wheelchair_section.dart';
import 'package:app/pages/add_on/ui/flight_detail_widget.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/pages/search_result/ui/summary_container_listener.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:app/utils/user_insider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_insider/flutter_insider.dart';

class SpecialView extends StatefulWidget {
  final bool isDeparture;

  const SpecialView({Key? key, this.isDeparture = true}) : super(key: key);

  @override
  State<SpecialView> createState() => _SpecialViewState();
}

class _SpecialViewState extends State<SpecialView> {
  final scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
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
                const TitleSummaryHeader(title: "Special Add-On"),
                kVerticalSpacer,
                FlightDetailWidget(
                  isDeparture: widget.isDeparture,
                  addonType: AddonType.meal,
                ),
                kVerticalSpacer,
                WheelchairSection(isDeparture: widget.isDeparture),
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
            child: SpecialAddonSubtotal(
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
          context.router.push(SpecialRoute(isDeparture: false));
        } else {
          context.router.push(const BookingDetailsRoute());
          FlutterInsider.Instance.visitProductDetailPage(UserInsider.of(context).generateProduct());
        }
      },
      child: const Text("Continue"),
    );
  }
}
