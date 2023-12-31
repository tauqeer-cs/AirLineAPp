import 'package:app/app/app_router.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/pages/checkout/pages/select_bundle/ui/bundle_card.dart';
import 'package:app/pages/checkout/pages/select_seats/ui/seats_legend.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/checkout/ui/person_selector.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
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
    final bundleNotice = context.watch<CmsSsrCubit>().state.bundleNotice;

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: AppCard(
            child: Column(
              children: [
                kVerticalSpacer,
                const Text("Bundle", style: kGiantHeavy),
                const PersonSelector(),
                kVerticalSpacer,
                ContainerNotice(sharedNotice: bundleNotice),
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
        const CheckoutSummary(),
        kVerticalSpacer,
        const AppDividerWidget(),
        kVerticalSpacer,
        const BookingSummary(),
        kVerticalSpacer,
        ElevatedButton(
          onPressed: () => context.router.push(const SelectSeatsRoute()),
          child: Text("continue".tr()),
        ),
        kVerticalSpacer,
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
