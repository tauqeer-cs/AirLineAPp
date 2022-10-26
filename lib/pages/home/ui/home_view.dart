import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/pages/home/bloc/home/home_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/home/ui/filter/submit_search.dart';
import 'package:app/pages/home/ui/home_banner.dart';
import 'package:app/pages/home/ui/home_center.dart';
import 'package:app/pages/home/ui/home_deal.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_error_screen.dart';
import 'package:app/widgets/app_logo_widget.dart';
import 'package:app/widgets/containers/glass_card.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          //NotificationsWidget(),
          kVerticalSpacer,
          AppLogoWidget(),
          // Padding(
          //   padding: kPageHorizontalPaddingBig,
          //   child: Text(
          //     "Hi Guest, \nLet's Fly",
          //     style: kGiantSemiBold.copyWith(color: Colors.white),
          //   ),
          // ),
          // kVerticalSpacer,
          // NotificationsWidget(),
          kVerticalSpacer,
          Padding(
            padding: kPageHorizontalPadding,
            child: SearchFlightWidget(),
          ),
          kVerticalSpacerSmall,
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return blocBuilderWrapper(
                blocState: state.blocState,
                finishedBuilder: Column(
                  children: state.contents.map((e) {
                    switch (e.name) {
                      case "3D Carousel Banner":
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: HomeBanner(content: e),
                        );
                     /* case "Flight Deals":
                        return Padding(
                          padding: kPageHorizontalPaddingBig,
                          child: HomeDeal(content: e),
                        );*/
                      /*case "Homepage center":
                        return HomeCenter(content: e);*/
                    }
                    return SizedBox();
                  }).toList(),
                ),
                failedBuilder: AppErrorScreen(message: state.message),
              );
            },
          ),
        ],
      ),
    );
  }
}
