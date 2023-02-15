import 'package:app/app/app_bloc_helper.dart';
import 'package:app/pages/home_detail/bloc/home_detail_cubit.dart';
import 'package:app/theme/spacer.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class HomeDetailView extends StatelessWidget {
  const HomeDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDetailCubit, HomeDetailState>(
      builder: (context, state) {
        return blocBuilderWrapper(
          blocState: state.blocState,
          finishedBuilder: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Html(
                  data: state.content?.data?.current?.content ?? "",
                ),
                ElevatedButton(onPressed: ()=>context.router.pop(), child: Text("Search Flight")),
                kVerticalSpacer,
              ],
            ),
          ),
        );
      },
    );
  }
}
