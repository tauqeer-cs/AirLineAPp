import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/voucher/voucher_cubit.dart';
import 'package:app/data/requests/voucher_request.dart';
import 'package:app/pages/checkout/pages/payment/ui/redeem_voucher.dart';
import 'package:app/pages/checkout/pages/payment/ui/voucher_ui.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../models/switch_setting.dart';
import '../../../../../utils/constant_utils.dart';
import '../../../../../widgets/settings_wrapper.dart';

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

    return Padding(
      padding: kPageHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Rewards & Discount",
            style: kGiantSemiBold.copyWith(color: Styles.kPrimaryColor),
          ),
          SettingsWrapper(
            settingType: AvailableSetting.myReward,
            child: RedeemVoucherView(
              promoReady: promoReady,
            ),
          ),
          kVerticalSpacerSmall,
          VoucherCodeUi(
            readOnly: bookingState.superPnrNo != null,
            blocState: state.blocState,
            voucherCodeInitial: state.insertedVoucher?.voucherCode ?? '',
            state: state,
            onRemoveTapped: () {
              if (state.response != null) {
                removeVoucher(bookingState, context);
              } else {
                _fbKey.currentState!.reset();
              }
            },
            onButtonTapped:state.blocState == BlocState.loading ||
                bookingState.superPnrNo != null
                ? null
                : (state.response != null)
                ? () => removeVoucher(bookingState, context)
                : () {

              if (_fbKey.currentState!.saveAndValidate()) {
                if (ConstantUtils.showPinInVoucher) {
                  final value = _fbKey.currentState!.value;
                  final voucher = value["voucherCode"];
                  final pin = value["voucherPin"];
                  final voucherPin = InsertVoucherPIN(
                    voucherCode: voucher,
                    voucherPin: pin,
                  );
                  final token = bookingState.verifyResponse?.token;
                  final voucherRequest = VoucherRequest(
                    voucherPins: [voucherPin],
                    token: token,
                  );
                  context
                      .read<VoucherCubit>()
                      .addVoucher(voucherRequest);
                } else {
                  final value = _fbKey.currentState!.value;
                  final voucher = value["voucherCode"];
                  final token = bookingState.verifyResponse?.token;
                  final voucherRequest = VoucherRequest(
                    insertVoucher: voucher,
                    token: token,
                  );
                  context
                      .read<VoucherCubit>()
                      .addVoucher(voucherRequest);
                }
              }
            }, fbKey: _fbKey,
          ),


        ],
      ),
    );
  }

  void removeVoucher(BookingState bookingState, BuildContext context) {
    _fbKey.currentState!.reset();
    final token = bookingState.verifyResponse?.token;
    final voucherRequest = VoucherRequest(
      token: token,
    );
    context.read<VoucherCubit>().removeVoucher(voucherRequest);
  }
}

