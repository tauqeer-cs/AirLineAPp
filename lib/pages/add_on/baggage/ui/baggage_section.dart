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
import '../../../../widgets/app_money_widget.dart';

class BaggageSection extends StatelessWidget {
  final bool isManageBooking;
  final bool isDeparture;
  final VoidCallback? moveToTop;
  final VoidCallback? moveToBottom;
  final GlobalKey? horiz1;
  final GlobalKey? horiz2;
  final GlobalKey? horizS1;
  final GlobalKey? horizS2;

  const BaggageSection({
    Key? key,
    this.isDeparture = true,
    this.moveToTop,
    this.moveToBottom,
    this.isManageBooking = false,
    this.horiz1,
    this.horiz2,
    this.horizS1,
    this.horizS2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BaggageGroup? baggageGroup;

    ManageBookingCubit? manageBookingCubit;

    int personIndex = 0;

    void _functionCallback(int i) {
      personIndex = i;
    }

    if(isManageBooking) {

      var state = context.watch<ManageBookingCubit>().state;
      manageBookingCubit = context.watch<ManageBookingCubit>();

      baggageGroup = state.flightSSR?.baggageGroup;


    }
     else {
      final bookingState = context.watch<BookingCubit>().state;

      baggageGroup = bookingState.verifyResponse?.flightSSR?.baggageGroup;

      final numberOfPerson =
          context.watch<SearchFlightCubit>().state.filterState?.numberPerson;
      final selectedPerson = context.watch<SelectedPersonCubit>().state;
      final persons = List<Person>.from(numberOfPerson?.persons ?? []);
      if(selectedPerson != null) {
        personIndex = persons.indexOf(selectedPerson) ?? 0;
      }


    }

    final baggages =
    isDeparture ? baggageGroup?.outbound : baggageGroup?.inbound;
    return Padding(
      padding: isManageBooking ? EdgeInsets.zero : kPageHorizontalPadding,
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
                onCountChanged: personIndex
              ),
              kVerticalSpacer,
            ],
            buildBaggageCards(baggages, isDeparture),
            kVerticalSpacer,
            Padding(
              padding: kPageHorizontalPadding,
              child: BaggageNotice(
                isManageBooking: isManageBooking,
                isDeparting: isDeparture,
                horizS1: horizS1,
                horizS2: horizS1,
              ),
            ),
            kVerticalSpacer,
            if (isManageBooking) ...[
              const SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                color: const Color.fromRGBO(241, 241, 241, 1.0),
                child: Column(
                  children: [
                    kVerticalSpacerSmall,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: [
                          Text(
                            '${'baggage'.tr()} ${'flightCharge.total'.tr()}',
                            style: kHugeSemiBold.copyWith(
                                color: Styles.kTextColor),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          MoneyWidget(
                            amount: manageBookingCubit
                                    ?.notConfirmedBaggageTotalPrice ??
                                0.0,
                            isDense: true,
                            isNormalMYR: true,
                          ),
                        ],
                      ),
                    ),
                    if ((manageBookingCubit?.notConfirmedSportsTotalPrice ??
                            0.0) >
                        0.0) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 8),
                        child: Row(
                          children: [
                            Text(
                              '${'sports'.tr()} ${'flightCharge.total'.tr()}',
                              style: kHugeSemiBold.copyWith(
                                  color: Styles.kTextColor),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            MoneyWidget(
                              amount: manageBookingCubit
                                      ?.notConfirmedSportsTotalPrice ??
                                  0.0,
                              isDense: true,
                              isNormalMYR: true,
                              currency: manageBookingCubit?.state.manageBookingResponse?.result?.fareAndBundleDetail?.currencyToShow ?? '',
                            ),
                          ],
                        ),
                      ),
                    ],
                    kVerticalSpacerSmall,
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed:
                                manageBookingCubit?.hasAnySeatChanged == false
                                    ? null
                                    : () {
                                        manageBookingCubit
                                            ?.baggageConfirmSeatChange();

                                        manageBookingCubit
                                            ?.changeSelectedAddOnOption(
                                                AddonType.baggage,
                                                toNull: true);
                                      },
                            child: Text(
                              'selectDateView.confirm'.tr(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                      ],
                    ),
                    kVerticalSpacer,
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildBaggageCards(
    List<Bundle>? baggages,
    bool isDeparture,
  ) {
    if (isManageBooking == true && isDeparture == true) {
      return Padding(
        padding: kPageHorizontalPadding,
        child: HorizontalBaggageCards(
          isDeparture: isDeparture,
          key: horiz1,
        ),
      );
    } else if (isManageBooking == true && isDeparture == false) {
      return Padding(
        padding: kPageHorizontalPadding,
        child: HorizontalBaggageCards(
          isDeparture: isDeparture,
          key: horiz2,
        ),
      );
    }

    baggages?.sort((a, b) => (a.amount ?? 0.0).compareTo((b.amount ?? 0.0)));

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
                      isManageBooking: isManageBooking,
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
    this.moveToTop,
    required this.isManageBooking,
  }) : super(key: key);

