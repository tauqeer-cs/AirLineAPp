import 'package:app/app.dart';
import 'package:app/app/app_router.dart';
import 'package:app/pages/new_travel_date/ui/new_travel_date_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../widgets/app_app_bar.dart';
import '../select_change_flight/select_change_flight_page.dart';

class NewTravelDatesPage extends StatelessWidget {
  const NewTravelDatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        centerTitle: true,
        title: 'Change Flight',
        height: 80.h,
        overrideInnerHeight: true,
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<ManageBookingCubit, ManageBookingState>(
          listener: (context, state) {

            if(state.flightSearchResponse != null) {

              print(context.router.current.name);

              var cc = context.router.current;

              context.router.push( const SelectChangeFlightRoute());

            }
          },
          builder: (context, state) {
            return const SelectNewTravelDatesView();
          },
        ),
      ),
    );
  }
}
