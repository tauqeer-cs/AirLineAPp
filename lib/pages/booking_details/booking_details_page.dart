import 'package:app/pages/booking_details/ui/booking_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../widgets/app_app_bar.dart';

class ManageBookingDetailsPage extends StatelessWidget {
   ManageBookingDetailsPage({Key? key}) : super(key: key);
  ScreenshotController screenshotController = ScreenshotController();

  onShare() async {

    final directory = (await getApplicationDocumentsDirectory())
        .path;
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
          title: 'Manage Booking',
          height: 80.h,
          overrideInnerHeight: true,
        ),
        body:  Padding(
          padding: const EdgeInsets.all(16.0),
          child: ManageBookingDetailsView(onSharedTapped: () {

            onShare();

          },),
        ),
      ),
    );

  }
}
