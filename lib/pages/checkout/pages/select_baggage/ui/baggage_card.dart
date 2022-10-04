import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:app/utils/string_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../theme/theme.dart';

class BaggageCard extends StatelessWidget {
  final Bundle selectedBundle;
  const BaggageCard({Key? key, required this.selectedBundle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDeparture = context.watch<IsDepartureCubit>().state;
    final selectedPerson = context.watch<SelectedPersonCubit>().state;
    final state = context.watch<SearchFlightCubit>().state;
    final persons = state.filterState?.numberPerson;
    final focusedPerson = persons?.persons
        .firstWhereOrNull((element) => element == selectedPerson);
    final bundle = isDeparture
        ? focusedPerson?.departureBaggage
        : focusedPerson?.returnBaggage;
    return GestureDetector(
      onTap: (){
        context
            .read<SearchFlightCubit>()
            .addBaggageToPerson(selectedPerson, selectedBundle, isDeparture);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        width: 500.w,
        child: AppCard(
          child: Column(
            children: [
              Image.asset("assets/images/design/baggage-small.png"),
              kVerticalSpacer,
              Text(selectedBundle.codeType?.capitalize() ?? "No Code"),
              kVerticalSpacer,
              Text(selectedBundle.description?.capitalize() ?? "No Baggage"),
              kVerticalSpacer,
              MoneyWidget(
                  amount: selectedBundle.amount,
                  currency: selectedBundle.currencyCode),
              kVerticalSpacer,
              Radio<Bundle?>(
                value: selectedBundle,
                groupValue: bundle,
                onChanged: (value) {
                  context
                      .read<SearchFlightCubit>()
                      .addBaggageToPerson(selectedPerson, selectedBundle, isDeparture);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
