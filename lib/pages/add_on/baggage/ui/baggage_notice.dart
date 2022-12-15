import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/theme/html_style.dart';
import 'package:app/theme/theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../blocs/booking/booking_cubit.dart';
import '../../../../blocs/is_departure/is_departure_cubit.dart';
import '../../../../blocs/search_flight/search_flight_cubit.dart';
import '../../../../data/responses/verify_response.dart';
import '../../../../models/number_person.dart';
import '../../../../utils/number_utils.dart';
import '../../../../widgets/app_card.dart';
import '../../../../widgets/app_money_widget.dart';
import '../../../checkout/bloc/selected_person_cubit.dart';

class BaggageNotice extends StatelessWidget {
  const BaggageNotice({Key? key}) : super(key: key);

  final bool hideSportsEquipment = true;

  @override
  Widget build(BuildContext context) {
    final carryNotice = context.watch<CmsSsrCubit>().state.carryNotice;
    final oversizedNotice = context.watch<CmsSsrCubit>().state.oversizedNotice;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Carry-on Baggage", style: kGiantSemiBold),
          kVerticalSpacer,
          Html(
            data: carryNotice?.content ?? "",
            style: HtmlStyle.htmlStyle(),
          ),
          kVerticalSpacer,
          Divider(
            height: 1,
            color: Styles.kDisabledButton,
          ),
          kVerticalSpacer,
          if (hideSportsEquipment) ...[
            Text(
              "Travelling with Sports Equipments?",
              style: kHugeHeavy.copyWith(color: Styles.kDartBlack),
            ),

            kVerticalSpacerSmall,
            Html(
              data: oversizedNotice?.content ?? "",
              style: HtmlStyle.htmlStyle(overrideColor: Styles.kDartBlack),
            ),
            kVerticalSpacerSmall,
            const SportsEquipmentCard(),
          ],
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
    final selectedPerson = context.watch<SelectedPersonCubit>().state;
    final isDeparture = context.watch<IsDepartureCubit>().state;
    if(lastPersonUser != selectedPerson){
      selectedItem = 0;

      if(isDeparture){
        if(selectedPerson?.departureSports != null) {

          if(selectedPerson?.departureSports!.serviceID != null) {
            selectedItem = selectedPerson!.departureSports!.serviceID!.toInt();

          }

        }
      }
      else {

        if(selectedPerson?.returnSports != null) {

          if(selectedPerson?.returnSports!.serviceID != null) {
            selectedItem = selectedPerson!.returnSports!.serviceID!.toInt();

          }

        }

      }

      lastPersonUser = selectedPerson;

    }

    final bookingState = context.watch<BookingCubit>().state;
    final baggageGroup = bookingState.verifyResponse?.flightSSR?.sportGroup;
    final baggageGroup1 = bookingState.verifyResponse?.flightSSR?.baggageGroup;


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
                    onTap: (){

                      setState(() {
                        selectedItem = currentItem.serviceID!.toInt();
                      });


                      var responseFlag = context.read<SearchFlightCubit>().addSportEquipmentToPerson(
                          selectedPerson,
                          (currentItem.serviceID ?? 0) == 0
                              ? null
                              : currentItem,
                         isDeparture);



                      print('');

                    },
                    child: AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          kVerticalSpacerMini,

                          const SizedBox(width: double.infinity,),
                          FractionallySizedBox(
                            widthFactor: 0.34,

                            child: Image.asset(
                                "assets/images/design/icoSports.png"),
                          ),

                          kVerticalSpacerSmall,
                          Text(
                            '${(currentItem.ssrCode ?? '').replaceAll('SP', '')}kg'.replaceAll('NOSELECT', '0'),
                            style: kHeaderHeavy.copyWith(
                                fontSize: 32, color: Styles.kBorderActionColor),
                          ),
                          kVerticalSpacerSmall,
                          if(showDescribtion) ... [
                            Text(
                              'Save at least 90% on\nairport prince.',
                              textAlign: TextAlign.center,
                              style: kMediumMedium.copyWith(
                                fontSize: 14, color: Styles.kBorderActionColor ,),
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
                              value: selectedItem == currentItem.serviceID!.toInt() ? currentItem : null,
                              groupValue: currentItem,
                              onChanged: (value) async {},
                            ),
                          ),


                          kVerticalSpacerMini,

                        ],
                      ),
                    ),
                  ),
                  kVerticalSpacer,

                ],
                kVerticalSpacer,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
