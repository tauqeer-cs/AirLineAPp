import 'package:app/app/app_router.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/card_summary.dart';
import 'package:app/pages/checkout/pages/booking_details/ui/list_of_passenger_info.dart';
import 'package:app/pages/checkout/ui/booking_details_header.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/checkout/ui/person_selector.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/widgets/app_booking_header.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../theme/theme.dart';

class BookingDetailsView extends StatelessWidget {
  static final _fbKey = GlobalKey<FormBuilderState>();

  const BookingDetailsView({Key? key}) : super(key: key);

  onBooking(BuildContext context) {
    if (_fbKey.currentState!.saveAndValidate()) {
      final value = _fbKey.currentState!.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[
      kVerticalSpacerBig,
      Padding(
        padding: kPageHorizontalPadding,
        child: Column(
          children: [
            AppBookingHeader(passedSteps: [
              BookingStep.flights,
              BookingStep.addOn,
              BookingStep.bookingDetails
            ]),
            kVerticalSpacer,
            BookingDetailsHeader(),
            kVerticalSpacer,
            CardSummary(),
            kVerticalSpacer,
            ListOfPassengerInfo(),
          ],
        ),
      ),
      CheckoutSummary(),
      kVerticalSpacer,
      Padding(
        padding: kPageHorizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AppDividerWidget(),
            kVerticalSpacer,
            BookingSummary(),
            kVerticalSpacer,
            ElevatedButton(
              onPressed: () => onBooking(context),
              child: Text("Continue"),
            ),
            kVerticalSpacer,
          ],
        ),
      ),
    ];
    return FormBuilder(
      autoFocusOnValidationFailure: true,
      key: _fbKey,
      child: true
          ? SingleChildScrollView(
              child: Column(
                children: [
                  kVerticalSpacerBig,
                  Padding(
                    padding: kPageHorizontalPadding,
                    child: Column(
                      children: [
                        AppBookingHeader(passedSteps: [
                          BookingStep.flights,
                          BookingStep.addOn,
                          BookingStep.bookingDetails
                        ]),
                        kVerticalSpacer,
                        BookingDetailsHeader(),
                        kVerticalSpacer,
                        CardSummary(),
                        kVerticalSpacer,
                        ListOfPassengerInfo(),
                      ],
                    ),
                  ),
                  CheckoutSummary(),
                  kVerticalSpacer,
                  Padding(
                    padding: kPageHorizontalPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        AppDividerWidget(),
                        kVerticalSpacer,
                        BookingSummary(),
                        kVerticalSpacer,
                        ElevatedButton(
                          onPressed: () => onBooking(context),
                          child: Text("Continue"),
                        ),
                        kVerticalSpacer,
                      ],
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) => widgets[index],
              itemCount: widgets.length,
            ),
    );
  }
}
