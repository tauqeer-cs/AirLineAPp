import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/pages/home_detail/bloc/home_detail_cubit.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/widgets/app_error_screen.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:auto_route/auto_route.dart';
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
        print("failed listener");
        if(state.blocState == BlocState.failed){
          print("url is $url");
          final secureUrl = url.replaceAll("http://", "https://");
          context.router.replace(
            WebViewRoute(url: secureUrl, title: 'Promotion'),
          );
        }
      },
      builder: (context, state) {
        print("failed listener ${state.blocState}");

        return blocBuilderWrapper(
          blocState: state.blocState,
          failedBuilder: AppLoadingScreen(),
          finishedBuilder: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Html(
                  data: state.content?.data?.current?.content ?? "",
                ),
                ElevatedButton(
                    onPressed: () => context.router.pop(),
                    child: Text("Search Flight")),
                kVerticalSpacer,
              ],
            ),
          ),
        );
      },
    );
  }
}
