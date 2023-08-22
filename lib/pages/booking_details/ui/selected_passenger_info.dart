import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../data/responses/manage_booking_response.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../utils/form_utils.dart';
import '../../../widgets/containers/app_expanded_section.dart';
import '../../../widgets/forms/app_input_text.dart';
import '../../../widgets/passport_exp_date_selector.dart';
import 'double_line_text.dart';

class SelectedPassengerInfo extends StatelessWidget {
  final PassengersWithSSR? passengers;

  const SelectedPassengerInfo(this.passengers, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<ManageBookingCubit>();

    var state = context.watch<ManageBookingCubit>().state;
    int i = state.manageBookingResponse?.result?.passengersWithSSR
            ?.indexOf(passengers!) ??
        1;

    if (i == -1) {
      i = 0;
    }
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            passengers?.passengers?.fullName ?? '',
            style: kLargeMedium.copyWith(color: Styles.kTextColor),
          ),
        ),
        kVerticalSpacerSmall,
        DoubleLineTextTable(
          label: 'familyDetail.fName'.tr(),
          value: passengers?.passengers?.givenName ?? '',
        ),
        kVerticalSpacerSmall,
        DoubleLineTextTable(
          label: 'familyDetail.lName'.tr(),
          value: passengers?.passengers?.surname ?? '',
        ),
        kVerticalSpacerSmall,
        DoubleLineTextTable(
          label: 'passengerDetail.nationality'.tr(),
          value: passengers?.passengers?.nationality ?? '',
        ),
        if (bloc.state.manageBookingResponse?.result?.isRequiredPassport ==
            true) ...[
          AppInputText(
            isRequired: true,
            name: 'passportKey${i.toString()}',
            hintText: 'passportNo'.tr(),
            label: 'passportNo'.tr(),
            onChanged: (newValue) {
              if (newValue != null) {
                passengers?.checkInPassportNo = newValue;
                bloc.anyThingChanged();

              }
            },
            initialValue: state.manageBookingResponse?.result
                ?.passengersWithSSR?[i].passengers?.passport,
            textInputType: TextInputType.text,
          ),
          kVerticalSpacerSmall,
          PassportExpiryDatePicker(
            onChanged: (int date, int month, int year,bool ignore) {
              if(ignore) {
                return;

              }
              DateTime newDate = DateTime(year, month, date);

              passengers?.passExpdate = newDate.toString();
              bloc.anyThingChanged();

              print('');

            }, initalValues: passengers?.passengers?.passportExpiryDate,
          ),
          true ? Container() : FormBuilderDateTimePicker(
            name: 'formNameDob${i.toString()}',
            firstDate: DateTime.now().add(const Duration(days: 1)),
            lastDate: DateTime.now().add(const Duration(days: 5475)),
            format: DateFormat("dd MMM yyyy"),
            onChanged: (newData) {
              if (newData != null) {
                passengers?.passExpdate = newData.toString();
              }
            },
            initialDate: DateTime.now().add(const Duration(days: 365)),
            initialEntryMode: DatePickerEntryMode.calendar,
            validator: (value) {
              if (state.manageBookingResponse?.result?.passengersWithSSR?[i]
                      .paxSelected ==
                  true) {
                if (value == null) {
                  return 'expDateRequired'.tr();
                }
              }

              return null;
            },
            decoration: InputDecoration(
              hintText: "passportExpiry".tr(),
              suffixIcon: const Icon(Icons.calendar_month_sharp),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
            ),
            inputType: InputType.date,
          ),
        ],
        kVerticalSpacerSmall,
        AppInputText(
          name: 'rewardKey${i.toString()}',
          initialValue: state.manageBookingResponse?.result
              ?.passengersWithSSR?[i].passengers?.myRewardMemberId,
          hintText: 'passengerDetail.membershipID'.tr(),
          inputFormatters: [AppFormUtils.onlyNumber()],
          textInputType: TextInputType.number,
          onChanged: (newText) {
            if (newText != null) {
              state.manageBookingResponse?.result?.passengersWithSSR?[i]
                  .checkInMemberID = newText;

              bloc.anyThingChanged();

            }
          },
        ),
        if (passengers?.haveInfant == true) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () {
                bloc.changeInfantSelected(i);
              },
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'paymentView.infant'.tr(),
                      style: kHugeHeavy.copyWith(color: Styles.kDartBlack),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      (state.manageBookingResponse?.result
                                  ?.passengersWithSSR?[i].infantExpanded ??
                              true)
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ExpandedSection(
            expand: state.manageBookingResponse?.result?.passengersWithSSR?[i]
                    .infantExpanded ??
                false,
            child: Column(
              children: [
                DoubleLineTextTable(
                  label: 'familyDetail.fName'.tr(),
                  value: passengers?.infantGivenName ?? '',
                ),
                kVerticalSpacerSmall,
                DoubleLineTextTable(
                  label: 'familyDetail.lName'.tr(),
                  value: passengers?.infantSurname ?? '',
                ),
                kVerticalSpacerSmall,
                DoubleLineTextTable(
                  label: 'passengerDetail.nationality'.tr(),
                  value: passengers?.infantNationality ?? '',
                ),
                kVerticalSpacer,
                AppInputText(
                  isRequired: true,
                  name: 'infpassportKey${i.toString()}',
                  hintText: 'passportNo'.tr(),
                  label: 'passportNo'.tr(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      state.manageBookingResponse?.result
                          ?.infanct(
                              state.manageBookingResponse?.result
                                      ?.passengersWithSSR?[i].infantGivenName ??
                                  '',
                              state.manageBookingResponse?.result
                                      ?.passengersWithSSR?[i].infantSurname ??
                                  '',
                              state.manageBookingResponse?.result
                                      ?.passengersWithSSR?[i].infantDob ??
                                  '')
                          ?.checkInPassportNo = newValue;
                      bloc.anyThingChanged();


                    }
                  },
                  initialValue: state.manageBookingResponse?.result
                      ?.passengersWithSSR?[i].passengers?.passport,
                  textInputType: TextInputType.text,

                  validators: [
                    (value) {
                      if (state.manageBookingResponse?.result
                              ?.passengersWithSSR?[i].paxSelected ==
                          true) {
                        if (value == null) {
                          return 'passportRequired'.tr();
                        }
                        if (value.isEmpty) {
                          return 'passportRequired'.tr();
                        }
                      }
                      return null;
                    }
                  ],
                  //validators: [
                  //  FormBuilderValidators.required(),

                  //],
                ),
                kVerticalSpacerSmall,

                PassportExpiryDatePicker(
                  onChanged: (int date, int month, int year,bool ignore) {
                    if(ignore) {
                      return;

                    }
                    DateTime newDate = DateTime(year, month, date);

                    state.manageBookingResponse?.result
                        ?.infanct(
                        state.manageBookingResponse?.result
                            ?.passengersWithSSR?[i].infantGivenName ??
                            '',
                        state.manageBookingResponse?.result
                            ?.passengersWithSSR?[i].infantSurname ??
                            '',
                        state.manageBookingResponse?.result
                            ?.passengersWithSSR?[i].infantDob ??
                            '')
                        ?.passExpdate = newDate.toString();

                    bloc.anyThingChanged();

                    print('');

                  }, initalValues: null,
                ),

                true ? Container() : FormBuilderDateTimePicker(
                  name: 'infformNameDob${i.toString()}',
                  firstDate: DateTime.now().add(Duration(days: 1)),
                  lastDate: DateTime.now().add(Duration(days: 5475)),
                  format: DateFormat("dd MMM yyyy"),
                  onChanged: (newData) {

                  },
                  initialDate: DateTime(2000),
                  initialEntryMode: DatePickerEntryMode.calendar,
                  validator: (value) {
                    if (state.manageBookingResponse?.result
                            ?.passengersWithSSR?[i].paxSelected ==
                        true) {
                      if (value == null) {
                        return 'passportExpiry'.tr();
                      }
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "passportExpiry".tr(),
                      suffixIcon: const Icon(Icons.calendar_month_sharp),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 12)),
                  inputType: InputType.date,
                ),
                kVerticalSpacerSmall,
                kVerticalSpacerMini,
              ],
            ),
          ),
        ],
      ],
    );
  }
}
