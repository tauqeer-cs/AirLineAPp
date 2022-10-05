import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBookingHeader extends StatefulWidget {
  final List<BookingStep> passedSteps;

  AppBookingHeader({Key? key, required this.passedSteps}) : super(key: key);

  @override
  State<AppBookingHeader> createState() => _AppBookingHeaderState();
}

class _AppBookingHeaderState extends State<AppBookingHeader> {
  final ScrollController _controller = ScrollController();

  void _animateToIndex(int index) {
    _controller.jumpTo(index * 150.w);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animateToIndex(widget.passedSteps.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SearchFlightCubit>().state.filterState;
    return Column(
      children: [
        kVerticalSpacer,
        Text(
          "Your trip starts here",
          style: kHugeSemiBold.copyWith(color: Styles.kPrimaryColor),
        ),
        kVerticalSpacer,
        Container(
          clipBehavior: Clip.hardEdge,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          child: ListView(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            children: BookingStep.values.mapIndexed((index, e) {
              final selected = widget.passedSteps.contains(e);
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                constraints: BoxConstraints(
                  minWidth: 150.w,
                ),
                decoration: BoxDecoration(
                    color: selected ? Styles.kPrimaryColor : null,
                    borderRadius: BorderRadius.horizontal(
                        right: widget.passedSteps.length - 1 > index
                            ? Radius.circular(0)
                            : Radius.circular(12))),
                child: Center(
                    child: Text(
                  e.message,
                  style: kHugeSemiBold.copyWith(color: Colors.white),
                )),
              );
            }).toList(),
          ),
        ),
        kVerticalSpacer,
      ],
    );
  }
}

enum BookingStep {
  flights("Flights"),
  addOn("Add-On"),
  bookingDetails("Booking Details"),
  payment("Payment");

  const BookingStep(this.message);

  final String message;
}
