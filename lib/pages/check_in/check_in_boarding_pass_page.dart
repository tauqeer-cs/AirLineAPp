 import 'package:app/pages/check_in/ui/boarding_pass_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/app_app_bar.dart';


class CheckInBoardingPassPage extends StatelessWidget {
  const CheckInBoardingPassPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppAppBar(
        centerTitle: true,
        title: 'checkInDash'.tr(),
        height: 80.h,
        overrideInnerHeight: true,
      ),
      body: const BoardingPassView(),
    );
  }
}
