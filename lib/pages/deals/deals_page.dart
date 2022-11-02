import 'package:app/pages/bookings/bloc/bookings_cubit.dart';
import 'package:app/pages/bookings/ui/bookings_view.dart';
import 'package:app/pages/check_in/bloc/check_in_cubit.dart';
import 'package:app/pages/check_in/ui/check_in_view.dart';
import 'package:app/pages/deals/bloc/deals_cubit.dart';
import 'package:app/pages/deals/ui/deals_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DealsPage extends StatelessWidget {
  const DealsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DealsCubit(),
      child: DealsView(),
    );
  }
}