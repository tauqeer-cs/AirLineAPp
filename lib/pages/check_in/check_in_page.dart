import 'package:app/pages/check_in/ui/checkin_listing.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../app/app_router.dart';
import '../../widgets/wave_background.dart';
import 'package:app/pages/check_in/bloc/check_in_cubit.dart';
import 'package:app/pages/check_in/ui/check_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/wrapper/auth_wrapper.dart';
import 'check_in_details_page.dart';

class CheckInPage extends StatelessWidget {
  const CheckInPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final locale = context.locale.toString();
    initializeDateFormatting(locale, null);


    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: WaveBackground(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocConsumer<CheckInCubit, CheckInState>(
            listener: (context, state) {


            },
            builder: (context, state) {
              return SafeArea(
                child: false ? CheckInView() : AuthWrapper(
                  authChild:  CheckingListing(navigateToCheckInDetails: (bool past) {

                    context.router.push(
                      CheckInDetailsRoute(isPast: false),
                    );

                  },),
                  child: CheckInView(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
