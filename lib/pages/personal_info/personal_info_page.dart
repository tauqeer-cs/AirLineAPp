import 'package:app/app/app_bloc_helper.dart';
import 'package:app/pages/auth/bloc/signup/signup_cubit.dart';
import 'package:app/pages/personal_info/ui/personal_info_view.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../blocs/profile/profile_cubit.dart';
import '../../theme/spacer.dart';
import '../../theme/styles.dart';
import '../../theme/typography.dart';
import '../../widgets/app_app_bar.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BlocListener<ProfileCubit, ProfileState>(
          listener: (context, state) async {
            if (state.blocState == BlocState.finished) {
              Toast.of(context).show(
                success: true,
                message: 'personalInfo.infoUpdated'.tr(),
              );
              await Future.delayed(const Duration(seconds: 1), () {
                context.router.pop();
              });
            }
          },
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state.blocState == BlocState.loading) {
                return Container(
                  color: Colors.white,
                  child: AppLoadingScreen(message: 'topForm.loading'.tr()),
                );
              }
              return LoaderOverlay(
                useDefaultLoading: false,
                overlayWidget:  AppLoadingScreen(message: 'topForm.loading'.tr()),
                child: Scaffold(
                  appBar: AppAppBar(
                    centerTitle: true,
                    title: 'personalInfo.personalInfoTitle'.tr(),
                    height: 80.h,
                    overrideInnerHeight: true,
                    child: Column(
                      children: [
                        Text(
                          'personalInfo.personalInfoTitle'.tr(),
                          style: kHugeSemiBold.copyWith(
                              color: Styles.kDartTeal),
                        ),
                        kVerticalSpacerSmall,
                        Text('infoDetail.details'.tr(),
                            style: kLargeRegular.copyWith(
                                color: Styles.kSubTextColor)),
                      ],
                    ),
                  ),
                  body: Container(
                    color: Colors.white,
                    child: const PersonalInfoView(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
