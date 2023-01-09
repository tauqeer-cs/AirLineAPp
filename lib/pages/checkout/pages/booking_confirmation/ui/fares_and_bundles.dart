import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/fare_detail_widget.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaresAndBundles extends StatelessWidget {
  const FaresAndBundles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fares = context
        .watch<ConfirmationCubit>()
        .state
        .confirmationModel
        ?.value
        ?.fareAndBundleDetail;
    return Column(
      children: [
        Row(
          children: [
            const Text(
              "Fares And Bundles",
              style: kHugeSemiBold,
            ),
            const Spacer(),
            MoneyWidget(
              amount: fares?.totalAmount,
              isDense: true,
              isNormalMYR: true,
            ),
          ],
        ),
        kVerticalSpacerSmall,
        ...(fares?.fareAndBundles ?? [])
            .map((e) => FareDetailWidget(fareAndBundle: e))
            .toList(),
        kVerticalSpacerSmall,
      ],
    );
  }
}
