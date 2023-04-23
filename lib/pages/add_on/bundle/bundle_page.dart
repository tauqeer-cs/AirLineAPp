import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/add_on/bundle/ui/bundle_view.dart';
import 'package:app/utils/user_insider.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_booking_step.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_insider/flutter_insider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../app/app_router.dart';

class BundlePage extends StatefulWidget {
  final bool isDeparture;

  const BundlePage({Key? key, this.isDeparture = true}) : super(key: key);

  @override
  State<BundlePage> createState() => _BundlePageState();
}

class _BundlePageState extends State<BundlePage> {
  @override
  void initState() {
    super.initState();
    FlutterInsider.Instance.visitProductDetailPage(
        UserInsider.of(context).generateProduct());
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: AppLoadingScreen(message: "loading".tr()),
      child: BlocListener<SearchFlightCubit, SearchFlightState>(
        listener: (context, state) {
          if (state.blocState == BlocState.failed) {
            context.router.pop();
          }
        },
        child: Scaffold(
          appBar: AppAppBar(
            title: "yourTripStartsHere".tr(),
            height: 100.h,
            flexibleWidget: AppBookingStep(
              passedSteps: const [BookingStep.flights, BookingStep.addOn],
              onTopStepTaped: (int index) {
                if (index == 0) {
                  context.router.popUntilRouteWithName(SearchResultRoute.name);
                } else {
                  context.router.popUntilRouteWithName(SeatsRoute.name);
                }
              },
            ),
          ),
          body: BlocBuilder<BookingCubit, BookingState>(
            builder: (context, state) {
              return blocBuilderWrapper(
                blocState: state.blocState,
                finishedBuilder: BundleView(isDeparture: widget.isDeparture),
              );
            },
          ),
        ),
      ),
    );
  }
}
