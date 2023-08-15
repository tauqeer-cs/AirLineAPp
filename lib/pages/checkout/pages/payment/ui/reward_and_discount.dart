import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/voucher/voucher_cubit.dart';
import 'package:app/data/requests/voucher_request.dart';
import 'package:app/pages/checkout/pages/payment/ui/redeem_voucher.dart';
import 'package:app/pages/checkout/pages/payment/ui/voucher_ui.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../blocs/search_flight/search_flight_cubit.dart';
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
    final bookinbBloc = context.read<BookingCubit>();

    final bookingState = context.read<BookingCubit>().state;

    final currency = context
            .watch<SearchFlightCubit>()
            .state
            .flights
            ?.flightResult
            ?.requestedCurrencyOfFareQuote ??
        'MYR';

    return Padding(
      padding: kPageHorizontalPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "rewardsDiscount".tr(),
            style: kGiantSemiBold.copyWith(color: Styles.kPrimaryColor),
          ),
          if(bloc.hasVoucherBeenUsed == false || 1 == 1) ... [
            SettingsWrapper(
              settingType: AvailableSetting.myReward,
              child: RedeemVoucherView(
                currency: currency,
                promoReady: promoReady,
              ),
            ),
            kVerticalSpacerSmall,
          ],


          if(bloc.hasPointsBeenRedeemed == false || 1 == 1) ... [

            VoucherCodeUi(
              onOnlyTextRemove: (){
                _fbKey.currentState!.reset();
                bloc.dontShowVoucher();
              },
              readOnly: bookingState.superPnrNo != null,
              blocState: state.blocState,
              voucherCodeInitial: state.dontShowVoucher == true ? '' : (state.insertedVoucher?.voucherCode ?? (state.lastText ?? '')),
              state: state,
              onRemoveTapped: true
                  ? () {
                if(bookingState.superPnrNo != null) {
                  return;
                }
                if(bookinbBloc.hasPnr == true) {
                  return;

                }

                if((state.insertedVoucher?.voucherCode ?? '').isEmpty) {
                  _fbKey.currentState!.reset();
                  return;

                }
                if (state.response != null) {

                  removeVoucher(bookingState, context);
                } else {
                  _fbKey.currentState!.reset();
                }
              }
                  : null,
              onButtonTapped: state.blocState == BlocState.loading ||
                  bookingState.superPnrNo != null
                  ? null
                  : (state.insertedVoucher != null)
                  ? () => removeVoucher(bookingState, context)
                  : () {

                if (_fbKey.currentState!.saveAndValidate()) {
                  if (ConstantUtils.showPinInVoucher) {
                    final value = _fbKey.currentState!.value;
                    final voucher = value["voucherCode"];
                    final pin = value["voucherPin"];
                    final voucherPin = InsertVoucherPIN(
                      voucherCode: voucher,
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
              },
              fbKey: _fbKey,
            ),
          ] ,

        ],
      ),
    );
  }

  void removeVoucher(BookingState bookingState, BuildContext context) {
    if (bookingState.superPnrNo != null) {
      return;
    }


    final token = bookingState.verifyResponse?.token;
    final voucherRequest = VoucherRequest(
      token: token,
    );
    String? lastText;

    if(context.read<VoucherCubit>().state.dontShowVoucher == true){
      _fbKey.currentState!.save();

      final value = _fbKey.currentState!.value;
      final voucher = value["voucherCode"];
      lastText = voucher;

    }
    else {
      _fbKey.currentState!.reset();

    }

    context.read<VoucherCubit>().removeVoucher(voucherRequest,lastTextEntered: lastText);

  }

}
