import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/ui/fare_detail_widget.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_divider_widget.dart';
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
            Text(
              "Meals",
              style: kHugeSemiBold,
            ),
            Spacer(),
            MoneyWidget(
              amount: meals?.totalAmount,
              isDense: true,
            ),
          ],
        ),
        kVerticalSpacerSmall,
        ...(meals?.meals ?? [])
            .map((e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${e.title} ${e.givenName} ${e.surName}"),
                    ...(e.mealList??[]).map((e) => Text("${e.mealName} x${e.quantity}")).toList(),
                    kVerticalSpacerSmall,
                  ],
                ))
            .toList(),
        kVerticalSpacerSmall,
      ],
    );
  }
}