import 'package:app/app/app_bloc_helper.dart';
import 'package:app/pages/auth/bloc/login/login_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/containers/version_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/app_router.dart';
import '../../../blocs/profile/profile_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return blocBuilderWrapper(
            blocState: state.blocState,
            finishedBuilder: Container(
              color: Colors.white,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/images/design/gridBackground.png'),
                  fit: BoxFit.fill,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40.h,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          context.read<LoginCubit>().logout();
                          context.read<ProfileCubit>().resetState();
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/icons/iconLogout.png',
                              width: 50.w,
                              height: 50.w,
                            ),
                            Text(
                              "Logout",
                              style: kMediumRegular.copyWith(
                                  color: Styles.kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              "Welcome back, ",
                              style: kHugeRegular.copyWith(
                                  color: Styles.kPrimaryColor),
                            ),
                            Text(
                              "${state.profile?.userProfile?.firstName}",
                              style: kHugeHeavy.copyWith(
                                  color: Styles.kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.6,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40)),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Let’s manage your account",
                                style: kLargeRegular.copyWith(
                                    color: Styles.kSubTextColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Expanded(
                            child: GridView(
                              padding: kPagePadding,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                childAspectRatio: 3.7 / 2.462,
                              ),
                              children: [
                                ProfileBoxButton(
                                  text: 'Personal Info',
                                  imageName: 'iconInfo',
                                  onTap: () {
                                    context.router
                                        .push(const PersonalInfoRoute());
                                  },
                                ),
                                ProfileBoxButton(
                                  text: 'Account Settings',
                                  imageName: 'iconSetting',
                                  onTap: () {
                                    context.router
                                        .push(const AccountSettingRoute());
                                  },
                                ),
                                ProfileBoxButton(
                                  text: 'Communication\nPreferences',
                                  imageName: 'iconPref',
                                  onTap: () {
                                    context.router.push(
                                        const CommunicationSettingRoute());
                                  },
                                ),
                                /* ProfileBoxButton(
                                text: 'My Payment Cards',
                                imageName: 'iconPayment',
                                onTap: () {
                                  print('Not required at this time');
                                },
                              ),
                              ProfileBoxButton(
                                text: 'Family and Friends',
                                imageName: 'iconFamily',
                                onTap: () {
                                  print('Not required at this time');
                                },
                              ),*/
                              ],
                            ),
                          ),
                          kVerticalSpacer,
                          VersionWidget(
                            textColor: Styles.kSubTextColor,
                          ),
                          kVerticalSpacer,
                          /*Row(
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            ProfileBoxButton(
                              text: 'Personal Info',
                              imageName: 'iconInfo',
                              onTap: () {
                                context.router.push(const PersonalInfoRoute());
                              },
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            ProfileBoxButton(
                              text: 'Account Settings',
                              imageName: 'iconSetting',
                              onTap: () {},
                            ),
                            */ /*ProfileBoxButton(
                              text: 'My Payment Cards',
                              imageName: 'iconPayment',
                              onTap: () {
                                print('Not required at this time');
                              },
                            ),*/ /*
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            ProfileBoxButton(
                              text: 'Communication\nPreferences',
                              imageName: 'iconPref',
                              onTap: () {},
                            ),
                            */ /*ProfileBoxButton(
                              text: 'Family and Friends',
                              imageName: 'iconFamily',
                              onTap: () {
                                print('Not required at this time');
                              },
                            ),*/ /*
                            Expanded(
                              child: Container(),
                            ),
                            */ /*ProfileBoxButton(
                              text: 'Account Settings',
                              imageName: 'iconSetting',
                              onTap: () {},
                            ),*/ /*
                            */ /*Expanded(
                              child: Container(),
                            ),*/ /*
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            ProfileBoxButton(
                              text: 'Communication\nPreferences',
                              imageName: 'iconPref',
                              onTap: () {},
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.462,
                              height: MediaQuery.of(context).size.width / 3.7,
                            ),
                            Expanded(
                              child: Container(),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Spacer(),
                        const Spacer(),
                        const Spacer(),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfileBoxButton extends StatelessWidget {
  final String text;
  final String imageName;
  final VoidCallback onTap;

  const ProfileBoxButton({
    Key? key,
    required this.text,
    required this.imageName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width / 2.462,
        height: MediaQuery.of(context).size.width / 3.7,
        child: Column(
          children: [
            Expanded(
              flex: 52,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/images/icons/$imageName.png',
                  width: MediaQuery.of(context).size.width / 11,
                  height: MediaQuery.of(context).size.width / 11,
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Container(),
            ),
            Expanded(
              flex: 38,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: kMediumRegular.copyWith(color: Styles.kTextColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
