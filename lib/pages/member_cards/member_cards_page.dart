import 'package:app/pages/member_cards/ui/member_cards_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../theme/spacer.dart';
import '../../theme/styles.dart';
import '../../theme/typography.dart';
import '../../widgets/app_app_bar.dart';
import '../../widgets/app_loading_screen.dart';

class MemberCardsPage extends StatelessWidget {
  const MemberCardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const AppLoadingScreen(message: 'Loading'),
      child: Scaffold(
        appBar: AppAppBar(
          centerTitle: true,
          title: 'My Payment Cards',
          height: 100.h,
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

