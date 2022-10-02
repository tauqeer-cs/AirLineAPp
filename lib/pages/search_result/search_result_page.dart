import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/search_result/ui/search_result_view.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingCubit(),
      child: BlocListener<SearchFlightCubit, SearchFlightState>(
        listener: (context, state) {
          context.read<BookingCubit>().emit(BookingState());
        },
        child: Scaffold(
          appBar: AppAppBar(),
          body: SearchResultView(),
        ),
      ),
    );
  }
}
