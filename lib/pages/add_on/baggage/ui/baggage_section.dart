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
  final VoidCallback? moveToTop;
  final VoidCallback? moveToBottom;

  const BaggageSection({
    Key? key,
    this.isDeparture = true,
    this.moveToTop,
    this.moveToBottom,
  }) : super(key: key);

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

class NewBaggageCard extends StatefulWidget {
  final Bundle selectedBaggage;
  final bool isDeparture;
  final VoidCallback? moveToTop;
  final VoidCallback? moveToBottom;

  const NewBaggageCard({
    Key? key,
    required this.selectedBaggage,
    required this.isDeparture,
    this.moveToBottom,
    this.moveToTop,
  }) : super(key: key);

  @override
  State<NewBaggageCard> createState() => _NewBaggageCardState();
}

class _NewBaggageCardState extends State<NewBaggageCard> {
  @override
  Widget build(BuildContext context) {
    final selectedPerson = context.watch<SelectedPersonCubit>().state;
    final state = context.watch<SearchFlightCubit>().state;
    final persons = state.filterState?.numberPerson;
    final focusedPerson = persons?.persons
        .firstWhereOrNull((element) => element == selectedPerson);
    final baggage = widget.isDeparture
        ? focusedPerson?.departureBaggage
        : focusedPerson?.returnBaggage;
    return InkWell(
      onTap: () async {
        context.read<SearchFlightCubit>().addBaggageToPerson(
            selectedPerson, widget.selectedBaggage, widget.isDeparture);
        var responseFlag = context.read<SearchFlightCubit>().addBaggageToPerson(
            selectedPerson,
            (widget.selectedBaggage.serviceID ?? 0) == 0
                ? null
                : widget.selectedBaggage,
            widget.isDeparture);

        if (responseFlag) {
          var nextIndex = persons?.persons.indexOf(selectedPerson!);

          if ((nextIndex! + 1) < persons!.persons.length) {
            var nextItem = (persons.persons[nextIndex + 1]);
            if (nextItem.peopleType?.code == 'INF') {
              context
                  .read<SelectedPersonCubit>()
                  .selectPerson(persons.persons[0]);
              await Future.delayed(const Duration(milliseconds: 500));
              widget.moveToBottom?.call();
              return;
            }
            await Future.delayed(const Duration(seconds: 1));
            if (!mounted) return;
            context
                .read<SelectedPersonCubit>()
                .selectPerson(persons.persons[nextIndex + 1]);
            widget.moveToTop?.call();
          } else if ((nextIndex + 1) == persons.persons.length) {
            await Future.delayed(const Duration(milliseconds: 500));

            widget.moveToBottom!.call();
            await Future.delayed(const Duration(seconds: 1));
            if (!mounted) return;

            context
                .read<SelectedPersonCubit>()
                .selectPerson(persons.persons[0]);
          }
        }
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
                  IgnorePointer(
                    child: Radio<Bundle?>(
                      value: widget.selectedBaggage.serviceID == 0
                          ? null
                          : widget.selectedBaggage,
                      groupValue: baggage,
                      onChanged: (value) async {},
                    ),
                  ),
                ],
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.selectedBaggage.description?.capitalize() ??
                        "No Baggage",
                    style: kLargeHeavy,
                  ),
                ],
              ),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.selectedBaggage.currencyCode ?? "MYR",
                    style: kMediumHeavy,
                  ),
                  Text(
                    NumberUtils.formatNumber(
                      widget.selectedBaggage.finalAmount.toDouble(),
                    ),
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
