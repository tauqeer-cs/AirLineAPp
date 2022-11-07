import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/select_seats/ui/seat_selections.dart';
import 'package:app/pages/checkout/ui/addon_layout.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectSeatsPage extends StatefulWidget {
  const SelectSeatsPage({Key? key}) : super(key: key);

  @override
  State<SelectSeatsPage> createState() => _SelectSeatsPageState();
}

class _SelectSeatsPageState extends State<SelectSeatsPage>
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
        child: const SeatSelections(),
      ),
    );
    if (type == FlightType.round) {
      tabBody.add(
        BlocProvider(
          create: (context) => IsDepartureCubit()..changeDeparture(false),
          child: const SeatSelections(),
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
