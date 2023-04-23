import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/utils/security_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../widgets/app_loading_screen.dart';
import '../widgets/pdf_viewer.dart';

showBottomDialog(context, Widget widget) {
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
    builder: (dialogContext) => LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: SizedBox(
        height: 0.5.sh,
        child: AppLoadingScreen(message: "loading".tr()),
      ),
      child: widget,
    ),
  );
}

TextSpan makeClickableTextSpan(context,
    {required String text,
    String? pdfName,
    String? webViewLink,
    VoidCallback? callBackAction,
    bool makeNormalTextBol = false,
    bool pdfIsLink = false}) {
  return TextSpan(
    recognizer: TapGestureRecognizer()
      ..onTap = () {
        if (pdfName != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PdfViewer(
                title: text,
                fileName: pdfName,
                pdfIsLink: pdfIsLink,
              ),
            ),
          );
        } else if (webViewLink != null) {
          SecurityUtils.tryLaunch(webViewLink);
        } else if (callBackAction != null) {
          callBackAction.call();
        }
      },
    text: text,
    style: kMediumHeavy.copyWith(
        color: Styles.kBlueColor,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.w700),
  );
}
