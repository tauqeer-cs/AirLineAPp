import 'package:app/app/app_bloc_helper.dart';
import 'package:app/pages/home/bloc/home/home_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/home/ui/home_banner.dart';
import 'package:app/widgets/app_error_screen.dart';
import 'package:app/widgets/app_logo_widget.dart';
import 'package:app/widgets/containers/grey_card.dart';
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
          const AppLogoWidget(),
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
          const Padding(
            padding: kPageHorizontalPadding,
            child: GreyCard(
              child: SearchFlightWidget(
                isHome: true,
              ),
            ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 8),
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
                    return const SizedBox();
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
