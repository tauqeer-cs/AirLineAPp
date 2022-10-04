import 'package:app/app/app_router.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/pages/checkout/pages/select_bundle/ui/bundle_card.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/checkout/ui/person_selector.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BundleList extends StatefulWidget {
  final bool isDeparture;

  const BundleList({Key? key, required this.isDeparture}) : super(key: key);

  @override
  State<BundleList> createState() => _BundleListState();
}

class _BundleListState extends State<BundleList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ssr = context.watch<BookingCubit>().state.verifyResponse?.flightSSR;
    final bundles = widget.isDeparture
        ? ssr?.bundleGroup?.outbound
        : ssr?.bundleGroup?.inbound;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: AppCard(
            child: Column(
              children: [
                kVerticalSpacer,
                Text("Bundle", style: kGiantHeavy),
                PersonSelector(),
                kVerticalSpacer,
                Column(
                  children: [
                    BundleCard(
                        inboundBundle: null, isDeparture: widget.isDeparture),
                    ...bundles
                            ?.map(
                              (e) => BundleCard(
                                  inboundBundle: e,
                                  isDeparture: widget.isDeparture),
                            )
                            .toList() ??
                        []
                  ],
                ),
              ],
            ),
          ),
        ),
        kVerticalSpacer,
        CheckoutSummary(),
        kVerticalSpacer,
        AppDividerWidget(),
        kVerticalSpacer,
        BookingSummary(),
        kVerticalSpacer,
        ElevatedButton(
          onPressed: () => context.router.push(SelectSeatsRoute()),
          child: Text("Continue"),
        ),
        kVerticalSpacer,
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
