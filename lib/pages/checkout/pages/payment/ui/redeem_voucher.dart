import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../blocs/settings/settings_cubit.dart';
import '../../../../../blocs/voucher/voucher_cubit.dart';
import '../../../../../data/responses/promotions_response.dart';
import '../../../../../theme/spacer.dart';
import '../../../../../theme/styles.dart';
import '../../../../../theme/typography.dart';
import '../../../../../widgets/app_card.dart';
import '../../../../../widgets/app_loading_screen.dart';

class RedeemVoucherView extends StatelessWidget {
  final bool promoReady;

  final String? currency;

  const RedeemVoucherView({Key? key, required this.promoReady,this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<AvailableRedeemOptions>? promotionsList;

    var bloc = context.watch<VoucherCubit>();
    final state = bloc.state;

    final setting = context.watch<SettingsCubit>().state.switchSetting;
    if ((setting.myReward ?? false)) {
      if (promoReady) {
        promotionsList = bloc.state.redemptionOption?.availableOptions;
      }
    }
    return !state.promoLoaded
        ? const AppLoading()
        : (promoReady && promotionsList == null) ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          child: Image.asset("assets/images/design/rewards-add on.png"),
        ) : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kVerticalSpacer,
              Text(
                "MYReward",
                style: kHugeSemiBold.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              kVerticalSpacerSmall,
              const Text(
                'Redeem your MYReward Points from options below!',
                style: kMediumRegular,
              ),
              kVerticalSpacer,

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
                            currenteItem.redeemAmountString(currency ?? 'MYR'),
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
          );
  }
}
