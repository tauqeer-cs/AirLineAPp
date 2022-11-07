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
      child: const DealsView(),
    );
  }
}
