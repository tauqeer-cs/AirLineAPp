import 'package:app/blocs/routes/routes_cubit.dart';
import 'package:app/pages/home_detail/bloc/home_detail_cubit.dart';
import 'package:app/pages/home_detail/ui/home_detail_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDetailPage extends StatelessWidget {
  final String url;

  const HomeDetailPage({
    Key? key,
    @PathParam('url') required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final availableRoutes = context.watch<RoutesCubit>().state.routes;
    return BlocProvider(
      create: (context) => HomeDetailCubit()..getContents(url, availableRoutes),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: HomeDetailView(),
      ),
    );
  }
}