  @override
  State<NewBaggageCard> createState() => _NewBaggageCardState();
}

class _NewBaggageCardState extends State<NewBaggageCard> {
  @override
  Widget build(BuildContext context) {
    Person? focusedPerson;
    Person? selectedPerson;
    NumberPerson? persons;
    String currency = 'MYR';
    if (widget.isManageBooking) {
      var bloc = context.watch<ManageBookingCubit>();

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

      currency = bloc.state.manageBookingResponse?.result?.superPNROrder
              ?.currencyCode ??
          'MYR';
    } else {
      final state = context.watch<SearchFlightCubit>().state;
      selectedPerson = context.watch<SelectedPersonCubit>().state;
      persons = state.filterState?.numberPerson;
      focusedPerson = persons?.persons
          .firstWhereOrNull((element) => element == selectedPerson);

      if(focusedPerson?.departureBaggage == null) {

      }
      currency = context
              .watch<SearchFlightCubit>()
              .state
              .flights
              ?.flightResult
              ?.requestedCurrencyOfFareQuote ??
          'MYR';
    }

    Bundle? baggage = widget.isDeparture
        ? focusedPerson?.departureBaggage
        : focusedPerson?.returnBaggage;

    if(baggage == null) {

      if(widget.selectedBaggage.ssrCode == 'NOSELECT') {
        baggage = widget.selectedBaggage;
      }
    }

    return InkWell(
      onTap: () async {
        var responseFlag = context.read<SearchFlightCubit>().addBaggageToPerson(
            selectedPerson,
            (widget.selectedBaggage.ssrCode ?? '') == ''
                ? null
                : widget.selectedBaggage,
            widget.isDeparture);

        if (responseFlag) {
          var nextIndex = persons?.persons.indexOf(selectedPerson!);

          if ((nextIndex! + 1) < persons!.persons.length) {
            var nextItem = (persons.persons[nextIndex + 1]);
            if (nextItem.peopleType?.code == 'INF') {
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
            /*
            context
                .read<SelectedPersonCubit>()
                .selectPerson(persons.persons[0]);*/
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
                      value: widget.selectedBaggage,
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

class HorizontalBaggageCards extends StatefulWidget {
  final bool isDeparture;

  const HorizontalBaggageCards({Key? key, required this.isDeparture})
      : super(key: key);

  @override
  State<HorizontalBaggageCards> createState() => _HorizontalBaggageCardsState();
}

class _HorizontalBaggageCardsState extends State<HorizontalBaggageCards> {
  int _currentIndex = 0;
  var pageController = PageController(
    initialPage: 0,
  );


  Widget amountToShow(Bundle currentItem, {bool red = false}) {
    try {
      if ((currentItem.applicableTaxes ?? []).isEmpty ||
          currentItem.applicableTaxes?.first.taxActive == false) {
        return Text(
          NumberUtils.formatNumber(
            (currentItem.amount ?? 0.0).toDouble(),
          ),
          style: red
              ? kHugeHeavy.copyWith(color: Styles.kPrimaryColor)
              : kHugeHeavy,
        );
      } else {
        return Text(
          NumberUtils.formatNumber(
            (currentItem.amount ?? 0.0).toDouble() +
                (currentItem.applicableTaxes?.first.amountToApply ?? 0.0)
                    .toDouble(),
          ),
          style: red
              ? kHugeHeavy.copyWith(color: Styles.kPrimaryColor)
              : kHugeHeavy,
        );
      }
    } catch (e) {
      return Container();
    }
  }

  var selectedItem = '';


  @override
  void initState() {
    super.initState();
    selectedItem = '';
  }

  ManageBookingCubit? bloc;

  bool onlyOneTime = false;

  @override
  Widget build(BuildContext context) {
    BaggageGroup? baggageGroup;
    bloc = context.watch<ManageBookingCubit>();

    var state = context.watch<ManageBookingCubit>().state;

    baggageGroup = state.flightSSR?.baggageGroup;

    if(state.addOnList != null) {


    }

    String currency = 'MYR';
    currency =
        state.manageBookingResponse?.result?.superPNROrder?.currencyCode ??
            'MYR';
    var baggage =
        widget.isDeparture ? baggageGroup?.outbound : baggageGroup?.inbound;
    String? lastBaggagePrice;

    if (widget.isDeparture) {
      if (state.selectedPax?.baggageDetail != null) {
        if ((state.selectedPax!.baggageDetail?.departureBaggages ?? [])
            .isNotEmpty) {
          lastBaggagePrice =
              (state.selectedPax!.baggageDetail?.departureBaggages ?? [])
                  .first
                  .ssrCode;

        }
      }
    } else {
      if (state.selectedPax?.baggageDetail != null) {
        if ((state.selectedPax!.baggageDetail?.returnBaggages ?? [])
            .isNotEmpty) {
          lastBaggagePrice =
              (state.selectedPax!.baggageDetail?.returnBaggages ?? [])
                  .first
                  .ssrCode;

          /*
          lastBagNum =
              (state.selectedPax!.baggageDetail?.returnBaggages ?? [])
                  .first.amount;*.

           */

        }
      }
    }


    baggage = baggage
        ?.where((e) => e.ssrCode != lastBaggagePrice && e.ssrCode != 'NOSELECT' )
        .toList();

    Person? selectedPerson =
        context.watch<ManageBookingCubit>().state.selectedPax?.personObject;

    var dontGotIndex = false;

    var resultIndexFinder = baggage
        ?.where((e) =>
            e.description == selectedPerson?.departureBaggage?.description)
        .toList();

    if(selectedPerson?.departureBaggage?.description == null){
      dontGotIndex = true;
    }
    if (widget.isDeparture == false) {
      resultIndexFinder = baggage
          ?.where((e) =>
              e.description == selectedPerson?.returnBaggage?.description)
          .toList();

      if(selectedPerson?.returnBaggage?.description == null){
        dontGotIndex = true;
      }
    } else {}

    baggage?.sort((a, b) => (a.amount ?? 0.0).compareTo((b.amount ?? 0.0)));

    if ((resultIndexFinder ?? []).isNotEmpty && dontGotIndex == false) {
      int indexOf = baggage?.indexOf((resultIndexFinder ?? []).first) ?? 0;
      print('');

      selectedItem = (resultIndexFinder ?? []).first.ssrCode ?? '';

      if (indexOf != pageController.initialPage) {
        //onlyOneTime = false;

        scrollToPositionInStart(indexOf);
      }
    }
    else if(widget.isDeparture == true && state.selectedPax?.newDepartBaggageSelected != null){

      var ssrCode = state.selectedPax?.newDepartBaggageSelected?.ssrCode ?? '';
      if(ssrCode.isNotEmpty) {
        if((baggage ?? []).isNotEmpty ) {

          var re = (baggage ?? []).where((e) => e.ssrCode == ssrCode).toList();

          if((re ?? []).isNotEmpty){
            selectedItem = ssrCode;

          }
        }
      }
    }
    else if(widget.isDeparture == false && state.selectedPax?.newReturnBaggageSelected != null){

      var ssrCode = state.selectedPax?.newReturnBaggageSelected?.ssrCode ?? '';
      if(ssrCode.isNotEmpty) {
        if((baggage ?? []).isNotEmpty ) {

          var re = (baggage ?? []).where((e) => e.ssrCode == ssrCode).toList();

          if((re ?? []).isNotEmpty){
            selectedItem = ssrCode;

          }
        }
      }

    }
    else {
      int indexOf = 0;
        selectedItem = '';


      //selectedItem = (baggage ?? []).first.ssrCode ?? '';
      scrollToPositionInStart(indexOf);
    }

    return (baggage ?? []).isEmpty ? EmptyAddon() : Row(
      children: [
        GestureDetector(
          onTap: () {
            if (_currentIndex == 0) {
              return;
            }
            onlyOneTime = true;
            _currentIndex = _currentIndex - 1;
            pageController.animateToPage(_currentIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          },
          child: ImageIcon(
            const AssetImage("assets/images/icons/iconPreviousDisabled.png"),
            color: _currentIndex == 0
                ? Styles.kDisabledGrey
                : Styles.kPrimaryColor,
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 240,
            child: PageView.builder(
                itemCount: (baggage ?? []).length,
                scrollDirection: Axis.horizontal,
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  var currentItem = baggage![index];

                  return InkWell(
                    onTap: () async {
                      selectedItem = (baggage ?? [])[index].ssrCode ?? '';
                      var response = bloc?.addBaggageToPerson(selectedPerson,
                          (baggage ?? [])[index], widget.isDeparture);
                      if (response == true)
                      {
                        setState(() {
                          selectedItem = '';
                        });
                      } else {

                        setState(() {});
                      }
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/design/icoLuggageFull.png",
                          color: Styles.kSubTextColor,
                          height: 96,
                        ),
                        kVerticalSpacerMini,
                        Text(
                          currentItem.ssrCodeToShow ?? '',
                          style: kLargeHeavy.copyWith(color: Styles.kTextColor),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          currentItem.description ?? '',
                          style:
                              kMediumRegular.copyWith(color: Styles.kTextColor),
                        ),
                        kVerticalSpacerMini,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentItem.currencyCode ?? currency,
                              style: kHugeHeavy.copyWith(
                                  color: Styles.kPrimaryColor),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            amountToShow(currentItem, red: true),
                          ],
                        ),
                        IgnorePointer(
                          child: Radio<Bundle?>(
                            activeColor: Styles.kActiveColor,
                            value: selectedItem == currentItem.ssrCode
                                ? currentItem
                                : null,
                            groupValue: currentItem,
                            onChanged: (value) async {},
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (_currentIndex == ((baggage ?? []).length - 1)) {
              return;
            }

            _currentIndex = _currentIndex + 1;
            pageController.animateToPage(_currentIndex,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
          },
          child: ImageIcon(
            const AssetImage("assets/images/icons/iconNext.png"),
            color: _currentIndex == ((baggage ?? []).length - 1)
                ? Styles.kDisabledGrey
                : Styles.kPrimaryColor,
          ),
        ),
      ],
    );
  }

  void scrollToPositionInStart(int indexOf) async {
    if (onlyOneTime) {
      return;
    }
    onlyOneTime = true;

    await Future.delayed(Duration(milliseconds: 500));

    pageController.animateToPage(indexOf,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }
}
