import 'package:app/pages/booking_details/ui/booking_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/app_app_bar.dart';

class ManageBookingDetailsPage extends StatelessWidget {
  const ManageBookingDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        centerTitle: true,
        title: 'Manage Booking',
        height: 80.h,
        overrideInnerHeight: true,

      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: ManageBookingDetailsView(),
      ),
    );
  }
}
