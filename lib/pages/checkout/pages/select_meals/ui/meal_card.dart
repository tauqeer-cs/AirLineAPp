import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/checkout/bloc/selected_person_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_image.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealCard extends StatelessWidget {
  final Bundle meal;

  const MealCard({Key? key, required this.meal}) : super(key: key);

  changeNumber(
      BuildContext context, Person? person, bool isAdd, bool isDeparture) {
    context.read<SearchFlightCubit>().addOrRemoveMealFromPerson(
          isDeparture: isDeparture,
          isAdd: isAdd,
          person: person,
          meal: meal,
        );
  }

  @override
  Widget build(BuildContext context) {
    final selectedPerson = context.watch<SelectedPersonCubit>().state;
    final state = context.watch<SearchFlightCubit>().state;
    final persons = state.filterState?.numberPerson;
    final focusedPerson = persons?.persons
        .firstWhereOrNull((element) => element == selectedPerson);
    final isDeparture = context.watch<IsDepartureCubit>().state;
    final meals =
        isDeparture ? focusedPerson?.departureMeal : focusedPerson?.returnMeal;
    final length = meals?.where((element) => element == meal).length;
    final cmsMeals = context.watch<CmsSsrCubit>().state.mealGroups;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        child: Row(
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: AppImage(
                imageUrl: cmsMeals.firstWhereOrNull((element) => element.code == meal.codeType)?.image,
              ),
            ),
            kHorizontalSpacer,
            Expanded(
              child: Column(
                children: [
                  Text(meal.description ?? "", textAlign: TextAlign.center,),
                  InputWithPlusMinus(
                    number: length ?? 0,
                    handler: changeNumber,
                    person: focusedPerson,
                  ),
                  MoneyWidget(currency: meal.currencyCode, amount: meal.amount),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputWithPlusMinus extends StatelessWidget {
  final int number;
  final Person? person;
  final Function(BuildContext, Person?, bool, bool) handler;

  const InputWithPlusMinus({
    Key? key,
    required this.number,
    required this.handler,
    required this.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDeparture = context.watch<IsDepartureCubit>().state;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 35.h,
                height: 35.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: const CircleBorder(), padding: EdgeInsets.zero),
                  onPressed: number > 0
                      ? () => handler(context, person, false, isDeparture)
                      : null,
                  child: const Icon(
                    Icons.remove,
                    size: 20,
                  ),
                ),
              ),
              Text(number.toString()),
              SizedBox(
                width: 35.h,
                height: 35.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      shape: const CircleBorder(), padding: EdgeInsets.zero),
                  onPressed: () => handler(context, person, true, isDeparture),
                  child: const Icon(
                    Icons.add,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
