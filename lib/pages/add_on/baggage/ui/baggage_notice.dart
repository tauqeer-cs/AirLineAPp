import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/theme/html_style.dart';
import 'package:app/theme/theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../../blocs/booking/booking_cubit.dart';
import '../../../../blocs/is_departure/is_departure_cubit.dart';
import '../../../../blocs/search_flight/search_flight_cubit.dart';
import '../../../../data/responses/verify_response.dart';
import '../../../../models/number_person.dart';
import '../../../../utils/number_utils.dart';
import '../../../../utils/security_utils.dart';
import '../../../../widgets/app_card.dart';
import '../../../../widgets/containers/app_expanded_section.dart';
import '../../../checkout/bloc/selected_person_cubit.dart';

class BaggageNotice extends StatefulWidget {
  const BaggageNotice({Key? key}) : super(key: key);

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
                      text:
                      'baggageMessage'.tr(),
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
                  const SportsEquipmentCard(),
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
  const SportsEquipmentCard({Key? key}) : super(key: key);

  @override
  State<SportsEquipmentCard> createState() => _SportsEquipmentCardState();
}

class _SportsEquipmentCardState extends State<SportsEquipmentCard> {
  bool showDescribtion = false;
  int number = 0;

  var selectedItem = 0;

  Person? lastPersonUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedItem = 0;
  }

  @override
  Widget build(BuildContext context) {
    final currency = context.watch<SearchFlightCubit>().state.flights?.flightResult?.requestedCurrencyOfFareQuote ?? 'MYR';

    final selectedPerson = context.watch<SelectedPersonCubit>().state;
    final isDeparture = context.watch<IsDepartureCubit>().state;
    if (lastPersonUser != selectedPerson) {
      selectedItem = 0;

      if (isDeparture) {
        if (selectedPerson?.departureSports != null) {
          if (selectedPerson?.departureSports!.serviceID != null) {
            selectedItem = selectedPerson!.departureSports!.serviceID!.toInt();
          }
        }
      } else {
        if (selectedPerson?.returnSports != null) {
          if (selectedPerson?.returnSports!.serviceID != null) {
            selectedItem = selectedPerson!.returnSports!.serviceID!.toInt();
          }
        }
      }

      lastPersonUser = selectedPerson;
    }
    final bookingState = context.watch<BookingCubit>().state;
    final baggageGroup = bookingState.verifyResponse?.flightSSR?.sportGroup;
    final baggageGroup1 = bookingState.verifyResponse?.flightSSR?.baggageGroup;
    var squareDesign = true;

    final baggage =
    isDeparture ? baggageGroup?.outbound : baggageGroup?.inbound;
    return Container(
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
                        selectedItem = currentItem.serviceID!.toInt();
                      });

                      var responseFlag = context
                          .read<SearchFlightCubit>()
                          .addSportEquipmentToPerson(
                          selectedPerson,
                          (currentItem.serviceID ?? 0) == 0
                              ? null
                              : currentItem,
                          isDeparture);
                    },
                    child: squareDesign
                        ? AppCard(
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
                                        currentItem.serviceID!.toInt()
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
                              constraints: BoxConstraints(minWidth: 60),
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
                                  Text(
                                    NumberUtils.formatNumber(
                                      (currentItem.amount ?? 0.0)
                                          .toDouble(),
                                    ),
                                    style: kHugeHeavy,
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
                    )
                        : AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          kVerticalSpacerMini,
                          const SizedBox(
                            width: double.infinity,
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.34,
                            child: Image.asset(
                                "assets/images/design/icoSports.png"),
                          ),
                          kVerticalSpacerSmall,
                          Text(
                            '${(currentItem.ssrCode ?? '').replaceAll('SP', '')}kg'
                                .replaceAll('NOSELECT', '0'),
                            style: kHeaderHeavy.copyWith(
                                fontSize: 32,
                                color: Styles.kBorderActionColor),
                          ),
                          kVerticalSpacerSmall,
                          if (showDescribtion) ...[
                            Text(
                              'Save at least 90% on\nairport prince.',
                              textAlign: TextAlign.center,
                              style: kMediumMedium.copyWith(
                                fontSize: 14,
                                color: Styles.kBorderActionColor,
                              ),
                            ),
                            kVerticalSpacerMini,
                          ],
                          Text(
                            '${currentItem.currencyCode ?? 'MYR'} ${(currentItem.amount ?? 0.0).toStringAsFixed(2)}',
                            style: kHeaderHeavy.copyWith(
                                color: Styles.kPrimaryColor),
                          ),
                          kVerticalSpacerMini,
                          IgnorePointer(
                            child: Radio<Bundle?>(
                              activeColor: Styles.kBorderColor,
                              value: selectedItem ==
                                  currentItem.serviceID!.toInt()
                                  ? currentItem
                                  : null,
                              groupValue: currentItem,
                              onChanged: (value) async {},
                            ),
                          ),
                          kVerticalSpacerMini,
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
}
