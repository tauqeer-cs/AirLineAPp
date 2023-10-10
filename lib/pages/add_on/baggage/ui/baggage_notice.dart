import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/pages/checkout/ui/empty_addon.dart';
import 'package:app/theme/html_style.dart';
import 'package:app/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../blocs/booking/booking_cubit.dart';
import '../../../../blocs/is_departure/is_departure_cubit.dart';
import '../../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../../blocs/search_flight/search_flight_cubit.dart';
import '../../../../data/responses/verify_response.dart';
import '../../../../models/number_person.dart';
import '../../../../utils/number_utils.dart';
import '../../../../utils/security_utils.dart';
import '../../../../widgets/app_card.dart';
import '../../../../widgets/containers/app_expanded_section.dart';
import '../../../checkout/bloc/selected_person_cubit.dart';

class BaggageNotice extends StatefulWidget {
  final bool isManageBooking;
  final GlobalKey? horizS1;
  final GlobalKey? horizS2;
  final bool isDeparting;

  const BaggageNotice({Key? key, required this.isManageBooking,  required this.isDeparting, this.horizS1, this.horizS2})
      : super(key: key);

  @override
  State<BaggageNotice> createState() => _BaggageNoticeState();
}

class _BaggageNoticeState extends State<BaggageNotice> {
  final bool hideSportsEquipment = true;

  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    final carryNotice = context.watch<CmsSsrCubit>().state.carryNotice;
    final oversizedNotice = context.watch<CmsSsrCubit>().state.oversizedNotice;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hideSportsEquipment) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isExpand = !isExpand;
                  });
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "travellingSports".tr(),
                        style: kHugeHeavy.copyWith(color: Styles.kDartBlack),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        isExpand
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            kVerticalSpacerSmall,
            ExpandedSection(
              expand: isExpand,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'baggageMessage'.tr(),
                      style: kMediumRegular.copyWith(
                          color: Styles.kTextColor, height: 20 / 14),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'checkInTermsFAQ'.tr(),
                          style: kMediumRegular.copyWith(
                            color: Styles.kPrimaryColor,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              SecurityUtils.tryLaunch(
                                  'https://www.myairline.my/fares-fees');
                            },
                        ),
                        TextSpan(
                          text: 'forMoreInfo'.tr(),
                          style: kMediumRegular.copyWith(
                              color: Styles.kTextColor, height: 20 / 14),
                        ),
                      ],
                    ),
                  ),
                  kVerticalSpacerSmall,
                  if(widget.isDeparting == true) ... [
                    SportsEquipmentCard(
                      isManageBooking: widget.isManageBooking, isDeparting: widget.isDeparting,
                      key: widget.horizS1,
                    ),
                  ] else ... [
                    SportsEquipmentCard(
                      isManageBooking: widget.isManageBooking, isDeparting: widget.isDeparting,
                      key: widget.horizS2,
                    ),
                  ],

                ],
              ),
            ),
            kVerticalSpacer,
            Divider(
              height: 1,
              color: Styles.kDisabledButton,
            ),
          ],
          kVerticalSpacer,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Text(
              "carryOnBaggage".tr(),
              style: kHugeHeavy.copyWith(color: Styles.kDartBlack),
            ),
          ),
          kVerticalSpacer,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Html(
              data: carryNotice?.content ?? "",
              style: HtmlStyle.htmlStyle(overrideColor: Styles.kTextColor),
            ),
          ),
          kVerticalSpacer,
          Divider(
            height: 1,
            color: Styles.kDisabledButton,
          ),
          kVerticalSpacer,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            child: Text(
              "oversizedItem".tr(),
              style: kHugeHeavy.copyWith(color: Styles.kDartBlack),
            ),
          ),
          kVerticalSpacer,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Html(
              data: oversizedNotice?.content ?? "",
              style: HtmlStyle.htmlStyle(overrideColor: Styles.kTextColor),
            ),
          ),
          kVerticalSpacer,
          Divider(
            height: 1,
            color: Styles.kDisabledButton,
          ),
        ],
      ),
    );
  }
}

class SportsEquipmentCard extends StatefulWidget {
  final GlobalKey? horizS1;
  final GlobalKey? horizS2;

  final bool isManageBooking;

  final bool isDeparting;

  const SportsEquipmentCard({Key? key, required this.isManageBooking, required this.isDeparting, this.horizS1, this.horizS2})
      : super(key: key);

  @override
  State<SportsEquipmentCard> createState() => _SportsEquipmentCardState();
}

class _SportsEquipmentCardState extends State<SportsEquipmentCard> {
  bool showDescribtion = false;
  int number = 0;

  var selectedItem = '';

  Person? lastPersonUser;

  @override
  void initState() {
    super.initState();
    selectedItem = '';
    lastPersonUser = null;


    personSingle.selectedPerson = null;
    personSingle.selectedPersonReturn = null;



  }

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

