import 'package:app/app/app_bloc_helper.dart';
import 'package:app/pages/auth/bloc/login/login_cubit.dart';
import 'package:app/pages/auth/ui/auth_view.dart';
import 'package:app/pages/auth/ui/profile_view.dart';
import 'package:app/pages/personal_info/ui/personal_info_view.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_toast.dart';
import 'package:app/widgets/wrapper/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../blocs/profile/profile_cubit.dart';
import '../../theme/spacer.dart';
import '../../theme/styles.dart';
import '../../theme/typography.dart';
import '../../widgets/app_app_bar.dart';
import '../../widgets/app_booking_step.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        // TODO: implement listener}
      },
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return LoaderOverlay(
            useDefaultLoading: false,
            overlayWidget: const AppLoadingScreen(message: "Loading"),
            child: Scaffold(
              appBar: AppAppBar(
                centerTitle: true,
                title: "Personal Info",
                height: 100.h,
                overrideInnerHeight: true,
                child: Column(
                  children: [
                    Text(
                      'Personal Info',
                      style: kHugeSemiBold.copyWith(color: Styles.kDartTeal),
                    ),
                    kVerticalSpacerSmall,
                    Text('Your details and contact info.',
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
    );
  }
}
