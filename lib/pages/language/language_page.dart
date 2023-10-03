import 'package:app/theme/styles.dart';
import 'package:app/theme/typography.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/forms/app_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../blocs/routes/routes_cubit.dart';
import '../home/bloc/home/home_cubit.dart';

List<String> supportedLang = ["English", "Thai"];//,'Bahasa Indonesia'

class LanguagePage extends StatelessWidget {
  const LanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.toString();
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
                'language'.tr(),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'language'.tr(),
                  style: kLargeHeavy.copyWith(
                    color: Styles.kTextColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'selectYourLanguage'.tr(),
                  style: kMediumRegular.copyWith(
                    color: Styles.kTextColor,
                  ),
                ),
                const SizedBox(height: 6),
                AppDropDown<String>(
                  items: supportedLang,
                  defaultValue: defaultValue(locale),
                  sheetTitle: 'language'.tr(),
                  onChanged: (value) async {
                    if (value == "English") {
                      setLocale(context, 'en');
                      context.read<RoutesCubit>().getRoutes();

                    } else if(value == 'Thai') {

                      setLocale(context, 'th');
                      context.read<RoutesCubit>().getRoutes();

                    }
                    else {
                      setLocale(context, 'in');
                      context.read<RoutesCubit>().getRoutes();

                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String defaultValue(String locale) {
    if(locale == 'id'){
      return 'Bahasa Indonesia';
    }
  return  locale == "en" ? "English" : "Thai";
  }

  void setLocale(BuildContext context, String langCode) async {
    context.loaderOverlay.show();
    await context.setLocale(Locale(langCode));
    context.loaderOverlay.hide();
    Phoenix.rebirth(context);
  }
}
