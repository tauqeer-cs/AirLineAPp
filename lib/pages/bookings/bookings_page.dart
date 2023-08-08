import 'package:app/pages/bookings/ui/bookings_view.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/app_router.dart';
import '../../blocs/manage_booking/manage_booking_cubit.dart';
import '../../blocs/voucher/voucher_cubit.dart';
import '../../widgets/app_loading_screen.dart';
import '../../widgets/wave_background.dart';
import '../../widgets/wrapper/auth_wrapper.dart';
import '../check_in/ui/check_in_view.dart';
import '../check_in/ui/checkin_listing.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({Key? key}) : super(key: key);

  void moveToNext(BuildContext context) {
    context.read<VoucherCubit>().resetState();

    context.router.push(
      ManageBookingDetailsRoute(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ManageBookingCubit? bloc = context.watch<ManageBookingCubit>();

    return WaveBackground(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: AuthWrapper(
            authChild:  bloc.state.isLoadingInfo == true  ? const AppLoading() : CheckingListing(
              isManageBooking: true,
              navigateToCheckInDetails: (bool past,String pnr, String lastName) async {

              /*
              context.router.push(
                CheckInDetailsRoute(isPast: false),
              );*/

                var flag =
                    await bloc.getBookingInformation(lastName, pnr,showError: false);
                if (flag == true) {
                  moveToNext(context);


                }



            }, showErrorMessage: (String error) {
              showErrorDialog(context, error);

            },),
            child: BookingsView(),
          )



        ),
      ),
    );
  }
}
//,