import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/voucher/voucher_cubit.dart';
import 'package:app/data/requests/voucher_request.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../data/responses/promotions_response.dart';
import '../../../../../utils/constant_utils.dart';
import '../../booking_details/bloc/summary_cubit.dart';

class RewardAndDiscount extends StatelessWidget {
  final _fbKey = GlobalKey<FormBuilderState>();
  final bool promoReady;

  RewardAndDiscount({
    Key? key,
    required this.promoReady,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<VoucherCubit>();

    final state = bloc.state;
    final bookingState = context.read<BookingCubit>().state;

    List<AvailableRedeemOptions>? promotionsList;

    if (ConstantUtils.showRedeemPoints) {
      if (promoReady) {
        promotionsList = bloc.state.redemptionOption?.availableOptions;

        print('');
      }
    }

    return Padding(
      padding: kPageHorizontalPadding,
      child: FormBuilder(
        key: _fbKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Rewards & Discount",
              style: kGiantSemiBold.copyWith(color: Styles.kPrimaryColor),
            ),

            //

            if (ConstantUtils.showRedeemPoints && !promoReady) ...[
              const CircularProgressIndicator(),
            ] else if (ConstantUtils.showRedeemPoints &&
                promotionsList != null) ...[
              //showReward
              kVerticalSpacer,
              Text(
                "MYReward",
                style: kGiantHeavy.copyWith(
                  color: Styles.kOrangeColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              kVerticalSpacerSmall,
              Text(
                'Redeem your MYReward Points from options below!',
                style: kSmallRegular.copyWith(color: Styles.kSubTextColor),
              ),
              kVerticalSpacer,

              for (var currenteItem in promotionsList ?? []) ...[
                AppCard(
                  customColor: Styles.klightBackgroundColor,
                  edgeInsets: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          currenteItem.redemptionName.toString(),
                          style: kLargeHeavy,
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          '${currenteItem.redemptionPoint} points',
                          style: kLargeHeavy,
                        ),
                        Radio(
                            value: bloc.getSelectedItem,
                            groupValue: currenteItem,
                            onChanged: (value) {
                              bloc.selectedItem(currenteItem);
                            }),
                      ],
                    ),
                  ),
                ),
                kVerticalSpacerSmall,
              ],

              kVerticalSpacerSmall,

              ElevatedButton(
                onPressed: bloc.getSelectedItem == null
                    ? null
                    : () {
                        bloc.redeemPoints();
                      },
                child: state.blocState == BlocState.loading
                    ? const AppLoading(
                        size: 25,
                        color: Colors.white,
                      )
                    : const Text("Redeem"),
              ),
            ],
            kVerticalSpacerSmall,
            const Text(
              "Voucher Code",
              style: kHugeSemiBold,
            ),
            kVerticalSpacerSmall,
            AppCard(
              child: FormBuilderTextField(
                name: "voucherCode",
                validator: FormBuilderValidators.required(),
                style: const TextStyle(fontSize: 14),
                readOnly: bookingState.superPnrNo != null,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Voucher Code",
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  isDense: true,
                  suffixIconConstraints: const BoxConstraints(
                    minWidth: 40,
                    minHeight: 20,
                    maxHeight: 20,
                    maxWidth: 40,
                  ),
                  suffixIcon: blocBuilderWrapper(
                    blocState: state.blocState,
                    loadingBuilder: const AppLoading(
                      size: 20,
                    ),
                    failedBuilder: const SizedBox(),
                    finishedBuilder:
                        Image.asset("assets/images/icons/iconVoucher.png"),
                  ),
                ),
              ),
            ),
            kVerticalSpacerSmall,
            Visibility(
              visible: state.blocState == BlocState.failed,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
                child: Text(
                  state.message,
                  style: kMediumRegular.copyWith(color: Colors.red),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: state.blocState == BlocState.loading ||
                      bookingState.superPnrNo != null
                  ? null
                  : () {
                      if (_fbKey.currentState!.saveAndValidate()) {
                        final value = _fbKey.currentState!.value;
                        final voucher = value["voucherCode"];
                        final token = bookingState.verifyResponse?.token;
                        final voucherRequest = VoucherRequest(
                          insertVoucher: voucher,
                          token: token,
                        );
                        context.read<VoucherCubit>().addVoucher(voucherRequest);
                      }
                    },
              child: state.blocState == BlocState.loading
                  ? const AppLoading(
                      size: 25,
                      color: Colors.white,
                    )
                  : const Text("Apply"),
            ),
          ],
        ),
      ),
    );
  }
}
