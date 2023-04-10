import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';

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

  const CheckingListing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CheckInCubit? bloc = context.watch<CheckInCubit>();
    if (bloc.state.listToCall == false) {
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
                  "My Booking",
                  style: kGiantHeavy.copyWith(color: Styles.kTextColor),
                ),
              ),
              kVerticalSpacerSmall,
              CustomSegmentControl(
                statusChange: (bool showUpcoming) {
                  bloc.showUpcoming(showUpcoming);
                },
              ),
              kVerticalSpacerSmall,
              if (bloc.state.showUpcoming == false) ...[
                if (bloc.state.isLoadingInfo == false &&
                    bloc.state.pastBookings?.isEmpty == true) ...[
                  buildNoDataView(context, bloc,true),
                ] else ...[
                  Expanded(
                    child: bloc.state.isLoadingInfo == true
                        ? const Center(
                            child: Padding(
                            padding: EdgeInsets.only(bottom: 24),
                            child: AppLoading(),
                          ))
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              if (bloc.state.loadingListDetailItem == true &&
                                  bloc.state.bookingSelected?.pnr ==
                                      bloc.state.pastBookings?[index].pnr) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 24),
                                  child: AppLoading(),
                                );
                              }

                              return FlightListItem(
                                dateToShow: bloc.state.pastBookings?[index]
                                        .pastDateToShow ??
                                    '',
                                flightCode:
                                    bloc.state.pastBookings?[index].pnr ?? '',
                                departureLocation: bloc
                                        .state
                                        .pastBookings?[index]
                                        .pastDepartureLocation ??
                                    '',
                                btnView: true,
                                destinationLocation: bloc
                                        .state
                                        .pastBookings?[index]
                                        .pastReturnLocation ??
                                    '',
                                onCheckTapped: () async {
                                  if (bloc.state.loadingListDetailItem ==
                                      true) {
                                    return;
                                  }
                                  var flag = await bloc.getBookingInformation(
                                      '', '',
                                      bookSelected:
                                          bloc.state.pastBookings?[index]);

                                  if (flag == true) {

                                    context.router.push(
                                       CheckInDetailsRoute(isPast: true),
                                    );
                                  }
                                },
                              );
                            },
                            itemCount: (bloc.state.pastBookings ?? []).length,
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 8.h,
                              );
                            },
                          ),
                  ),
                ],
              ] else ...[
                Text(
                  'Online check-in opens 72 hours before departure.',
                  style: kMediumRegular.copyWith(color: Styles.kTextColor),
                ),
                kVerticalSpacer,

                if (bloc.state.isLoadingInfo == false &&
                    bloc.state.upcomingBookings?.isEmpty == true) ...[
                  buildNoDataView(context, bloc,false),
                ] else ... [
                  Expanded(
                    child: bloc.state.isLoadingInfo == true
                        ? const Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 24),
                          child: AppLoading(),
                        ))
                        : ListView.separated(
                      itemBuilder: (context, index) {
                        if (bloc.state.loadingListDetailItem == true &&
                            bloc.state.bookingSelected?.pnr ==
                                bloc.state.upcomingBookings?[index].pnr) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24),
                            child: AppLoading(),
                          );
                        }

                        return FlightListItem(
                          dateToShow: bloc.state.upcomingBookings?[index]
                              .dateToShow ??
                              '',
                          btnView: bloc.state.upcomingBookings?[index]
                              .isFullyCheckedIn ==
                              true,
                          flightCode:
                          bloc.state.upcomingBookings?[index].pnr ?? '',
                          departureLocation: bloc
                              .state
                              .upcomingBookings?[index]
                              .departureLocation ??
                              '',
                          destinationLocation: bloc
                              .state
                              .upcomingBookings?[index]
                              .returnLocation ??
                              '',
                          onCheckTapped: bloc.state.upcomingBookings?[index]
                              .allowCheckIn ==
                              false
                              ? null
                              : () async {
                            if (bloc.state.loadingListDetailItem ==
                                true) {
                              return;
                            }
                            var flag = await bloc
                                .getBookingInformation('', '',
                                bookSelected: bloc.state
                                    .upcomingBookings?[index]);

                            if (flag == true) {

                              context.router.push(
                                CheckInDetailsRoute(isPast: false),
                              );
                              // moveToNext(context);
                            }
                          },
                        );
                      },
                      itemCount: (bloc.state.upcomingBookings ?? []).length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 8.h,
                        );
                      },
                    ),
                  ),
                ],


              ],
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildNoDataView(
      BuildContext context, CheckInCubit bloc, bool isPast) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: Center(
          child: Column(
            children: [
              Expanded(child: Container()),
              if (isPast) ...[
                const Text('No Past booking found'),
              ] else ...[
                const Text('No upcoming booking found'),
              ],
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: ElevatedButton(
                  onPressed: () {
                    bloc.getBookingsListing();
                  },
                  child: const Text('Reload'),
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSegmentControl extends StatefulWidget {
  final Function(bool) statusChange;

  const CustomSegmentControl({super.key, required this.statusChange});

  @override
  _CustomSegmentControlState createState() => _CustomSegmentControlState();
}

class _CustomSegmentControlState extends State<CustomSegmentControl> {
  bool _isSelectedOption1 = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final optionWidth = (width - 4) / 2; // 4 = 2 * border width

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Styles.kPrimaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSelectedOption1 = true;
                });
                widget.statusChange(_isSelectedOption1);
              },
              child: Container(
                width: optionWidth,
                decoration: BoxDecoration(
                  color:
                      _isSelectedOption1 ? Styles.kPrimaryColor : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Center(
                  child: Text(
                    'Upcoming Bookings',
                    style: kSmallSemiBold.copyWith(
                        color: _isSelectedOption1
                            ? Colors.white
                            : Styles.kPrimaryColor),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSelectedOption1 = false;
                });

                widget.statusChange(_isSelectedOption1);
              },
              child: Container(
                width: optionWidth,
                decoration: BoxDecoration(
                  color:
                      !_isSelectedOption1 ? Styles.kPrimaryColor : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Center(
                  child: Text(
                    'Past Bookings',
                    style: kSmallSemiBold.copyWith(
                        color: !_isSelectedOption1
                            ? Colors.white
                            : Styles.kPrimaryColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
