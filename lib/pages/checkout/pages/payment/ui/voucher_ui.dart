import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../app/app_bloc_helper.dart';
import '../../../../../blocs/voucher/voucher_cubit.dart';
import '../../../../../theme/spacer.dart';
import '../../../../../theme/styles.dart';
import '../../../../../theme/typography.dart';
import '../../../../../utils/constant_utils.dart';
import '../../../../../widgets/app_card.dart';
import '../../../../../widgets/app_loading_screen.dart';

class VoucherCodeUi extends StatelessWidget {
  final bool readOnly;
  final BlocState blocState;
  GlobalKey<FormBuilderState> fbKey;

  final VoidCallback? onRemoveTapped;

  final VoidCallback? onButtonTapped;

  final VoucherState state;

  final String voucherCodeInitial;

  VoucherCodeUi(
      {Key? key,
      required this.fbKey,
      required this.readOnly,
      required this.blocState,
      required this.voucherCodeInitial,
      required this.state,
      required this.onRemoveTapped,
      required this.onButtonTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: fbKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'voucherCode'.tr(),
            style: kHugeSemiBold,
          ),
          kVerticalSpacerMini,
           Text(
            "enterVoucherCode".tr(),
            style: kMediumRegular,
          ),
          kVerticalSpacerSmall,
          if (!ConstantUtils.showPinInVoucher) ...[
            AppCard(
              child: FormBuilderTextField(
                name: "voucherCode",
                validator: FormBuilderValidators.required(),
                style: const TextStyle(fontSize: 14),
                readOnly: readOnly,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: 'voucherCode'.tr(),
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
                    blocState: blocState,
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
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: AppCard(
                    child: FormBuilderTextField(
                      name: "voucherCode",
                      initialValue: voucherCodeInitial,
                      validator: FormBuilderValidators.required(),
                      style: const TextStyle(fontSize: 14),
                      readOnly: readOnly,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'voucherCode'.tr(),
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 0),
                        isDense: true,
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                          maxHeight: 20,
                          maxWidth: 20,
                        ),
                        suffixIcon: blocBuilderWrapper(
                          blocState: state.blocState,
                          loadingBuilder: const AppLoading(
                            size: 20,
                          ),
                          failedBuilder: const SizedBox(),
                          finishedBuilder: state.response == null
                              ? const SizedBox()
                              : Image.asset(
                                  "assets/images/icons/iconVoucher.png",
                                  width: 15,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                kHorizontalSpacerSmall,
                Expanded(
                  child: AppCard(
                    child: FormBuilderTextField(
                      name: "voucherPin",
                      obscureText: state.insertedVoucher != null,
                      initialValue: state.insertedVoucher?.voucherPin,
                      validator: FormBuilderValidators.required(),
                      style: const TextStyle(fontSize: 14),
                      readOnly: readOnly,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'pin'.tr(),
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 0),
                        isDense: true,
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                          maxHeight: 20,
                          maxWidth: 20,
                        ),
                        suffixIcon: blocBuilderWrapper(
                          blocState: state.blocState,
                          loadingBuilder: const AppLoading(
                            size: 20,
                          ),
                          failedBuilder: const SizedBox(),
                          finishedBuilder: state.response == null
                              ? const SizedBox()
                              : Image.asset(
                                  "assets/images/icons/iconVoucher.png",
                                  width: 15,
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: onRemoveTapped,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    margin: const EdgeInsets.only(left: 6),
                    decoration: BoxDecoration(
                      color: Styles.kPrimaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
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
            onPressed: onButtonTapped,
            child: state.blocState == BlocState.loading
                ? const AppLoading(
                    size: 25,
                    color: Colors.white,
                  )
                : state.insertedVoucher != null
                    ? Text('paymentView.reset'.tr())
                    : Text('paymentView.apply'.tr()),
          ),
        ],
      ),
    );
  }
}
