import 'package:app/app/app_bloc_helper.dart';
import 'package:app/app/app_router.dart';
import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/app_loading_screen.dart';
import 'package:app/widgets/app_money_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingSummary extends StatelessWidget {
  const BookingSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filterState = context.watch<SearchFlightCubit>().state.filterState;
    final booking = context.watch<BookingCubit>().state;


    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("Your total booking", style: kMediumRegular.copyWith(color: Styles.kSubTextColor),),
        MoneyWidget(
          isDense: false,
          amount: booking.getFinalPrice +
              (filterState?.numberPerson.getTotal() ?? 0),
        ),
        kVerticalSpacer,
      ],
    );
  }
}


class SummaryContainer extends StatelessWidget {
  final Widget child;
  const SummaryContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, -2),
              blurRadius: 6,
            ),
          ]
      ),
      child: child,
    );
  }
}
