import 'package:app/app/app_router.dart';
import 'package:app/pages/home/bloc/price_range/price_range_cubit.dart';
import 'package:app/pages/home/ui/home_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    //FCMNotification.of(context).initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     context.router.push(
      //         BookingConfirmationRoute(
      //           bookingId: "8HUHEE7" ?? "",)
      //     );
      //   },
      // ),
      body: BlocProvider(
        create: (context) => PriceRangeCubit(),
        child: const HomeView(),
      ),
    );
  }
}
