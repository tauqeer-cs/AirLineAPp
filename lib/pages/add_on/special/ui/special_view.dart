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
import 'package:app/widgets/app_loading_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_insider/flutter_insider.dart';
import 'package:line_icons/line_icon.dart';

import '../../../checkout/bloc/selected_person_cubit.dart';

class SpecialView extends StatefulWidget {
  final bool isDeparture;

  const SpecialView({Key? key, this.isDeparture = true}) : super(key: key);

  @override
  State<SpecialView> createState() => _SpecialViewState();
}

class _SpecialViewState extends State<SpecialView> {
  final scrollController = ScrollController();

  bool showAppLoader = false;

  @override
  Widget build(BuildContext context) {
    final flightType =
        context.watch<SearchFlightCubit>().state.filterState?.flightType;
    return showAppLoader
        ? AppLoading()
        : BlocProvider(
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
                      TitleSummaryHeader(title: "specialAddOn".tr()),
                      kVerticalSpacer,
                      FlightDetailWidget(
                        isDeparture: widget.isDeparture,
                        addonType: AddonType.special,
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
                              startShowingLoader: () {
                                setState(() {
                                  showAppLoader = true;
                                });

                              },
                              stopShowingLoader: () {
                                setState(() {
                                  showAppLoader = false;
                                });

                              },
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

  final VoidCallback startShowingLoader;
  final VoidCallback stopShowingLoader;

  const ContinueButton({
    Key? key,
    required this.flightType,
    required this.isDeparture,
    required this.startShowingLoader,
    required this.stopShowingLoader,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<SearchFlightCubit>().state.filterState;
    final numberOfPerson = filter?.numberPerson;
    List<Person> persons = List<Person>.from(numberOfPerson?.persons ?? []);

    return ElevatedButton(
      onPressed: () async {
        if (flightType == FlightType.round && isDeparture) {
          context.router.push(SpecialRoute(isDeparture: false));
        } else {
          FlutterInsider.Instance.visitProductDetailPage(
              UserInsider.of(context).generateProduct());
          var response = await context.router.push(const BookingDetailsRoute());
          if (response == true) {
            //startShowingLoader();
            await Future.delayed(const Duration(seconds: 1));
            //stopShowingLoader();

            context.router.push(const BookingDetailsRoute());

            if (persons.isNotEmpty) {
              context.read<SelectedPersonCubit>().selectPerson(persons.first);
            }

          }
        }
      },
      child: Text("continue".tr()),
    );
  }
}
