import 'package:app/pages/friends_family/ui/friend_family_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../app/app_bloc_helper.dart';
import '../../blocs/profile/profile_cubit.dart';
import '../../theme/spacer.dart';
import '../../theme/styles.dart';
import '../../theme/typography.dart';
import '../../widgets/app_app_bar.dart';
import '../../widgets/app_loading_screen.dart';
import '../../widgets/app_toast.dart';
import '../auth/bloc/signup/signup_cubit.dart';

class FriendsFamilyPage extends StatelessWidget {
  const FriendsFamilyPage({Key? key}) : super(key: key);

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
                message: 'User information updated successfully',
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
                  child: const AppLoadingScreen(message: 'Loading'),
                );
              }
              return LoaderOverlay(
                useDefaultLoading: false,
                overlayWidget: const AppLoadingScreen(message: 'Loading'),
                child: Scaffold(
                  appBar: AppAppBar(
                    centerTitle: true,
                    title: 'Personal Info',
                    height: 80.h,
                    overrideInnerHeight: true,
                    child: Column(
                      children: [
                        Text(
                          'Family and Friends',
                          style: kHugeSemiBold.copyWith(
                              color: Styles.kDartTeal),
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
                    child:  const FriendsFamilyView(),
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
