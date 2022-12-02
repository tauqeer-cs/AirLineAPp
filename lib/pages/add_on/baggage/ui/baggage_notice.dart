import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/theme/html_style.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaggageNotice extends StatelessWidget {
  const BaggageNotice({Key? key}) : super(key: key);

  final bool hideSportsEquipment = false;

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
              "Travelling with",
              style: kGiantSemiBold.copyWith(color: Styles.kOrangeColor),
            ),
            Text(
              "Sports",
              style: kHeaderHeavy.copyWith(color: Styles.kOrangeColor),
            ),
            Text(
              "Equipments?",
              style: kHeaderHeavy.copyWith(color: Styles.kOrangeColor),
            ),
            kVerticalSpacerSmall,
            Html(
              data: oversizedNotice?.content ?? "",
              style: HtmlStyle.htmlStyle(),
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
  int number = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        child: IntrinsicHeight(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  kVerticalSpacer,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Per item"),
                      kVerticalSpacerMini,
                      Text(
                        "RM99",
                        style:
                            kHeaderHeavy.copyWith(color: Styles.kPrimaryColor),
                      ),
                    ],
                  ),
                  kVerticalSpacerBig,
                  Row(
                    children: [
                      kHorizontalSpacer,
                      SizedBox(
                        width: 105.h,
                        height: 35.h,
                        child: OutlinedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Styles.kPrimaryColor),
                              ),
                            ),
                          ),
                          onPressed: number > 0
                              ? () => setState(() => number -= 1)
                              : null,
                          child: const Icon(
                            Icons.remove,
                            size: 20,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          number.toString(),
                          style:
                              kLargeHeavy.copyWith(color: Styles.kSubTextColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 105.h,
                        height: 35.h,
                        child: OutlinedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Styles.kPrimaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Styles.kPrimaryColor),
                              ),
                            ),
                          ),
                          onPressed: () => setState(() => number += 1),
                          child: const Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      kHorizontalSpacer,
                    ],
                  ),
                  kVerticalSpacer,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
