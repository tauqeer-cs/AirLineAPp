import 'package:app/app/app_router.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/add_on/meals/ui/meals_section.dart';
import 'package:app/pages/add_on/meals/ui/meals_subtotal.dart';
import 'package:app/pages/add_on/seats/ui/seats_view.dart';
import 'package:app/pages/add_on/ui/flight_detail_widget.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/pages/search_result/ui/summary_container_listener.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../checkout/bloc/selected_person_cubit.dart';

class MealsView extends StatefulWidget {
  final bool isDeparture;

  const MealsView({Key? key, this.isDeparture = true}) : super(key: key);

  @override
  State<MealsView> createState() => _MealsViewState();
}

class _MealsViewState extends State<MealsView> {
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
                TitleSummaryHeader(title: "meal".tr()),
                kVerticalSpacer,
                FlightDetailWidget(
                  isDeparture: widget.isDeparture,
                  addonType: AddonType.meal,
                ),
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
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final numberOfPerson = filter?.numberPerson;
    List<Person> persons = List<Person>.from(numberOfPerson?.persons ?? []);
    final book = context.watch<BookingCubit>();
    var baggagesOut =
        book.state.verifyResponse?.flightSSR?.baggageGroup?.outbound;

    var sportOutBound =
        book.state.verifyResponse?.flightSSR?.sportGroup?.outbound;

    bool isTwoWay = false;

    if (flightType?.message != "One Way") {

      isTwoWay = true;

      print('object');
    }

    var searchFlightCupit = context.read<SearchFlightCubit>();

    return ElevatedButton(
      onPressed: () {
        /*
        for (var currentPerson in persons) {
          if (currentPerson.peopleType != PeopleType.infant) {
            if (currentPerson.departureBaggage == null) {
              searchFlightCupit.addBaggageToPerson(
                  currentPerson, baggagesOut?.first, true);
            }

            if (currentPerson.departureSports == null) {
              searchFlightCupit.addSportEquipmentToPerson(
                  currentPerson, sportOutBound?.first, true);
            }


            if (isTwoWay) {
              if (currentPerson.returnBaggage == null) {
                var inBound =
                    book.state.verifyResponse?.flightSSR?.baggageGroup?.inbound;


                searchFlightCupit.addBaggageToPerson(
                    currentPerson, inBound?.first, false);
              }

              if (currentPerson.returnSports == null) {
                var inBound =
                    book.state.verifyResponse?.flightSSR?.sportGroup?.inbound;


                searchFlightCupit.addSportEquipmentToPerson(
                    currentPerson, inBound?.first, false);
              }


            }
          } else {}
        }
        */
        if (flightType == FlightType.round && isDeparture) {
          context.router.push(MealsRoute(isDeparture: false));
        } else {
          context.router.push(BaggageRoute());
        }

        if (persons.isNotEmpty) {
          context.read<SelectedPersonCubit>().selectPerson(persons.first);
        }
      },
      child: Text("continue".tr()),
    );
  }
}
