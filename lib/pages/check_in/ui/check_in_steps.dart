import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:screenshot/screenshot.dart';

import '../../../theme/styles.dart';
import '../../../theme/typography.dart';
import '../../../widgets/app_divider_widget.dart';

class CheckInSteps extends StatefulWidget {
  final List<CheckInStep> passedSteps;

  final bool isLast;

  final Function(int index) onTopStepTaped;

  const CheckInSteps(
      {Key? key, required this.passedSteps, required this.onTopStepTaped,  this.isLast = false})
      : super(key: key);

  @override
  State<CheckInSteps> createState() => _CheckInStepsState();
}

class _CheckInStepsState extends State<CheckInSteps> {
  final ScrollController _controller = ScrollController();





  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),


        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            currentStep(0),
            Container(
              //color: Colors.lightBlueAccent,
              width: 20,
              margin: const EdgeInsets.symmetric(horizontal: 0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AppDividerWidget(
                    color: Styles.kInactiveColor,
                  ),
                ),
              ),
            ),
            currentStep(1),
            Container(
              //color: Colors.lightBlueAccent,
              width: 20,
              margin: const EdgeInsets.symmetric(horizontal: 0),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AppDividerWidget(
                    color: Styles.kInactiveColor,
                  ),
                ),
              ),
            ),
            currentStep(2),
          ],
        ),

        Row(
          children: [
            Expanded(child: currentStepBottom(0)),
            Expanded(child: currentStepBottom(1)),
            Expanded(child: currentStepBottom(2)),
          ],
        ),

        const SizedBox(height: 10),
      ],
    );
  }

  Widget currentStep(int index) {
    final step = CheckInStep.values[index];
    final selected = widget.passedSteps.contains(step);
    return Expanded(
      child: Center(
        child: Column(
          children: [
            Text(
              '0${index + 1}',
              style: kGiantHeavy.copyWith(
                color:
                    selected ? Styles.kPrimaryColor : ( widget.isLast == true ? Styles.kTextColor : Styles.kInactiveColor),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget currentStepBottom(int index) {
    final step = CheckInStep.values[index];
    final selected = widget.passedSteps.contains(step);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if(index == 2) ... [
          ImageIcon(
            const AssetImage("assets/images/icons/planeCircle.png"),
            color: selected ? Styles.kPrimaryColor : ( widget.isLast == true ? Styles.kTextColor : Styles.kInactiveColor),

          )

        ] else ... [
          Icon(
            step.iconData,
            color: selected ? Styles.kPrimaryColor : ( widget.isLast == true ? Styles.kTextColor : Styles.kInactiveColor),
          ),
        ],

        const SizedBox(
          width: 4,
        ),
        if(selected == false && widget.isLast == true) ... [
          Text(
            step.message,
            style: kMediumRegular.copyWith(
              color: selected ? Styles.kPrimaryColor : ( widget.isLast == true ? Styles.kTextColor : Styles.kInactiveColor),
            ),
            textAlign: TextAlign.left,
          ),
        ] else ... [
          Text(
            step.message,
            style: kMediumHeavy.copyWith(
              color: selected ? Styles.kPrimaryColor : ( widget.isLast == true ? Styles.kTextColor : Styles.kInactiveColor),
            ),
            textAlign: TextAlign.left,
          ),
        ],

      ],
    );
  }
}

enum CheckInStep {
  itinerary("Itinerary", FontAwesomeIcons.clipboardList),
  addOn("Declaration", FontAwesomeIcons.circleExclamation),
  bookingDetails('Boarding\nPass', FontAwesomeIcons.planeCircleCheck);

  const CheckInStep(this.message, this.iconData);

  final String message;
  final IconData iconData;
}
