import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/select_baggage/ui/baggage_selections.dart';
import 'package:app/pages/checkout/ui/addon_layout.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectBaggagePage extends StatefulWidget {
  const SelectBaggagePage({Key? key}) : super(key: key);

  @override
  State<SelectBaggagePage> createState() => _SelectBaggagePageState();
}

class _SelectBaggagePageState extends State<SelectBaggagePage>
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
        child: const BaggageSelections(),
      ),
    );
    if (type == FlightType.round) {
      tabBody.add(
        BlocProvider(
          create: (context) => IsDepartureCubit()..changeDeparture(false),
          child: const BaggageSelections(),
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
