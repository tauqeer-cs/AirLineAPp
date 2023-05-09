import 'package:app/blocs/booking_local/booking_local_cubit.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:app/widgets/app_divider_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingListPage extends StatelessWidget {
  const BookingListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = context.locale.toString();


    final bookings = context.watch<BookingLocalCubit>().state.bookings;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Bookings"),
      ),
      body: ListView(
        padding: kPagePadding,
        children: bookings
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: InkWell(
                  onTap: (){},
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.bookingId ?? "",
                          style: kHugeSemiBold.copyWith(
                              color: Styles.kPrimaryColor),
                        ),
                        const AppDividerWidget(),
                        kVerticalSpacerSmall,
                        Text(AppDateUtils.formatFullDate(e.departureDate,locale: locale)),
                        Text(e.departureString ?? ""),
                        kVerticalSpacerMini,
                        kVerticalSpacerSmall,
                        Text(AppDateUtils.formatFullDate(e.returnDate,locale: locale),),
                        Text(e.returnString ?? ""),
                        kVerticalSpacerMini,
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
