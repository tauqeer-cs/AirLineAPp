import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/pages/home_detail/bloc/home_detail_cubit.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class HomeDetailView extends StatelessWidget {
  final String url;

  const HomeDetailView({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeDetailCubit, HomeDetailState>(
      listener: (_, state) {
        if (state.blocState == BlocState.failed) {
          final secureUrl = url.replaceAll("http://", "https://");
          context.router.replace(
            WebViewRoute(url: secureUrl, title: 'Promotion'),
          );
        }
      },
      builder: (context, state) {
        return blocBuilderWrapper(
          blocState: state.blocState,
          failedBuilder: const AppLoadingScreen(),
          finishedBuilder: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Html(
                  data: state.content?.data?.current?.content ?? "",
                ),
                ElevatedButton(
                    onPressed: () => context.router.pop(),
                    child: Text("searchFlight".tr())),
                kVerticalSpacer,
              ],
            ),
          ),
        );
      },
    );
  }
}
