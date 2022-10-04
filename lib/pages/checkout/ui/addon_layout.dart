import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/pages/checkout/ui/add_on_header.dart';
import 'package:app/pages/checkout/ui/checkout_summary.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/pages/search_result/search_result_page.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/styles.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/widgets/app_divider_widget.dart';
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
    final tabs = <Widget>[];
    tabs.add(buildTabTitle(booking.selectedDeparture, "Departure", false));
    if (booking.selectedReturn != null) {
      tabs.add(buildTabTitle(booking.selectedReturn, "Return", true));
    }
    return Padding(
      padding: kPageHorizontalPadding,
      child: DefaultTabController(
        length: type == FlightType.round ? 2 : 1,
        child: NestedScrollView(
          scrollDirection: Axis.vertical,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              //headerSilverBuilder only accepts slivers
              child: Column(
                children: [
                  kVerticalSpacer,
                  AddonHeader(),
                  kVerticalSpacer,
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey)),
                    child: TabBar(
                      tabs: tabs,
                      isScrollable: true,
                      indicatorColor: Styles.kPrimaryColor,
                      indicator: BoxDecoration(
                        color: Styles.kPrimaryColor,
                      ),
                      labelColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: child,
          ),

        ),
      ),
    );
  }

  Widget buildTabTitle(
      InboundOutboundSegment? segment, String prefix, bool showDivider) {
    return Transform.translate(
      offset: Offset(showDivider ? -25 : 0, 0),
      child: Row(
        children: [
          Visibility(
            visible: showDivider,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.arrow_right_alt_sharp,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ),
          Tab(
            text:
                "$prefix - ${AppDateUtils.formatFullDate(segment?.departureDate)}",
          ),
        ],
      ),
    );
  }
}
