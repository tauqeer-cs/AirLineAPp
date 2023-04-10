import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/pdf_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
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
    final locale = context.locale.toString();
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const AppLoadingScreen(message: 'Updating'),
      child: Scaffold(
        appBar: AppAppBar(
          centerTitle: true,
          title: 'More Options',
          height: 80.h,
          overrideInnerHeight: true,
          child: Column(
            children: [
              Text(
                'More Options',
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
                                  title: 'Conditions of Carriage',
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
                              'Conditions of Carriage',
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
                                builder: (context) => const PdfViewer(
                                  title: 'Privacy Policy',
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
                              'Privacy Policy',
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
                                builder: (context) => const PdfViewer(
                                  title: 'Terms of Use',
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
                              'Terms of Use',
                              style: kLargeMedium.copyWith(
                                color: Styles.kTextColor,
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8, top: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'language'.tr(),
                                  style: kLargeMedium.copyWith(
                                    color: Styles.kTextColor,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      context.loaderOverlay.show();
                                      await context
                                          .setLocale(const Locale('en'));
                                      context.loaderOverlay.hide();
                                      Phoenix.rebirth(context);
                                    },
                                    child: Text(
                                      "EN",
                                      style: TextStyle(
                                          color: locale == "en"
                                              ? Styles.kActiveColor
                                              : Colors.black),
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  GestureDetector(
                                      onTap: () async {
                                        context.loaderOverlay.show();
                                        await context
                                            .setLocale(const Locale('th'));
                                        context.loaderOverlay.hide();
                                        Phoenix.rebirth(context);
                                      },
                                      child: Text(
                                        "TH",
                                        style: TextStyle(
                                            color: locale == "th"
                                                ? Styles.kActiveColor
                                                : Colors.black),
                                      ))
                                ],
                              ),
                            ],
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
                    '© 2022 MYAirline Reg No. 202101001075 (1401373-U).\nAll Rights Reserved',
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
