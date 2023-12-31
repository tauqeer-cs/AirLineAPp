import 'package:app/pages/home/ui/filter/airport_widget.dart';
import 'package:app/pages/home/ui/filter/calendar_widget.dart';
import 'package:app/pages/home/ui/filter/passengers_widget.dart';
import 'package:app/pages/home/ui/filter/submit_search.dart';
import 'package:app/pages/home/ui/filter/trip_selection.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../utils/constant_utils.dart';
import '../../../../widgets/forms/app_input_text.dart';
import '../../bloc/filter_cubit.dart';

class SearchFlightWidget extends StatelessWidget {
  final bool isHome;

  const SearchFlightWidget({Key? key, required this.isHome}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TripSelection(),
        const AirportWidget(isOrigin: true),
        kVerticalSpacerSmall,
        const AirportWidget(isOrigin: false),
        kVerticalSpacerSmall,
        const CalendarWidget(),
        kVerticalSpacerSmall,
        const PassengersWidget(),
        kVerticalSpacerSmall,
        if (ConstantUtils.showPromoTextField) ...[
          AppInputText(
              name: "promoFlight",
              inputDecoration: InputDecoration(
                hintText: 'promoCodeExample'.tr(),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Styles.kBorderColor),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Styles.kBorderColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Styles.kBorderColor),
                ),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Styles.kBorderColor.withOpacity(0.3)),
                ),
              ),
              onChanged: (value) =>
                  context.read<FilterCubit>().updatePromoCode(value),
              hintText: "promoCodeExample".tr(),
              inputFormatters: [
                UpperCaseTextFormatter(),
                FilteringTextInputFormatter.allow(RegExp("[A-Za-z0-9\']")),
              ]),
          kVerticalSpacer,
        ],
        kVerticalSpacer,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SubmitSearch(isHomePage: isHome),
        ),
      ],
    );
  }
}

enum FlightType {
  round('Round Trip', true, 'roundTrip'),
  oneWay('One Way', false, 'oneWayTrip');

  const FlightType(this.message, this.value, this.messageTranslated);

  final String message;
  final bool value;
  final String messageTranslated;

  @override
  String toString() {
    return message;
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.contains(" ")) {
      return oldValue;
    }
    return TextEditingValue(
      text: newValue.text.toUpperCase().trim(),
      selection: newValue.selection,
    );
  }
}
