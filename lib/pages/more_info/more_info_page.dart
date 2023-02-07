import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../theme/styles.dart';
import '../../theme/typography.dart';
import '../../widgets/app_app_bar.dart';
import '../../widgets/app_loading_screen.dart';

class MoreOptionsPage extends StatelessWidget {
  const MoreOptionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                                  fileName: 'myairline-terms-conditions-of-carriage-final',
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
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfViewer(
                                  title: 'Privacy Policy',
                                  fileName: 'myairline_privacy-policy',
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
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PdfViewer(
                                  title: 'Terms of Use',
                                  fileName: 'myairline_term-of-use_final',
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
                        //
                      ],
                    ),
                  ),
                ),
                Spacer(),
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

                SizedBox(height: 52,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
