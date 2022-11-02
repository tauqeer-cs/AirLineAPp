import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/voucher/voucher_cubit.dart';
import 'package:app/data/requests/voucher_request.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RewardAndDiscount extends StatelessWidget {
  static final _fbKey = GlobalKey<FormBuilderState>();

  const RewardAndDiscount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<VoucherCubit>().state;
    final bookingState = context.read<BookingCubit>().state;

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
            kVerticalSpacerSmall,
            Text(
              "Voucher Code",
              style: kHugeSemiBold,
            ),
            kVerticalSpacerSmall,
            AppCard(
              child: FormBuilderTextField(
                name: "voucherCode",
                validator: FormBuilderValidators.required(),
                style: TextStyle(fontSize: 14),
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
                      EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  isDense: true,
                  suffixIconConstraints: BoxConstraints(
                    minWidth: 40,
                    minHeight: 20,
                    maxHeight: 20,
                    maxWidth: 40,
                  ),
                  suffixIcon: blocBuilderWrapper(
                      blocState: state.blocState,
                      loadingBuilder: AppLoading(
                        size: 20,
                      ),
                      failedBuilder:
                          Icon(Icons.clear, color: Colors.red, size: 15),
                      finishedBuilder:
                          Image.asset("assets/images/icons/iconVoucher.png")),
                ),
              ),
            ),
            kVerticalSpacerSmall,
            Visibility(
              visible: state.blocState == BlocState.failed,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
                child: Text(
                  state.message,
                  style: kMediumRegular.copyWith(color: Colors.red),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: state.blocState == BlocState.loading
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
                  ? AppLoading(
                      size: 25,
                      color: Colors.white,
                    )
                  : Text("Apply"),
            ),
            // AppCard(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Promo Code",
            //         style: kHugeSemiBold,
            //       ),
            //       kVerticalSpacer,
            //       AppInputText(name: "promoCode"),
            //       kVerticalSpacer,
            //       ElevatedButton(onPressed: () {}, child: Text("Apply")),
            //       kVerticalSpacerBig,
            //       Text(
            //         "Voucher Code",
            //         style: kHugeSemiBold,
            //       ),
            //       kVerticalSpacer,
            //       AppInputText(name: "voucherCode"),
            //       kVerticalSpacer,
            //       ElevatedButton(onPressed: () {}, child: Text("Apply")),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
