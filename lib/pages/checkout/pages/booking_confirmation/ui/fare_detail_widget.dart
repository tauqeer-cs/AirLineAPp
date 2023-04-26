import 'package:app/pages/checkout/pages/booking_confirmation/bloc/confirmation_cubit.dart';
import 'package:app/theme/spacer.dart';
import 'package:app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FareDetailWidget extends StatelessWidget {
  const FareDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passengers = context
            .watch<ConfirmationCubit>()
            .state
            .confirmationModel
            ?.value
            ?.passengers ??
        [];
    return Column(
      children: [
        ...(passengers
            .map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Row(
                    children: [
                      Text(
                        "${e.titleToShow?.toUpperCase()} ${e.givenName?.toUpperCase()} ${e.surname?.toUpperCase()}",
                        style: kMediumMedium,
                      ),
                      const Spacer(),
                      // MoneyWidget(
                      //   currency: fareAndBundle.currency,
                      //   amount: fareAndBundle.fareAmount,
                      //   isDense: true,
                      // ),
                      //
                      // kVerticalSpacer,
                    ],
                  ),
            ))
            .toList()),
        kVerticalSpacerMini,
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 0.0),
        //   child: Column(
        //     children: (fareAndBundle.bundleItems ?? [])
        //         .map((f) => Row(
        //       children: [
        //         Text(
        //             "${f.bundleName}"),
        //         // Spacer(),
        //         // MoneyWidget(
        //         //   currency: fareAndBundle.currency,
        //         //   amount: fareAndBundle.fareAmount,
        //         //   isDense: true,
        //         // ),
        //       ],
        //     ))
        //         .toList(),
        //   ),
        // ),
        // kVerticalSpacerSmall,
      ],
    );
  }
}
