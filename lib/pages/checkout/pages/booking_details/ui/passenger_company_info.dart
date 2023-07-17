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

import '../../../../../blocs/countries/countries_cubit.dart';
import '../../../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../../../blocs/profile/profile_cubit.dart';
import '../../../../../custom_packages/dropdown_search/src/properties/dropdown_decorator_props.dart';
import '../../../../../data/requests/flight_summary_pnr_request.dart';
import '../../../../../data/responses/manage_booking_response.dart';
import '../../../../../models/country.dart';
import '../../../../../theme/theme.dart';
import '../../../../../widgets/forms/app_dropdown.dart';
import '../../../../home/ui/filter/dropdown_transformer.dart';

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
  String? country;

  List<String>? stateCities = [];

  String? postCode;
  String? emailAddress;
  bool isExpand = false;
  final nationalityController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();

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
      country =  widget.companyTaxInvoice?.country;

      cityController.text = city ?? '';

      print('object');

    }
    else {
      final contact = context.read<LocalUserBloc>().state.companyTaxInvoice;
      name = contact?.companyName;
      address = contact?.companyAddress;
      state = contact?.state;
      stateController.text = state ?? '';

      city = contact?.city;
      emailAddress = contact?.emailAddress;
      postCode = contact?.postCode;
      country = 'Malaysia';
      cityController.text = city ?? '';


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

    CountriesCubit? cbloc = context.read<CountriesCubit>();


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

              if(country == 'Malaysia') ... [

                ShadowInput(
                  name: formNameCompanyState,
                  textEditingController: stateController,
                  child: AppDropDown<States>(
                    dropdownDecoration: Styles.getDefaultFieldDecoration(),
                    items: cbloc.state.states ?? [],
                    sheetTitle: "state".tr(),
                    onChanged: (value) {
                      state = value?.stateName ?? '';

                      if(value != null) {
                        //stateCities = value.stateCities ?? '';
                       setState(() {
                         stateCities =  value.stateCities;

                       });


                      }


                      if(widget.isManageBooking) {
                        manageBloc.setCompanyTaxValue(value?.stateName ?? '',isState: true);
                        return;
                      }

                      final request =
                          context.read<LocalUserBloc>().state.companyTaxInvoice;
                      final newRequest = request?.copyWith(state: value?.stateName ?? '');
                      context
                          .read<LocalUserBloc>()
                          .add(UpdateCompany(newRequest));
                    },

                    valueTransformerItem: (value, selected) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                               value?.stateName ?? "",
                            style: kMediumMedium.copyWith(
                              color: selected ? Styles.kPrimaryColor : null,
                            ),
                          ),
                        ],
                      );
                    },
                    valueTransformer: (value) {
                      return DropdownTransformerWidget<States>(
                        value: value,
                        valueCustom:  value?.stateName ?? '',
                      );
                    },

                  ),
                ),
               kVerticalSpacer,

                if( (stateCities ?? []).isNotEmpty) ... [

                  ShadowInput(
                    name: formNameCompanyCity,
                    textEditingController: cityController,
                    child: AppDropDown<String>(
                      dropdownDecoration: Styles.getDefaultFieldDecoration(),
                      items: stateCities ?? [],
                      sheetTitle: "city".tr(),
                      onChanged: (value) {

                        city = value ?? '';

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

                      valueTransformerItem: (value, selected) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              value ?? "",
                              style: kMediumMedium.copyWith(
                                color: selected ? Styles.kPrimaryColor : null,
                              ),
                            ),
                          ],
                        );
                      },
                      valueTransformer: (value) {
                        return DropdownTransformerWidget<String>(
                          value: value,
                          valueCustom:  value ?? '',
                        );
                      },

                    ),
                  ),
                  kVerticalSpacer,
                ],

              ] else ... [
                AppInputText(
                  name: formNameCompanyState,
                  initialValue: state,
                  hintText: 'state'.tr(),
                  onChanged: (value) {

                    state = value;

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
              ],



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
