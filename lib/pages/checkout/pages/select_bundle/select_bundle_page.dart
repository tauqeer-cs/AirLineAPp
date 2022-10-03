import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/pages/checkout/pages/select_bundle/ui/bundle_list.dart';
import 'package:app/pages/checkout/ui/addon_layout.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectBundlePage extends StatelessWidget {
  const SelectBundlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final type =
        context.watch<SearchFlightCubit>().state.filterState?.flightType;
    return Scaffold(
      appBar: AppAppBar(),
      body: AddonLayout(
        child: [
          BundleList(),
          BundleList(),

        ],
      ),
    );
  }
}
