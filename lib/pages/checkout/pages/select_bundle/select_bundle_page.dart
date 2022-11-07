import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/pages/select_bundle/ui/bundle_list.dart';
import 'package:app/pages/checkout/ui/addon_layout.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectBundlePage extends StatefulWidget {
  const SelectBundlePage({Key? key}) : super(key: key);

  @override
  State<SelectBundlePage> createState() => _SelectBundlePageState();
}

class _SelectBundlePageState extends State<SelectBundlePage>
    with AutomaticKeepAliveClientMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final type =
        context.watch<SearchFlightCubit>().state.filterState?.flightType;
    final List<Widget> tabBody = [];
    tabBody.add(const BundleList(isDeparture: true));
    if (type == FlightType.round) {
      tabBody.add(const BundleList(isDeparture: false));
    }
    return Scaffold(
      body: AddonLayout(
        child: tabBody,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
