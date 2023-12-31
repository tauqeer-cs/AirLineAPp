import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/select_meals/ui/meal_selections.dart';
import 'package:app/pages/checkout/ui/addon_layout.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectMealsPage extends StatefulWidget {
  const SelectMealsPage({Key? key}) : super(key: key);

  @override
  State<SelectMealsPage> createState() => _SelectMealsPageState();
}

class _SelectMealsPageState extends State<SelectMealsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final type =
        context.watch<SearchFlightCubit>().state.filterState?.flightType;
    final List<Widget> tabBody = [];
    tabBody.add(
      BlocProvider(
        create: (context) => IsDepartureCubit()..changeDeparture(true),
        child: const MealSelections(),
      ),
    );
    if (type == FlightType.round) {
      tabBody.add(
        BlocProvider(
          create: (context) => IsDepartureCubit()..changeDeparture(false),
          child: const MealSelections(),
        ),
      );
    }
    return AppScaffold(
      child: AddonLayout(
        child: tabBody,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
