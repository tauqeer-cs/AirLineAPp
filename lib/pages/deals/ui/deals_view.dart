import 'package:app/app/app_bloc_helper.dart';
import 'package:app/pages/home/bloc/home/home_cubit.dart';
import 'package:app/pages/home/ui/home_banner.dart';
import 'package:app/pages/home/ui/home_center.dart';
import 'package:app/pages/home/ui/home_deal.dart';
import 'package:app/pages/home/ui/home_deal_grid.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DealsView extends StatelessWidget {
  const DealsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("On a tight budget?", style: kHugeRegular),
            Text("Check out these amazing deals", style: kGiantHeavy),
          ],
        ),
      ),
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
                  case "Flight Deals":
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: HomeDealGrid(content: e),
                    );
                  // case "Homepage center":
                  //   return HomeCenter(content: e);
                }
                return SizedBox();
              }).toList(),
            ),
            failedBuilder: AppErrorScreen(message: state.message),
          );
        },
      ),
      kVerticalSpacer,
    ];
    return ListView.builder(
      itemBuilder: (context, index) => widgets[index],
      itemCount: widgets.length,
    );
  }
}
