import 'package:app/app/app_router.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/add_on/baggage/ui/baggage_section.dart';
import 'package:app/pages/add_on/baggage/ui/baggage_subtotal.dart';
import 'package:app/pages/add_on/seats/ui/seats_view.dart';
import 'package:app/pages/add_on/ui/flight_detail_widget.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/pages/search_result/ui/summary_container_listener.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:app/utils/user_insider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_insider/flutter_insider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../checkout/bloc/selected_person_cubit.dart';

class BaggageView extends StatefulWidget {
  final bool isDeparture;

  const BaggageView({Key? key, this.isDeparture = true}) : super(key: key);

  @override
  State<BaggageView> createState() => _BaggageViewState();
}

class _BaggageViewState extends State<BaggageView>
    with TickerProviderStateMixin {
  final scrollController = ScrollController();
  final bool autoScrollToBottom = false;

  @override
  void dispose() {
    scrollController.dispose(); // dispose the controller
    super.dispose();
  }

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
                TitleSummaryHeader(title: 'baggage'.tr()),
                kVerticalSpacer,
                FlightDetailWidget(
                  isDeparture: widget.isDeparture,
                  addonType: AddonType.baggage,
                ),
                kVerticalSpacer,
                BaggageSection(
                  isDeparture: widget.isDeparture,
                  moveToTop: () {
                    if (scrollController.hasClients) {
                      scrollController.animateTo(50,
                          duration: const Duration(seconds: 1),
                          curve: Curves.linear);
                    }
                  },
                  moveToBottom: () {
                    if (autoScrollToBottom) {
                      if (scrollController.hasClients) {
                        scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: const Duration(seconds: 3),
                            curve: Curves.linear);
                      }
                    }
                  },
                ),
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
                        child: const FaIcon(
                          FontAwesomeIcons.angleUp,
                          size: 25,
                        ),
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
            child: BaggageSubtotal(
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
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final numberOfPerson = filter?.numberPerson;

    List<Person> persons = List<Person>.from(numberOfPerson?.persons ?? []);


    return ElevatedButton(
      onPressed: () async {
        if (flightType == FlightType.round && isDeparture) {
          context.router.push(BaggageRoute(isDeparture: false));
        } else {
          context.router.push(SpecialRoute(isDeparture: true));
        }

        if(persons.isNotEmpty) {
          context.read<SelectedPersonCubit>().selectPerson(persons.first);
        }

      },
      child: Text("continue".tr()),
    );
  }
}
