import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/pages/add_on/baggage/ui/baggage_notice.dart';
import 'package:app/pages/add_on/ui/passenger_selector.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/utils/string_utils.dart';

class BaggageSection extends StatelessWidget {
  final bool isDeparture;

  VoidCallback? moveToTop;
  VoidCallback? moveToBottom;

  BaggageSection(
      {Key? key, this.isDeparture = true, this.moveToTop, this.moveToBottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingState = context.watch<BookingCubit>().state;
    final baggageGroup = bookingState.verifyResponse?.flightSSR?.baggageGroup;
    final baggages =
        isDeparture ? baggageGroup?.outbound : baggageGroup?.inbound;
    return Padding(
      padding: kPageHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Baggage",
            style: kHugeSemiBold.copyWith(color: Styles.kOrangeColor),
          ),
          kVerticalSpacer,
          PassengerSelector(
            isDeparture: isDeparture,
          ),
          kVerticalSpacer,
          buildBaggageCards(baggages, isDeparture),
          kVerticalSpacer,
          const BaggageNotice(),
          kVerticalSpacer,
        ],
      ),
    );
  }

  Column buildBaggageCards(List<Bundle>? baggages, bool isDeparture) {
    return Column(
      children: [
        ...baggages?.map(
              (e) {
                return Column(
                  children: [
                    NewBaggageCard(
                      selectedBaggage: e,
                      isDeparture: isDeparture,
                      moveToBottom: () {
                        moveToBottom?.call();
                      },
                      moveToTop: () {
                        moveToTop?.call();
                      },
                    ),
                    kVerticalSpacerSmall,
                  ],
                );
              },
            ).toList() ??
            []
      ],
    );
  }
}

class NewBaggageCard extends StatelessWidget {
  final Bundle selectedBaggage;
  final bool isDeparture;

  VoidCallback? moveToTop;
  VoidCallback? moveToBottom;

  NewBaggageCard(
      {Key? key,
      required this.selectedBaggage,
      required this.isDeparture,
      this.moveToBottom,
      this.moveToTop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedPerson = context.watch<SelectedPersonCubit>().state;
    final state = context.watch<SearchFlightCubit>().state;
    final persons = state.filterState?.numberPerson;
    final focusedPerson = persons?.persons
        .firstWhereOrNull((element) => element == selectedPerson);
    final baggage = isDeparture
        ? focusedPerson?.departureBaggage
        : focusedPerson?.returnBaggage;
    return InkWell(
      onTap: () {
        context
            .read<SearchFlightCubit>()
            .addBaggageToPerson(selectedPerson, selectedBaggage, isDeparture);
      },
      child: AppCard(
        edgeInsets: EdgeInsets.zero,
        child: Stack(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(
                top: 15,
                right: 50,
                left: 15,
                bottom: 15,
              ),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<Bundle?>(
                    value: selectedBaggage,
                    groupValue: baggage,
                    onChanged: (value) async {
                      var responseFlag = context
                          .read<SearchFlightCubit>()
                          .addBaggageToPerson(
                              selectedPerson, value, isDeparture);

                      if (responseFlag) {
                        var nextIndex =
                            persons?.persons.indexOf(selectedPerson!);

                        if ((nextIndex! + 1) < persons!.persons.length) {



                          await Future.delayed(const Duration(seconds: 2));

                          context
                              .read<SelectedPersonCubit>()
                              .selectPerson(persons.persons[nextIndex + 1]);



                          moveToTop?.call();
                        }
                        else if( (nextIndex + 1) ==  persons.persons.length ) {



                          await Future.delayed(const Duration(milliseconds: 500));

                          moveToBottom!.call();
                          await Future.delayed(const Duration(seconds: 1));

                          context.read<SelectedPersonCubit>().selectPerson(persons.persons[0]);


                        }
                      }
                    },
                  ),
                ],
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selectedBaggage.description?.capitalize() ?? "No Baggage",
                    style: kLargeHeavy,
                  ),
                ],
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    selectedBaggage.currencyCode ?? "MYR",
                    style: kMediumHeavy,
                  ),
                  Text(
                    NumberUtils.formatNumber(
                        selectedBaggage.amount?.toDouble()),
                    style: kHugeHeavy,
                  ),
                ],
              ),
            ),
            Positioned(
              right: -20,
              top: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Center(
                  child: Image.asset(
                    "assets/images/design/baggageSmall.png",
                    color: Styles.kSubTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
