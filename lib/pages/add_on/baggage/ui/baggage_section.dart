import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/add_on/baggage/ui/baggage_notice.dart';
import 'package:app/pages/add_on/ui/passenger_selector.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:app/pages/checkout/ui/empty_addon.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/number_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/utils/string_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../blocs/manage_booking/manage_booking_cubit.dart';

class BaggageSection extends StatelessWidget {
  final bool isManageBooking;
  final bool isDeparture;
  final VoidCallback? moveToTop;
  final VoidCallback? moveToBottom;

  const BaggageSection({
    Key? key,
    this.isDeparture = true,
    this.moveToTop,
    this.moveToBottom,
    this.isManageBooking = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BaggageGroup? baggageGroup;

    if(isManageBooking) {
      var state = context.watch<ManageBookingCubit>().state;
      baggageGroup = state.verifyResponse?.flightSSR?.baggageGroup;

    }
     else {
      final bookingState = context.watch<BookingCubit>().state;

      baggageGroup = bookingState.verifyResponse?.flightSSR?.baggageGroup;
    }

    final baggages =
    isDeparture ? baggageGroup?.outbound : baggageGroup?.inbound;
    return Padding(
      padding: kPageHorizontalPadding,
      child: Visibility(
        visible: baggages?.isNotEmpty ?? false,
        replacement: const EmptyAddon(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(isManageBooking == false) ... [
              PassengerSelector(
                isDeparture: isDeparture,
                addonType: AddonType.baggage,
              ),
              kVerticalSpacer,
            ],
            buildBaggageCards(baggages, isDeparture),
            kVerticalSpacer,
             BaggageNotice(isManageBooking: isManageBooking,),
            kVerticalSpacer,
          ],
        ),
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
                  }, isManageBooking: isManageBooking,
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
  final bool isManageBooking;
  final Bundle selectedBaggage;
  final bool isDeparture;
  final VoidCallback? moveToTop;
  final VoidCallback? moveToBottom;

  const NewBaggageCard({
    Key? key,
    required this.selectedBaggage,
    required this.isDeparture,
    this.moveToBottom,
    this.moveToTop, required this.isManageBooking,
  }) : super(key: key);

  @override
  State<NewBaggageCard> createState() => _NewBaggageCardState();
}

class _NewBaggageCardState extends State<NewBaggageCard> {
  @override
  Widget build(BuildContext context) {

    Person?  focusedPerson;
    Person? selectedPerson;
    NumberPerson? persons;
    String currency = 'MYR';
    if(widget.isManageBooking) {
      var bloc = context
          .watch<ManageBookingCubit>();


      selectedPerson =
          context.watch<ManageBookingCubit>().state.selectedPax?.personObject;

      var no = context
          .watch<ManageBookingCubit>()
          .state
          .manageBookingResponse
          ?.result
          ?.allPersonObject ??
          [];

      persons = NumberPerson(persons: no);
      selectedPerson =
          context.watch<ManageBookingCubit>().state.selectedPax?.personObject;

      currency = bloc.state.manageBookingResponse?.result?.superPNROrder?.currencyCode ?? 'MYR';

    }
    else {
      final state = context.watch<SearchFlightCubit>().state;
      selectedPerson = context.watch<SelectedPersonCubit>().state;
      persons = state.filterState?.numberPerson;
      focusedPerson = persons?.persons
          .firstWhereOrNull((element) => element == selectedPerson);
      currency = context.watch<SearchFlightCubit>().state.flights?.flightResult?.requestedCurrencyOfFareQuote ?? 'MYR';
    }




    Bundle? baggage = widget.isDeparture
        ? focusedPerson?.departureBaggage
        : focusedPerson?.returnBaggage;



    return InkWell(
      onTap: () async {

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
        margin: EdgeInsets.only(bottom: 12),
        borderRadius: 12,
        child: Stack(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.only(
                top: 20,
                right: 40,
                left: 15,
                bottom: 20,
              ),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IgnorePointer(
                    child: Radio<Bundle?>(
                      activeColor: Styles.kPrimaryColor,
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
                        'noBaggage'.tr(),
                    style: kLargeHeavy,
                  ),
                ],
              ),
              trailing: SizedBox(
                width: 65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.selectedBaggage.currencyCode ?? currency,
                      style: kMediumHeavy,
                    ),
                    Flexible(
                      child: Text(
                        NumberUtils.formatNumber(
                          widget.selectedBaggage.finalAmount.toDouble(),
                        ),
                        style: kHugeHeavy,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Center(
                  child: Image.asset(
                    "assets/images/design/icoLuggage20.png",
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
