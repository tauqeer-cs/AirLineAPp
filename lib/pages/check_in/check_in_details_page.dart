import 'package:app/pages/check_in/ui/check_in_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/app_app_bar.dart';

class CheckInDetailsPage extends StatelessWidget {
  const CheckInDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppAppBar(
          centerTitle: true,
          title: 'Check-In',
          height: 80.h,
          overrideInnerHeight: true,
        ),
        backgroundColor: Colors.white,
        body: const SafeArea(
          child: CheckInDetailView(),
        ),
      ),
    );
  }
}
