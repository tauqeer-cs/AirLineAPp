import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:app/widgets/app_image_carousel.dart';
import 'package:app/widgets/app_logo_widget.dart';
import 'package:app/widgets/containers/glass_card.dart';
import 'package:app/widgets/wrapper/auth_wrapper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifications =
        context.watch<CmsSsrCubit>().state.notifications ?? [];
    return Scaffold(
      // floatingActionButton: TextButton(
      //   onPressed: () => throw Exception(),
      //   child: const Text("Throw Test Exception"),
      // ),
      endDrawer: Drawer(
        width: 250.w,
        backgroundColor: Styles.kPrimaryColor,
        child: Builder(builder: (context) {
          return SafeArea(
            child: Column(
              children: [
                kVerticalSpacer,
                Image.asset(
                  "assets/images/native/icon.png",
                  width: 80,
                ),
                kVerticalSpacer,
                const AppDividerWidget(color: Colors.white),
                ListTile(
                  title: Text(
                    "Manage Bookings",
                    style: const TextStyle().copyWith(color: Colors.white),
                  ),
                  onTap: () {
                    Scaffold.of(context).closeEndDrawer();
                    context.router.push(const BookingListRoute());
                  },
                ),
                AuthWrapper(
                  authChild: ListTile(
                    title: Text(
                      "Member",
                      style: const TextStyle().copyWith(color: Colors.white),
                    ),
                    onTap: () {
                      Scaffold.of(context).closeEndDrawer();
                      context.router.push(const AuthRoute());
                    },
                  ),
                  child: ListTile(
                    title: Text(
                      "Sign In / Sign Up",
                      style: const TextStyle().copyWith(color: Colors.white),
                    ),
                    onTap: () {
                      Scaffold.of(context).closeEndDrawer();
                      context.router.push(const AuthRoute());
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      appBar: AppAppBar(
        onAction: () => Scaffold.of(context).openEndDrawer(),
        height: notifications.isEmpty ? 60.h : 125.h,
      ),
      body: child,
    );
  }
}

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool canBack, centerTitle;

  final Widget? child;
  final Function()? onAction;
  final double? height;
  final Widget? flexibleWidget;

  final bool overrideInnerHeight;


  const AppAppBar({
    Key? key,
    this.child,
    this.title,
    this.onAction,
    this.centerTitle = false,
    this.canBack = true,
    this.height,
    this.flexibleWidget,
    this.overrideInnerHeight = false,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;
    return PreferredSize(
      preferredSize: Size.fromHeight(height ?? 60.h),
      child: AppBar(
        toolbarHeight: overrideInnerHeight ? (height ?? 60.h) : 60.h,
        centerTitle: centerTitle,
        leading: canPop
            ? overrideInnerHeight ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
          alignment: Alignment.topLeft,
                child: InkWell(
                    onTap: () => context.router.pop(),
                    child: Icon(
                      Icons.chevron_left,
                      size: 35,
                      color: Styles.kPrimaryColor,
                    ),
                  ),
              ),
            ) : InkWell(
          onTap: () => context.router.pop(),
          child: Icon(
            Icons.chevron_left,
            size: 35,
            color: Styles.kPrimaryColor,
          ),
        )
            : null,
        actions: const [
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.menu),
          // ),
        ],
        flexibleSpace: Align(
          alignment: Alignment.bottomLeft,
          child: flexibleWidget,
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
        title: Container(
          padding: EdgeInsets.only(left: canPop ? 0 : 20.0, right: 0),
          child: child ??
              (title == null
                  ? AppLogoWidget(
                      height: 50.h,
                      width: 120.w,
                    )
                  : Text(title!,
                      style: kGiantMedium.copyWith(
                          color: centerTitle ? Styles.kPrimaryColor : null))),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 125.h);
}

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CmsSsrCubit, CmsSsrState>(
      builder: (context, state) {
        final notifications = state.notifications;
        return blocBuilderWrapper(
          blocState: state.blocState,
          finishedBuilder: notifications?.isEmpty ?? true
              ? const SizedBox()
              : Container(
                  padding: const EdgeInsets.all(12.0),
                  width: 500.w,
                  height: 85.h,
                  child: GlassCard(
                    color: Colors.yellowAccent,
                    child: AppImageCarousel(
                      aspectRatio: 500.w / 40.h,
                      items: notifications!
                          .map((e) => Html(
                                data: e.content ?? "",
                              ))
                          .toList(),
                      showIndicator: false,
                      autoPlay: notifications.length > 1,
                      infiniteScroll: true,
                    ),
                  ),
                ),
          loadingBuilder: const SizedBox(),
          failedBuilder: const SizedBox(),
        );
      },
    );
  }
}
