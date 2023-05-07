
import 'package:app/pages/new_travel_date/ui/new_travel_date_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../widgets/app_app_bar.dart';

class NewTravelDatesPage extends StatelessWidget {
  const NewTravelDatesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        centerTitle: true,
        title: 'changeFlightView.changeFlight'.tr(),
        height: 60.h,
        overrideInnerHeight: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<ManageBookingCubit, ManageBookingState>(
          listener: (context, state) async {


          },
          builder: (context, state) {
            return const SelectNewTravelDatesView();
          },
        ),
      ),
    );
  }
}
