import 'package:app/app/app_bloc_helper.dart';
import 'package:app/pages/home/bloc/home/home_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight.dart';
import 'package:app/pages/home/ui/home_banner.dart';
import 'package:app/pages/home/ui/home_center.dart';
import 'package:app/pages/home/ui/home_deal.dart';
import 'package:app/widgets/app_error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/theme.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        kVerticalSpacer,
        Padding(
          padding: kPageHorizontalPadding,
          child: SearchFlight(),
        ),
        kVerticalSpacer,
        BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            print("home state is $state");
            return blocBuilderWrapper(
              blocState: state.blocState,
              finishedBuilder: Column(
                children: state.contents.map((e) {
                  switch(e.name){
                    case "3D Carousel Banner":
                      return Padding(
                        padding: kPageHorizontalPadding,
                        child: HomeBanner(content: e),
                      );
                    case "Flight Deals":
                      return Padding(
                        padding: kPageHorizontalPaddingBig,
                        child: HomeDeal(content: e),
                      );
                    case "Homepage center":
                      return HomeCenter(content: e);
                  }
                  return SizedBox();
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
