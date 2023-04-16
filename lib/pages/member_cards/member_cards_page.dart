import 'package:app/pages/member_cards/ui/member_cards_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../widgets/app_app_bar.dart';
import '../../widgets/app_loading_screen.dart';

class MemberCardsPage extends StatelessWidget {
  const MemberCardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget:  AppLoadingScreen(message: 'loading'.tr()),
      child: Scaffold(
        appBar: AppAppBar(
          centerTitle: true,
          title: 'personalInfo.paymentCards'.tr(),
          height: 60.h,
          overrideInnerHeight: true,
        ),
        body: Container(
          color: Colors.white,
          child:   const MemberCardViw(),
        ),
      ),
    );
  }
}

