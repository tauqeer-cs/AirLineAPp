import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/cms/ssr/cms_ssr_cubit.dart';
import 'package:app/widgets/app_logo_widget.dart';
import 'package:app/widgets/containers/glass_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/theme.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool canBack;
  final Widget? child;

  const AppAppBar({
    Key? key,
    this.child,
    this.title,
    this.canBack = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final bool canPop = parentRoute?.canPop ?? false;
    final notifications = context.watch<CmsSsrCubit>().state.notifications;
    return PreferredSize(
      preferredSize: Size.fromHeight(120.h),
      child: AppBar(
        toolbarHeight: 60.h,
        centerTitle: false,
        leading: canPop
            ? GestureDetector(
                onTap: () => context.router.pop(),
                child: const Icon(
                  Icons.chevron_left,
                  size: 35,
                ),
              )
            : null,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
        ],
        flexibleSpace: BlocBuilder<CmsSsrCubit, CmsSsrState>(
          builder: (context, state) {
            final notification = state.notifications?.firstOrNull;
            return blocBuilderWrapper(
              blocState: state.blocState,
              finishedBuilder: notification == null
                  ? SizedBox()
                  : Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 75.h,
                        width: 500.w,
                        padding: const EdgeInsets.all(12.0),
                        child: GlassCard(
                          color: Colors.yellowAccent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(notification.content ?? ""),
                            ],
                          ),
                        ),
                      ),
                    ),
            );
          },
        ),
        title: Container(
          padding: EdgeInsets.only(left: canPop ? 0 : 20.0, right: 20),
          child: child ??
              (title == null
                  ? AppLogoWidget(
                      height: 50.h,
                      width: 120.w,
                    )
                  : Text(title!, style: kGiantMedium)),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120.h);
}
