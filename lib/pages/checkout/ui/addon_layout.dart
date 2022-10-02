import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/search_result/search_result_page.dart';
import 'package:app/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddonLayout extends StatelessWidget {
  final List<Widget> child;
  const AddonLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final type =
        context.watch<SearchFlightCubit>().state.filterState?.flightType;
    final booking = context.watch<BookingCubit>().state;
    final tabs = <Tab>[];
    tabs.add(buildTabTitle(booking.selectedDeparture, "Departure"));
    if (booking.selectedReturn != null) {
      tabs.add(buildTabTitle(booking.selectedReturn, "Return"));
    }
    return DefaultTabController(
      length: type == FlightType.round ? 2 : 1,
      child: NestedScrollView(
        scrollDirection: Axis.vertical,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            //headerSilverBuilder only accepts slivers
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Text('My Top Widget'),
                // ),
                TabBar(tabs: tabs, isScrollable: true,),
              ],
            ),
          ),
        ],
        body: TabBarView(
          children: child,
        ),
      ),
    );
  }

  Tab buildTabTitle(InboundOutboundSegment? segment, String prefix) {
    return Tab(
      text: "$prefix - ${AppDateUtils.formatFullDate(segment?.departureDate)}",
    );
  }
}
