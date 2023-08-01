import 'package:app/blocs/is_departure/is_departure_cubit.dart';
import 'package:app/models/number_person.dart';
import 'package:app/pages/add_on/seats/ui/seat_legend_simple.dart';
import 'package:app/pages/add_on/seats/ui/selected_seats.dart';
import 'package:app/pages/add_on/ui/passenger_selector.dart';
import 'package:app/pages/add_on/seats/ui/seat_legend.dart';
import 'package:app/pages/add_on/seats/ui/seat_plan.dart';
import 'package:app/pages/add_on/seats/ui/seat_remove.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatsSection extends StatefulWidget {
  final bool isDeparture;
  final VoidCallback? moveToTop;
  final VoidCallback? moveToBottom;
  const SeatsSection(
      {Key? key, this.isDeparture = true, this.moveToTop, this.moveToBottom})
      : super(key: key);

  @override
  State<SeatsSection> createState() => _SeatsSectionState();
}

class _SeatsSectionState extends State<SeatsSection> {
//class SeatsSection extends StatelessWidget {
  //final bool isDeparture;
  //final VoidCallback? moveToTop;
  //final VoidCallback? moveToBottom;
  int personIndex = 0;

  void _functionCallback(int i) {

    setState(() {
      personIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IsDepartureCubit()..changeDeparture(widget.isDeparture),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: kPageHorizontalPadding,
            child: PassengerSelector(
              isDeparture: widget.isDeparture,
              isSeatSelection: true,
              addonType: AddonType.seat,
              onCountChanged: personIndex
            ),
          ),
          kVerticalSpacerSmall,
          const Padding(
            padding: kPageHorizontalPaddingBig,
            child: SeatLegendSimple(),
          ),
          kVerticalSpacer,
          SeatPlan(
            moveToTop: () {
              widget.moveToTop?.call();
            },
            moveToBottom: () {
              widget.moveToBottom?.call();
            },
            onCountChanged: _functionCallback
          ),
        ],
      ),
    );
  }
}