  int _currentIndex = 0;
  var pageController = PageController(
    initialPage: 0,
  );
  ManageBookingCubit? managebloc;
  Person? selectedPerson;
  @override
  Widget build(BuildContext context) {
    String currency = 'MYR';

    bool isDeparture = false;
    BundleGroupSeat? baggageGroup;
    List<Bundle>? baggage;

    var selectedCubit = context.watch<SelectedPersonCubit>();

    if (widget.isManageBooking) {

      var bloc = context.watch<ManageBookingCubit>();

      var state = bloc.state;

      managebloc = bloc;

      currency = bloc.state.manageBookingResponse?.result?.superPNROrder
              ?.currencyCode ??
          'MYR';
      selectedPerson = context.watch<ManageBookingCubit>().state.selectedPax?.personObject;


      baggageGroup = bloc.state.flightSSR?.sportGroup;
      isDeparture = widget.isDeparting;


       baggage =
      isDeparture ? baggageGroup?.outbound : baggageGroup?.inbound;

      baggage?.sort((a, b) => (a.amount ?? 0.0).compareTo( (b.amount ?? 0.0)));

      String? lastSSRCode ;


      if(widget.isDeparting) {
        if(state.selectedPax?.baggageDetail != null) {
          if((state.selectedPax!.sportEquipmentDetail?.departureBaggages ?? []).isNotEmpty) {
            lastSSRCode =  (state.selectedPax!.sportEquipmentDetail?.departureBaggages ?? []).first.ssrCode;

          }
        }


      }
      else {
        if(state.selectedPax?.sportEquipmentDetail != null) {
          if((state.selectedPax!.sportEquipmentDetail?.returnBaggages ?? []).isNotEmpty) {
            lastSSRCode =  (state.selectedPax!.sportEquipmentDetail?.returnBaggages ?? []).first.ssrCode;

          }
        }
      }

      baggage = baggage?.where((e) => e.ssrCode != lastSSRCode ).toList();
      baggage = baggage?.where((e) => e.ssrCode != 'NOSELECT').toList();

      var resultIndexFinder = baggage?.where((e) => e.description == selectedPerson?.departureSports?.description).toList();

      if(widget.isDeparting == false){
        resultIndexFinder = baggage?.where((e) => e.description == selectedPerson?.returnSports?.description).toList();
      }
      if((resultIndexFinder ?? []).isNotEmpty) {


        int indexOf = baggage?.indexOf((resultIndexFinder ?? []).first) ?? 0;
        print('');

        selectedItem = (resultIndexFinder ?? []).first.ssrCode ?? '';



        if(indexOf != pageController.initialPage){
          scrollToPositionInStart(indexOf);


        }

      }
      else {
        int indexOf = 0;
        selectedItem = '';
        scrollToPositionInStart(indexOf);
      }

    } else {
      currency = context
              .watch<SearchFlightCubit>()
              .state
              .flights
              ?.flightResult
              ?.requestedCurrencyOfFareQuote ??
          'MYR';


      if(this.widget.isDeparting == true && personSingle.selectedPerson != null){
        selectedPerson = personSingle.selectedPerson;
      }
      else if(widget.isDeparting == false && personSingle.selectedPersonReturn != null){
        selectedPerson = personSingle.selectedPersonReturn;
      }
      else {
        selectedPerson = context.watch<SelectedPersonCubit>().state;
      }



      isDeparture = context.watch<IsDepartureCubit>().state;


      final bookingState = context.watch<BookingCubit>().state;
      baggageGroup = bookingState.verifyResponse?.flightSSR?.sportGroup;



    }

    if (lastPersonUser != selectedPerson) {
      selectedItem = '';

      if (isDeparture) {
        if (selectedPerson?.departureSports != null) {
          if (selectedPerson?.departureSports!.ssrCode != null) {
            selectedItem = selectedPerson!.departureSports!.ssrCode ?? '';
          }
        }
      } else {
        if (selectedPerson?.returnSports != null) {
          if (selectedPerson?.returnSports!.ssrCode != null) {
            selectedItem = selectedPerson!.returnSports!.ssrCode ?? '';
          }
        }
      }

      lastPersonUser = selectedPerson;
    }

    if(widget.isManageBooking){

    }
    else {
      baggage =
      isDeparture ? baggageGroup?.outbound : baggageGroup?.inbound;
      baggage?.sort((a, b) => (a.amount ?? 0.0).compareTo( (b.amount ?? 0.0)));

      if(isDeparture) {
        if(selectedPerson?.departureSports == null){
          selectedPerson = selectedPerson?.copyWith(departureSports: () => (baggage ?? []).first );
          selectedItem = 'NOSELECT';
        }

      }
      else {

        if(selectedPerson?.returnSports == null){
          selectedPerson =  selectedPerson?.copyWith(departureSports: () => (baggage ?? []).first );
          selectedItem = 'NOSELECT';

        }

      }



    }

    return widget.isManageBooking
        ? (baggage ?? []).isEmpty ? EmptyAddon() : Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (_currentIndex == 0) {
                    return;
                  }
                  _currentIndex = _currentIndex - 1;
                  pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 500), curve: Curves.ease);
                },
                child: ImageIcon(
                  const AssetImage(
                      "assets/images/icons/iconPreviousDisabled.png"),
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

                        //addSportToPerson
                        return InkWell(
                          onTap: (){

                            var response = managebloc?.addSportToPerson(selectedPerson,(baggage ?? [])[index],isDeparture);
                            if(response == true) {

                              setState(() {
                                selectedItem = '';

                              });
                            }
                            else {
                              selectedItem = (baggage ?? [])[index].ssrCode ?? '';

                              setState(() {

                              });
                            }

                          },
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/design/icoSportsGrey.png",
                                color: Styles.kSubTextColor,
                                height: 96,
                              ),
                              kVerticalSpacerMini,
                              Text(
                                currentItem.ssrCodeToShow ?? '',
                                style: kLargeHeavy.copyWith(
                                    color: Styles.kTextColor),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                currentItem.description ?? '',
                                style: kMediumRegular.copyWith(
                                    color: Styles.kTextColor),
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
                                  SizedBox(
                                    width: 2,
                                  ),
                                  amountToShow(currentItem, red: true),
                                ],
                              ),
                              IgnorePointer(
                                child: Radio<Bundle?>(
                                  activeColor: Styles.kActiveColor,
                                  value: selectedItem ==
                                          currentItem.ssrCode
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
                onTap: (){
                  if (_currentIndex == ((baggage ?? []).length - 1)) {
                    return;
                  }

                  _currentIndex = _currentIndex + 1;

                  pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 500), curve: Curves.ease);

                },
                child: ImageIcon(
                  const AssetImage("assets/images/icons/iconNext.png"),
                  color: _currentIndex == ((baggage ?? []).length - 1)
                      ? Styles.kDisabledGrey
                      : Styles.kPrimaryColor,
                ),
              ),
            ],
          )
        : Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: IntrinsicHeight(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (var currentItem in baggage!) ...[
                        kVerticalSpacer,
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedItem = currentItem.ssrCode ?? '';
                            });

                            var responseFlag = context
                                .read<SearchFlightCubit>()
                                .addSportEquipmentToPerson(
                                    selectedPerson,
                                    (currentItem.ssrCode ?? '') == ''
                                        ? null
                                        : currentItem,
                                    isDeparture);

                            if(responseFlag != null) {

                              selectedCubit
                                  .selectPerson(responseFlag);

                              if(this.widget.isDeparting) {
                                personSingle.selectedPerson = responseFlag;
                              }
                              else {
                                personSingle.selectedPersonReturn = responseFlag;
                              }


                              setState(() {

                              });

                            //  selectedCubit?.updatePerson(responseFlag);
                            }

                          },
                          child: AppCard(
                            edgeInsets: EdgeInsets.zero,
                            child: Stack(
                              children: [
                                ListTile(
                                  contentPadding: const EdgeInsets.only(
                                    top: 20,
                                    right: 50,
                                    left: 15,
                                    bottom: 20,
                                  ),
                                  leading: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IgnorePointer(
                                        child: Radio<Bundle?>(
                                          activeColor: Styles.kActiveColor,
                                          value: selectedItem ==
                                                  currentItem.ssrCode
                                              ? currentItem
                                              : null,
                                          groupValue: currentItem,
                                          onChanged: (value) async {},
                                        ),
                                      ),
                                    ],
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      /*Text(
                                  '${(currentItem.ssrCode ?? '').replaceAll('SP', '')}kg'.replaceAll('NOSELECT', '0'),
                                  style: kLargeHeavy,
                                ),*/
                                      Text(
                                        '${(currentItem.ssrCode ?? '').replaceAll('SP', '')}kg'
                                            .replaceAll('NOSELECT', '0'),
                                        style: kGiantHeavy,
                                      ),
                                    ],
                                  ),
                                  trailing: Container(
                                    constraints:
                                        const BoxConstraints(minWidth: 60),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          currentItem.currencyCode ?? currency,
                                          style: kMediumHeavy,
                                        ),
                                        amountToShow(currentItem),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6.0),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/images/design/icoSport2.png",
                                        color: Styles.kSubTextColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  bool onlyOneTime = false;


  void scrollToPositionInStart(int indexOf) async {
    if(onlyOneTime ){
      return;

    }
    onlyOneTime = true;

    await Future.delayed(Duration(milliseconds: 500));
    //selectedItem = indexOf;

    pageController.animateToPage(indexOf, duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

}

 final PersonSingleton personSingle = PersonSingleton._internal();

class PersonSingleton {
  Person? selectedPerson;
  Person? selectedPersonReturn;

  factory PersonSingleton() {
    return personSingle;
  }

  PersonSingleton._internal();
}
