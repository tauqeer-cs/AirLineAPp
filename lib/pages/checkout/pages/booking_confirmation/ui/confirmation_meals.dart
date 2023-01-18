import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationMeals extends StatelessWidget {
  const ConfirmationMeals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final meals = context
        .watch<ConfirmationCubit>()
        .state
        .confirmationModel
        ?.value
        ?.mealDetail;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Meals",
              style: kHugeSemiBold,
            ),
            const Spacer(),
            MoneyWidget(
              amount: meals?.totalAmount,
              isDense: true,
              isNormalMYR: true,
            ),
          ],
        ),
        kVerticalSpacerSmall,
        ...(meals?.meals ?? [])
            .map((e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if( e.mealList?.isNotEmpty ?? false) ... [
                      Text("${e.titleToShow} ${e.givenName} ${e.surName}"),
                      ...(e.mealList??[]).map((e) => Text("${e.mealName} x${e.quantity}")).toList(),
                      kVerticalSpacerSmall,
                    ]

                  ],
                ))
            .toList(),
        kVerticalSpacerSmall,
      ],
    );
  }
}
