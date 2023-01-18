import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/app_bloc_helper.dart';
import '../../../../../blocs/settings/settings_cubit.dart';
import '../../../../../blocs/voucher/voucher_cubit.dart';
import '../../../../../data/responses/promotions_response.dart';
import '../../../../../theme/spacer.dart';
import '../../../../../theme/styles.dart';
import '../../../../../theme/typography.dart';
import '../../../../../utils/constant_utils.dart';
import '../../../../../widgets/app_card.dart';
import '../../../../../widgets/app_loading_screen.dart';

class RedeemVoucherView extends StatelessWidget {
  final bool promoReady;

  const RedeemVoucherView({Key? key, required this.promoReady}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<AvailableRedeemOptions>? promotionsList;

    var bloc = context.watch<VoucherCubit>();
    final state = bloc.state;

    final setting = context.watch<SettingsCubit>().state.switchSetting;
    if ( (setting.myReward ?? false)) {
      if (promoReady) {
        promotionsList = bloc.state.redemptionOption?.availableOptions;
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [kVerticalSpacer,
        Text(
          "MYReward",
          style: kHugeSemiBold.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        kVerticalSpacerSmall,
        if (!state.pointsRedeemed) ...[
          const Text(
            'Redeem your MYReward Points from options below!',
            style: kMediumRegular,
          ),
          kVerticalSpacer,
        ] else ...[
          const Text(
            'Promo Redeemed',
            style: kMediumRegular,
          ),
          kVerticalSpacer,
        ],

        if (state.redeemingPromo) ...[
          const AppLoading(),
        ] else if (state.pointsRedeemed) ...[
          AppCard(
            customColor: Colors.white,
            edgeInsets: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Radio(
                      fillColor: MaterialStateColor.resolveWith(
                              (states) => Styles.kSubTextColor),
                      activeColor: Styles.kActiveColor,
                      value: true,
                      groupValue: true,
                      onChanged: null),
                  Text(
                    state.selectedRedeemOption!.redeemAmountString,
                    style: kMediumMedium,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    '${state.selectedRedeemOption!.redemptionPoint} points',
                    style: kMediumMedium,
                  ),
                ],
              ),
            ),
          ),
        ] else ...[
          for (var currenteItem in promotionsList ?? []) ...[
            AppCard(
              customColor: Colors.white,
              edgeInsets: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Radio(
                        fillColor: MaterialStateColor.resolveWith(
                                (states) => Styles.kDartBlack),
                        activeColor: Styles.kActiveColor,
                        value: bloc.getSelectedItem,
                        groupValue: currenteItem,
                        onChanged: (value) {
                          bloc.selectedItem(currenteItem);
                        }),
                    Text(
                      currenteItem.redeemAmountString,
                      style: kMediumMedium,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      '${currenteItem.redemptionPoint} points',
                      style: kMediumMedium,
                    ),
                  ],
                ),
              ),
            ),
            kVerticalSpacerSmall,
          ],
          kVerticalSpacerSmall,


        ],


      ],
    );
  }
}
