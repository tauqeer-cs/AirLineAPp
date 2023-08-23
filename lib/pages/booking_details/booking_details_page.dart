import 'package:app/pages/booking_details/ui/booking_details_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/app_router.dart';
import '../../widgets/app_app_bar.dart';

class ManageBookingDetailsPage extends StatelessWidget {
  ManageBookingDetailsPage({Key? key}) : super(key: key);
  ScreenshotController screenshotController = ScreenshotController();

  onShare() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
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
          title: 'manageMyBookings'.tr(),
          height: 60.h,
          overrideInnerHeight: true,

        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ManageBookingDetailsView(
            onSharedTapped: () {
              onShare();
            }, reloadView: () {

              Navigator.pop(context);

              context.router.push(
              ManageBookingDetailsRoute(),
            );

          },
          ),
        ),
      ),
    );
  }
}
