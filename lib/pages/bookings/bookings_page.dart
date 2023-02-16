import 'package:app/pages/bookings/bloc/bookings_cubit.dart';
import 'package:app/pages/bookings/ui/bookings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/wave_background.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingsCubit(),
      child:  WaveBackground(
        color: Colors.white,
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: BookingsView(),
        ),
      ),
    );
  }
}
