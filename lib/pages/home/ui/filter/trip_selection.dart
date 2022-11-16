import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TripSelection extends StatelessWidget {
  const TripSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tripType = context.watch<FilterCubit>().state.flightType;
    return Row(
      children: FlightType.values
          .map(
            (e) => Expanded(
              child: InkWell(
                onTap: () {
                  if (tripType == e) return;
                  context.read<FilterCubit>().updateTripType(e);
                  if (e == FlightType.oneWay) {
                    context.read<FilterCubit>().updateDateReturnDate(returnDate: null);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color:
                          e == tripType ? Styles.kPrimaryColor : Colors.white,
                      border: Border.all(
                        color: e == tripType
                            ? Styles.kPrimaryColor
                            : Styles.kBorderColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Radio<FlightType?>(
                        value: e,
                        visualDensity: const VisualDensity(
                          horizontal: -2,
                          vertical: -2,
                        ),
                        activeColor: Colors.white,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        groupValue: tripType,
                        onChanged: (value) {
                          context.read<FilterCubit>().updateTripType(value);
                        },
                      ),
                      kHorizontalSpacerMini,
                      Text(
                        e.message,
                        style: kMediumMedium.copyWith(
                            color: e == tripType ? Colors.white : null),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
