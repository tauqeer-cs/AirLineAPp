import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/pdf_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../blocs/cms/agent_sign_up/agent_sign_up_cubit.dart';
import '../../theme/styles.dart';
import '../../theme/typography.dart';
import '../../widgets/app_app_bar.dart';
import '../../widgets/app_loading_screen.dart';

class MoreOptionsPage extends StatelessWidget {
  const MoreOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final agentCms = context.watch<AgentSignUpCubit>().state.agentCms;
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: AppLoadingScreen(message: 'updating'.tr()),
      child: Scaffold(
        appBar: AppAppBar(
          centerTitle: true,
          title: 'moreInfo'.tr(),
          height: 60.h,
          overrideInnerHeight: true,
          child: Column(
            children: [
              Text(
                'moreInfo'.tr(),
                style: kHugeSemiBold.copyWith(
                  color: Styles.kDartTeal,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                AppCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfViewer(
                                  title: 'conditionsOfCarriage'.tr(),
                                  fileName: agentCms?.tnC ??
                                      'https://myacontents.blob.core.windows.net/myacontents/v40h1xe5/myairline-terms-conditions-of-carriage-final.pdf',
                                  pdfIsLink: true,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              'conditionsOfCarriage'.tr(),
                              style: kLargeMedium.copyWith(
                                color: Styles.kTextColor,
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfViewer(
                                  title: 'privacyPolicy'.tr(),
                                  fileName:
                                      'https://mya-ibe-prod-bucket.s3.ap-southeast-1.amazonaws.com/odxgmbdo/myairline_privacy-policy.pdf',
                                  pdfIsLink: true,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8, top: 16),
                            child: Text(
                              'privacyPolicy'.tr(),
                              style: kLargeMedium.copyWith(
                                color: Styles.kTextColor,
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfViewer(
                                  title: 'termsOfUse'.tr(),
                                  fileName:
                                      'https://mya-ibe-prod-bucket.s3.ap-southeast-1.amazonaws.com/kbyjsapq/myairline_term-of-use_final.pdf',
                                  pdfIsLink: true,
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8, top: 16),
                            child: Text(
                              'termsOfUse'.tr(),
                              style: kLargeMedium.copyWith(
                                color: Styles.kTextColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "app.copyright".tr(
                        namedArgs: {'year': DateTime.now().year.toString()}),
                    style: kTinyRegular.copyWith(
                      color: Styles.kTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 52),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
