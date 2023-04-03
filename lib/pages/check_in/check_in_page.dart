import 'package:app/pages/check_in/ui/checkin_listing.dart';
import 'package:auto_route/auto_route.dart';

import '../../app/app_router.dart';
import '../../widgets/wave_background.dart';
import 'package:app/pages/check_in/bloc/check_in_cubit.dart';
import 'package:app/pages/check_in/ui/check_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/wrapper/auth_wrapper.dart';

class CheckInPage extends StatelessWidget {
  const CheckInPage({Key? key}) : super(key: key);

  void moveToNext(BuildContext context) {

    context.router.push(
      const CheckInDetailsRoute(),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                child: AuthWrapper(
                  authChild:  CheckingListing(moveOn: () {

                    moveToNext(context);
                    
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
