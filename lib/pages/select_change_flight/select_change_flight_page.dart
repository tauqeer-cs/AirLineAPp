import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../widgets/app_app_bar.dart';

class SelectChangeFlightPage extends StatelessWidget {
  const SelectChangeFlightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        centerTitle: true,
        title: 'Change Flight',
        height: 80.h,
        overrideInnerHeight: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<ManageBookingCubit, ManageBookingState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Container();
          },
        ),
      ),
    );
  }
}
