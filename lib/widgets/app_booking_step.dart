import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBookingStep extends StatefulWidget {
  final List<BookingStep> passedSteps;

  AppBookingStep({Key? key, required this.passedSteps}) : super(key: key);

  @override
  State<AppBookingStep> createState() => _AppBookingStepState();
}

class _AppBookingStepState extends State<AppBookingStep> {
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
    return Container(
      height: 60,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: BookingStep.values.length,
        separatorBuilder: (context, index) {
          final step = BookingStep.values[index];
          final selected = widget.passedSteps.contains(step);
          return Container(
            width: 20,
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: AppDividerWidget(
              color:
                  selected ? Styles.kPrimaryColor : Styles.kInactiveColor,
            ),
          );
        },
        itemBuilder: (context, index) {
          final step = BookingStep.values[index];
          final selected = widget.passedSteps.contains(step);
          return Center(
            child: Text(
              step.message,
              style: kMediumMedium.copyWith(
                color: selected ? Styles.kTextColor : Styles.kInactiveColor,
              ),
            ),
          );
        },
      ),
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
