import 'package:app/app/app_bloc_helper.dart';
import 'package:app/pages/home/bloc/home/home_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/home/ui/home_banner.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_error_screen.dart';
import 'package:app/widgets/app_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const NotificationsWidget(),
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
        Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromRGBO(235, 235, 235, 0.75),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.21),
                offset: const Offset(0, 2),
                blurRadius: 6,
                spreadRadius: 0
              ),
            ],
          ),
          child: const SearchFlightWidget(
            isHome: true,
          ),
        ),
        kVerticalSpacer,
        Padding(
          padding: kPageHorizontalPaddingBig,
          child: Text(
            "Ongoing Promotions",
            style: kLargeRegular.copyWith(color: Styles.kTextColor),
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
    );
  }
}
