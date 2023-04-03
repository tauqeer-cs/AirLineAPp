import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/app_router.dart';
import '../../../theme/spacer.dart';
import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_loading_screen.dart';
import '../bloc/check_in_cubit.dart';
import 'check_in_view.dart';
import 'flight_list_item.dart';

class CheckingListing extends StatelessWidget {

  final VoidCallback moveOn;


  const CheckingListing({Key? key, required this.moveOn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CheckInCubit? bloc = context.watch<CheckInCubit>();
    if(bloc.state.listToCall == false){
      bloc.getBookingsListing();
    }
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kVerticalSpacer,
              kVerticalSpacer,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0.w),
                child: Text(
                  "Manage My Booking",
                  style: kGiantHeavy.copyWith(color: Styles.kTextColor),
                ),
              ),
              kVerticalSpacerSmall,

              Text(
                'Online check-in opens 72 hours before departure.',
                style: kMediumRegular.copyWith(color: Styles.kTextColor),
              ),
              kVerticalSpacer,
              Expanded(
                child: bloc.state.isLoadingInfo == true ? const Center(child: Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: AppLoading(),
                )) : Builder(
                  builder: (context) => ListView.separated(
                    itemBuilder: (context, index) {
                      if(bloc.state.loadingListDetailItem == true && bloc.state.bookingSelected?.pnr == bloc.state.upcomingBookings?[index].pnr) {

                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: AppLoading(),
                        );
                      }

                      return FlightListItem(
                        dateToShow: bloc.state.upcomingBookings?[index].dateToShow ?? '',//
                        flightCode: bloc.state.upcomingBookings?[index].pnr ?? '',
                        departureLocation:
                        bloc.state.upcomingBookings?[index].departureLocation ?? '',
                        destinationLocation: bloc.state.upcomingBookings?[index].departureLocation ?? '',
                        onCheckTapped: () async {

                          if(bloc.state.loadingListDetailItem == true){
                            return;

                          }
                          var flag = await bloc.getBookingInformation(
                             '',
                              '',
                            bookSelected: bloc.state.upcomingBookings?[index]
                          );

                          if (flag == true) {
                            moveOn();

                           // moveToNext(context);
                          }
                        },
                      );

                    },
                    itemCount: bloc.state.upcomingBookings!.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 8.h,
                      );
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }



}
