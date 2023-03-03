import 'package:app/pages/change_flight_summary/ui/change_flight_summary_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../widgets/app_app_bar.dart';

class ChangeFlightSummaryPage extends StatelessWidget {
  const ChangeFlightSummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        centerTitle: true,
        title: 'Change Flight',
        height: 60.h,
        overrideInnerHeight: true,
      ),
      body: BlocConsumer<ManageBookingCubit, ManageBookingState>(
        listener: (context, state) {},
        builder: (context, state) {
          return  ChangeFlightSummaryView();
        },
      ),
    );
  }
}
