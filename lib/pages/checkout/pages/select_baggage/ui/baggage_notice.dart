import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';

class BaggageNotice extends StatelessWidget {
  const BaggageNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Carry-on Baggage", style: kGiantSemiBold),
          kVerticalSpacer,
          Text("You have a carry-on allowance of 7kg "),
          kVerticalSpacerSmall,
          Text("You can bring 2 items: one main item and one small item weighing a combined 7kg. "),
          kVerticalSpacerSmall,
          Text("Baggage fees apply at the airport if you exceed your allowance. "),
          kVerticalSpacerSmall,
          Text("If you need more, add 7kg to increase your allowance to 14kg. Limited availability per flight. "),
        ],
      ),
    );
  }
}
