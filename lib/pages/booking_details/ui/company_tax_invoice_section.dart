import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../../data/requests/flight_summary_pnr_request.dart';
import '../../../data/responses/manage_booking_response.dart';
import '../../../models/confirmation_model.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../widgets/containers/app_expanded_section.dart';
import '../../checkout/pages/booking_details/ui/passenger_company_info.dart';
import 'double_line_text.dart';

class ComapnyTaxInvoiceSection extends StatelessWidget {
  final bool isManageBooking;

  const ComapnyTaxInvoiceSection(
      {Key? key, this.isManageBooking = false, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ManageBookingCubit>();
    final state = bloc.state;

CompanyTaxInvoice? bookingContact =
        state.manageBookingResponse?.result?.companyTaxInvoice;


    return Column(
      children: [

        true
            ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: PassengerCompanyInfo(
                    isManageBooking: true,
                    companyTaxInvoice: bookingContact,
                  ),
            )

            : ExpandedSection(
                expand: state.companyTaxInvoiceExpanded,
                child: Column(
                  children: [
                    kVerticalSpacerSmall,
                    DoubleLineTextTable(
                      label: 'companyName'.tr(),
                      value: bookingContact?.companyName ?? '',
                    ),
                    kVerticalSpacer,
                    DoubleLineTextTable(
                      label: 'companyAddress'.tr(),
                      value: bookingContact?.companyAddress ?? '',
                    ),
                    kVerticalSpacer,
                    DoubleLineTextTable(
                      label: 'infoDetail.country'.tr(),
                      value: bookingContact?.country ?? '',
                    ),
                    kVerticalSpacer,
                    DoubleLineTextTable(
                      label: 'state'.tr(),
                      value: bookingContact?.state ?? '',
                    ),
                    kVerticalSpacer,
                    DoubleLineTextTable(
                      label: 'city'.tr(),
                      value: bookingContact?.city ?? '',
                    ),
                    kVerticalSpacer,
                    DoubleLineTextTable(
                      label: 'postalCode'.tr(),
                      value: bookingContact?.postCode ?? '',
                    ),
                    kVerticalSpacer,
                    DoubleLineTextTable(
                      label: 'loginForm.email'.tr(),
                      value: bookingContact?.emailAddress ?? '',
                    ),
                    kVerticalSpacer,
                  ],
                ),
              ),

        Divider(
          height: 1,
          color: Styles.kDisabledButton,
        ),
        kVerticalSpacer,

        //kDisabledButton
      ],
    );
  }
}
