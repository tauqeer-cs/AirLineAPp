import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationMeals extends StatelessWidget {
  final bool isDeparture;

  const ConfirmationMeals({Key? key, required this.isDeparture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final meals = context
        .watch<ConfirmationCubit>()
        .state
        .confirmationModel
        ?.value
        ?.mealDetail;

    var currency = context
        .watch<ConfirmationCubit>()
        .state
        .confirmationModel
        ?.value
        ?.fareAndBundleDetail
        ?.currencyToShow ??
        'MYR';

    return (meals?.noMealsSelected ?? false) ||  (meals?.totalAmount==0)
        ? Container()
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "priceSection.mealsTitle".tr(),
              style: kHugeSemiBold,
            ),
            const Spacer(),
            MoneyWidget(
              currency: currency,
              amount: meals?.totalAmount,
              isDense: true,
              isNormalMYR: true,
            ),
          ],
        ),
        kVerticalSpacerSmall,
        ...(isDeparture ? meals!.departureMeals : meals!.returnMeals)
            .map((e) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (e.mealList?.isNotEmpty ?? false) ...[
              Text(
                  "${e.titleToShow} ${e.givenName} ${e.surName}"),
              ...(e.mealList ?? [])
                  .map(
                      (e) => Text("${e.mealName} x${e.quantity}"))
                  .toList(),
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
