import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/app_router.dart';
import '../../theme/spacer.dart';
import '../../theme/styles.dart';
import '../../theme/typography.dart';
import '../../widgets/app_app_bar.dart';
import '../select_change_flight/ui/booking_refrence_label.dart';
import 'bloc/check_in_cubit.dart';

class CheckInErrorPage extends StatefulWidget {
  const CheckInErrorPage({Key? key}) : super(key: key);

  @override
  State<CheckInErrorPage> createState() => _CheckInErrorPageState();
}

class _CheckInErrorPageState extends State<CheckInErrorPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var bloc = context.watch<CheckInCubit>();

    var state = context.watch<CheckInCubit>().state;

    return Scaffold(
      appBar: AppAppBar(
        centerTitle: true,
        title: 'checkInDash'.tr(),
        height: 80.h,
        overrideInnerHeight: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: kPageHorizontalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              BookingReferenceLabel(
                refText: state.pnrEntered,
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'checkInError'.tr(),
                  style: kHugeSemiBold.copyWith(color: Styles.kPrimaryColor),
                ),
              ),
              Spacer(),
              AppCard(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('checkInErrorInfo'.tr(), style: kMediumRegular),
                      kVerticalSpacerSmall,
                      RichText(
                        text: TextSpan(
                          style: kMediumRegular.copyWith(
                            color: Styles.kTextColor,
                          ),
                          children: [
                             TextSpan(
                              text: 'ifIssuePersists'.tr(),
                            ),
                            TextSpan(
                              text: 'changeFlightView.changeFlightDesc7'.tr(),
                              style: TextStyle(
                                color: Styles.kPrimaryColor,
                              ),
                            ),
                             TextSpan(
                              text: 'agentAssistance'.tr(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              if (isLoading) ...[
                const Center(child: AppLoading()),
              ] else ...[
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });

                    var flag = await bloc.getBookingInformation(
                        state.lastName ?? '', state.pnrEntered ?? '',
                        bookSelected: null);

                    if (flag == true) {
                      setState(() {
                        isLoading = false;
                      });

                      context.router.replaceAll([
                        const NavigationRoute(),
                        CheckInDetailsRoute(isPast: false),
                      ]);
                    }
                  },
                  child:  Text('retry'.tr()),
                ),
              ],
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
