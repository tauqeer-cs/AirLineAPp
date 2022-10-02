import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutSummary extends StatelessWidget {
  const CheckoutSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingCubit>().state;
    return Visibility(
      visible: booking.isVerify,
      child: Container(),
    );
  }
}
