import 'package:app/blocs/local_user/local_user_bloc.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/booking_details_view.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/shadow_input.dart';
import 'package:app/widgets/app_countries_dropdown.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/containers/app_expanded_section.dart';
import 'package:app/widgets/containers/grey_card.dart';
import 'package:app/widgets/forms/app_input_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../../../blocs/profile/profile_cubit.dart';
import '../../../../../data/requests/flight_summary_pnr_request.dart';
import '../../../../../data/responses/manage_booking_response.dart';
import '../../../../../theme/theme.dart';

class PassengerCompanyInfo extends StatefulWidget {
  final bool isManageBooking;
  final CompanyTaxInvoice? companyTaxInvoice;


  const PassengerCompanyInfo({
    Key? key,  this.isManageBooking = false, this.companyTaxInvoice,
  }) : super(key: key);

  @override
  State<PassengerCompanyInfo> createState() => PassengerCompanyInfoState();
}

class PassengerCompanyInfoState extends State<PassengerCompanyInfo> {
  String? name;
  String? address;
  String? state;
  String? city;
  String? postCode;
  String? emailAddress;
  bool isExpand = false;
  final nationalityController = TextEditingController();
  final stateController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.isManageBooking) {
      name = widget.companyTaxInvoice?.companyName ?? '';
      address = widget.companyTaxInvoice?.companyAddress ?? '';
      state = widget.companyTaxInvoice?.state ?? '';
      city = widget.companyTaxInvoice?.city ?? '';
      emailAddress = widget.companyTaxInvoice?.emailAddress ?? '';
      postCode = widget.companyTaxInvoice?.postCode ?? '';
    }
    else {
      final contact = context.read<LocalUserBloc>().state.companyTaxInvoice;
      name = contact?.companyName;
      address = contact?.companyAddress;
      state = contact?.state;
      city = contact?.city;
      emailAddress = contact?.emailAddress;
      postCode = contact?.postCode;
    }


  }

  void fillEmail() {
    if ((emailController.text ?? '').isEmpty) {
      final request = context.read<LocalUserBloc>().state;
      emailController.text = request.contactEmail;
    }
  }

  @override
  Widget build(BuildContext context) {
    ManageBookingCubit? manageBloc = context.watch<ManageBookingCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

     if(widget.isManageBooking == false) ... [
       kVerticalSpacer,

       const AppDividerFadeWidget(),
       kVerticalSpacer,
     ],

        Visibility(
          visible: true,
          child: InkWell(
            onTap: () {
              setState(() {
                isExpand = !isExpand;
              });
            },
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'companyContact.companyTaxInvoice'.tr(),
                          style: k18Heavy.copyWith(color: Styles.kTextColor),
                        ),
                        if(widget.isManageBooking == false) ... [
                          TextSpan(
                            text: " (${'optional'.tr()})",
                            style:
                            kMediumRegular.copyWith(color: Styles.kTextColor),
                          ),
                        ],

                      ],
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Icon(
                  isExpand
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
        ),
        kVerticalSpacer,
        ExpandedSection(
          expand: isExpand,
          child: Column(
            children: [
              AppInputText(
                name: formNameCompanyName,
                initialValue: name,
                hintText: 'companyName'.tr(),
                onChanged: (value) {
                  if(widget.isManageBooking) {
                    manageBloc.setCompanyTaxValue(value ?? '',isName: true);
                    return;
                  }

                  final request =
                      context.read<LocalUserBloc>().state.companyTaxInvoice;
                  final newRequest = request?.copyWith(companyName: value);
                  context
                      .read<LocalUserBloc>()
                      .add(UpdateCompany(newRequest));

                  if ((value ?? '').isNotEmpty) {
                    //if((emailAddress ?? '').isEmpty){
                    fillEmail();
                    // }
                  }
                },
              ),
              kVerticalSpacer,
              AppInputText(
                name: formNameCompanyAddress,
                initialValue: address,
                hintText: 'companyAddress'.tr(),
                onChanged: (value) {
                  if(widget.isManageBooking) {
                    manageBloc.setCompanyTaxValue(value ?? '',isAddress: true);
                    return;
                  }

                  final request =
                      context.read<LocalUserBloc>().state.companyTaxInvoice;
                  final newRequest = request?.copyWith(companyAddress: value);
                  context
                      .read<LocalUserBloc>()
                      .add(UpdateCompany(newRequest));
                },
              ),
              kVerticalSpacer,
              ShadowInput(
                textEditingController: nationalityController,
                name: formNameCompanyCountry,
                child: AppCountriesDropdown(
                  onChanged: (value){
                    if(widget.isManageBooking) {
                      manageBloc.setCompanyTaxValue(value?.country ?? '',isAddress: true);
                      return;
                    }
                  },
                  dropdownDecoration: Styles.getDefaultFieldDecoration(),
                  hintText: "country".tr(),
                  isPhoneCode: false,
                ),
              ),
              kVerticalSpacer,


              AppInputText(
                name: formNameCompanyState,
                initialValue: state,
                hintText: 'state'.tr(),
                onChanged: (value) {
                  if(widget.isManageBooking) {
                    manageBloc.setCompanyTaxValue(value ?? '',isState: true);
                    return;
                  }

                  final request =
                      context.read<LocalUserBloc>().state.companyTaxInvoice;
                  final newRequest = request?.copyWith(state: value);
                  context
                      .read<LocalUserBloc>()
                      .add(UpdateCompany(newRequest));
                },
              ),
              kVerticalSpacer,
              AppInputText(
                name: formNameCompanyCity,
                initialValue: city,
                hintText: 'city'.tr(),
                onChanged: (value) {
                  if(widget.isManageBooking) {
                    manageBloc.setCompanyTaxValue(value ?? '',isCity: true);
                    return;
                  }
                  final request =
                      context.read<LocalUserBloc>().state.companyTaxInvoice;
                  final newRequest = request?.copyWith(city: value);
                  context
                      .read<LocalUserBloc>()
                      .add(UpdateCompany(newRequest));
                },
              ),
              kVerticalSpacer,
              AppInputText(
                name: formNameCompanyPostCode,
                initialValue: postCode,
                hintText: 'postcode'.tr(),
                onChanged: (value) {
                  if(widget.isManageBooking) {
                    manageBloc.setCompanyTaxValue(value ?? '',isPosCode: true);
                    return;
                  }

                  final request =
                      context.read<LocalUserBloc>().state.companyTaxInvoice;
                  final newRequest = request?.copyWith(postCode: value);
                  context
                      .read<LocalUserBloc>()
                      .add(UpdateCompany(newRequest));
                },
              ),
              kVerticalSpacer,
              AppInputText(
                name: formNameCompanyEmailAddress,
                hintText: 'emailAddress'.tr(),
                textEditingController: emailController,
                validators: [FormBuilderValidators.email()],
                onChanged: (value) {

                  if(widget.isManageBooking) {
                    manageBloc.setCompanyTaxValue(value ?? '',isEmail: true);
                    return;
                  }


                  emailAddress = value;

                  final request =
                      context.read<LocalUserBloc>().state.companyTaxInvoice;
                  final newRequest = request?.copyWith(emailAddress: value);
                  context
                      .read<LocalUserBloc>()
                      .add(UpdateCompany(newRequest));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
