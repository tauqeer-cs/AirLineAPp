import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/search_result/bloc/summary_container_cubit.dart';
import 'package:app/pages/search_result/ui/booking_summary.dart';
import 'package:app/pages/search_result/ui/flight_result_widget.dart';
import 'package:app/pages/search_result/ui/summary_container_listener.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/error_utils.dart';
import 'package:app/widgets/animations/booking_loader.dart';
import 'package:app/widgets/app_error_widget.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultView extends StatelessWidget {
  final scrollController = ScrollController();

  SearchResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchFlightCubit, SearchFlightState>(
      builder: (context, state) {
        return blocBuilderWrapper(
          blocState: state.blocState,
          finishedBuilder: Stack(
            children: [
              SummaryContainerListener(
                scrollController: scrollController,
                child: ListView(
                  controller: scrollController,
                  children: [
                    kVerticalSpacer,
                    const FlightResultWidget(),
                    Stack(
                      children: [
                        const SizedBox(height: 80),
                        const CheckoutSummary(),
                        Positioned(
                          bottom: 0,
                          right: 15,
                          child: FloatingActionButton(
                            onPressed: () {
                              scrollController.animateTo(
                                scrollController.position.minScrollExtent,
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn,
                              );
                            },
                            backgroundColor: Styles.kPrimaryColor,
                            child: const Icon(Icons.keyboard_arrow_up),
                          ),
                        )
                      ],
                    ),
                    kSummaryContainerSpacing,
                    kSummaryContainerSpacing,
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: SummaryContainer(
                  child: Padding(
                    padding: kPagePadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        BookingSummary(),
                        ContinueButton(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          loadingBuilder: ListView(
            padding: kPagePadding,
            children: const [BookingLoader()],
          ),
          failedBuilder: AppErrorWidget(
            title: ErrorUtils.generateErrorText(state.message),
            subtitle: ErrorUtils.generateSubError(state.message),
          ),
        );
      },
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingCubit>().state;
    final filterState = context.watch<SearchFlightCubit>().state.filterState;
    final filter = context.watch<FilterCubit>().state;

    final isAllowedContinue = booking.selectedDeparture != null &&
        (booking.selectedReturn != null ||
            filterState?.flightType == FlightType.oneWay);

    return ElevatedButton(
      onPressed: isAllowedContinue
          ? () {
              if (booking.blocState == BlocState.loading) return;
              context.read<BookingCubit>().verifyFlight(filterState);
              context.read<SearchFlightCubit>().resetFilterState(filter);
              context.router.push(SeatsRoute());
              print("go here");
              // if (booking.isVerify) {
              //   context.read<SummaryContainerCubit>().changeVisibility(true);
              //   context.router.push(SeatsRoute());
              // } else {
              //   context.read<BookingCubit>().verifyFlight(filterState);
              //   context.router.push(SearchResultRoute(showLoginDialog: false));
              // }
            }
          : null,
      child: booking.blocState == BlocState.loading
          ? const AppLoading(color: Colors.white)
          : const Text("Continue"),
    );
  }
}
