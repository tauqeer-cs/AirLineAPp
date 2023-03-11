import 'package:app/pages/change_flight_confirmation/ui/change_flight_confirmation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../widgets/app_app_bar.dart';

class ChangeFlightConfirmationPage extends StatelessWidget {
  final String bookingId;

  ScreenshotController screenshotController = ScreenshotController();

  ChangeFlightConfirmationPage({Key? key, required this.bookingId})
      : super(key: key);

  onShare() async {
    final directory = (await getApplicationDocumentsDirectory())
        .path; //from path_provide package
    String fileName = "${DateTime.now().microsecondsSinceEpoch.toString()}.jpg";
    await screenshotController.captureAndSave(directory, fileName: fileName);

    Share.shareXFiles([XFile('$directory/$fileName')]);
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        appBar: AppAppBar(
          centerTitle: true,
          title: 'Change Flight Confirmation',
          height: 60.h,
          overrideInnerHeight: true,
        ),
        body: BlocConsumer<ManageBookingCubit, ManageBookingState>(
          listener: (context, state) {},
          builder: (context, state) {
            return  ChangeFlightConfirmationView(onShare: () {

              onShare();

            },);
          },
        ),
      ),
    );
  }
}
