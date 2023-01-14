import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../widgets/app_loading_screen.dart';

showBottomDialog(context,Widget widget) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: const Color.fromRGBO(235, 235, 235, 0.85),
    constraints: BoxConstraints(
      maxWidth: 0.9.sw,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    builder: (dialogContext) =>
        LoaderOverlay(
          useDefaultLoading: false,
          overlayWidget: SizedBox(
            height: 0.5.sh,
            child: const AppLoadingScreen(message: "Loading"),
          ),
          child: widget,
        ),
  );
}