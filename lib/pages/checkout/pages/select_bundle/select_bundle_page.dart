import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/blocs/routes/routes_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/models/cms_route.dart';
import 'package:app/pages/checkout/pages/select_bundle/ui/bundle_list.dart';
import 'package:app/pages/checkout/ui/addon_layout.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_divider_widget.dart';
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
    final state = context.read<RoutesCubit>().state;
    context.read<CmsSsrCubit>().getCmsSSR(state.routes);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final type =
        context.watch<SearchFlightCubit>().state.filterState?.flightType;
    final List<Widget> tabBody = [];
    tabBody.add(BundleList(isDeparture: true));
    if (type == FlightType.round) {
      tabBody.add(BundleList(isDeparture: false));
    }
    return Scaffold(
      appBar: AppAppBar(),
      body: AddonLayout(
        child: tabBody,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
