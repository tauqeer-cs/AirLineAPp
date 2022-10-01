import 'package:app/app/app_router.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitSearch extends StatelessWidget {
  final bool isHomePage;

  const SubmitSearch({Key? key, required this.isHomePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<FilterCubit>().state;
    final isValid = filter.isValid;
    return ElevatedButton(
      onPressed: !isValid
          ? null
          : () {
              if (isHomePage) {
                context.router.push(SearchResultRoute());
              }
              context.read<SearchFlightCubit>().searchFlights(filter);
            },
      child: Text("Select Flight"),
    );
  }
}
