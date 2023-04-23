import 'package:app/blocs/timer/timer_bloc.dart';
import 'package:app/data/repositories/remote_config_repository.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppBookingStep extends StatefulWidget {
  final List<BookingStep> passedSteps;

  final Function(int index) onTopStepTaped;

  const AppBookingStep(
      {Key? key, required this.passedSteps, required this.onTopStepTaped})
      : super(key: key);

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
    final remaining = context.watch<TimerBloc>().state.durationRemaining;
    return Visibility(
      visible: RemoteConfigRepository.showTimer,
      replacement: SizedBox(
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
                color: selected ? Styles.kPrimaryColor : Styles.kInactiveColor,
              ),
            );
          },
          itemBuilder: (context, index) {
            final step = BookingStep.values[index];
            final selected = widget.passedSteps.contains(step);
            return Center(
              child: GestureDetector(
                onTap: () {
                  widget.onTopStepTaped(index);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    step == BookingStep.insurance
                        ? Image.asset(
                            selected
                                ? "assets/images/icons/insurance.png"
                                : "assets/images/icons/insurance_inactive.png",
                            width: 16,
                            height: 16,
                          )
                        : FaIcon(
                            step.iconData,
                            color: selected
                                ? Styles.kTextColor
                                : Styles.kInactiveColor,
                            size: 14,
                          ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      step.messageTranslated.tr(),
                      style: selected
                          ? kMediumHeavy.copyWith(fontWeight: FontWeight.w900)
                          : kMediumMedium.copyWith(
                              color: selected
                                  ? Styles.kTextColor
                                  : Styles.kInactiveColor,
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      child: SizedBox(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 20),
            Expanded(
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
                      color: selected
                          ? Styles.kPrimaryColor
                          : Styles.kInactiveColor,
                    ),
                  );
                },
                itemBuilder: (context, index) {
                  final step = BookingStep.values[index];
                  final selected = widget.passedSteps.contains(step);
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        widget.onTopStepTaped(index);
                      },
                      child: Text(
                        step.messageTranslated.tr(),
                        style: kMediumMedium.copyWith(
                          color: selected
                              ? Styles.kTextColor
                              : Styles.kInactiveColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Flexible(child: Text("expired remaining $remaining")),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

enum BookingStep {
  flights("Flights", FontAwesomeIcons.plane, "flights"),
  addOn("Add-On", FontAwesomeIcons.briefcase, "addOn"),
  bookingDetails(
      "Booking Details", FontAwesomeIcons.clipboardList, "bookingDetails"),
  insurance("Insurance", FontAwesomeIcons.planeDeparture, "insurance"),
  payment("Summary & Payment", Icons.monetization_on, "summaryPayment");

  const BookingStep(this.message, this.iconData, this.messageTranslated);

  final String message;
  final IconData iconData;
  final String messageTranslated;
}
