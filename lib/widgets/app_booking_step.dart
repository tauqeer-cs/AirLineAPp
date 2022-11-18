import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBookingStep extends StatefulWidget {
  final List<BookingStep> passedSteps;

  final Function(int index) onTopStepTaped;

  const AppBookingStep({Key? key, required this.passedSteps, required this.onTopStepTaped}) : super(key: key);

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
    return SizedBox(
      height: 60,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        controller: _controller,
        scrollDirection: Axis.horizontal,
        itemCount: BookingStep.values.length,
        separatorBuilder: (context, index) {
          final step = BookingStep.values[index];
          final selected = widget.passedSteps.contains(step);
          return Container(
            width: 20,
            margin: const EdgeInsets.symmetric(horizontal: 5),
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
            child: GestureDetector(
              onTap: (){

                widget.onTopStepTaped(index);

              },
              child: Text(
                step.message,
                style: kMediumMedium.copyWith(
                  color: selected ? Styles.kTextColor : Styles.kInactiveColor,
                ),
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
  payment("Summary & Payment");

  const BookingStep(this.message);

  final String message;
}
