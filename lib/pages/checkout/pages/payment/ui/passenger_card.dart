import 'package:app/blocs/booking/booking_cubit.dart';
import 'package:app/models/number_person.dart';
import 'package:app/theme/theme.dart';
import 'package:app/utils/string_utils.dart';
import 'package:app/widgets/app_card.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassengerCard extends StatelessWidget {
  const PassengerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final passengers = context
        .watch<BookingCubit>()
        .state
        .summaryRequest
        ?.flightSummaryPNRRequest
        .passengers;
    final superPnr = context.watch<BookingCubit>().state.superPnrNo;

    int adult = 0;
    int infant = 0;
    int children = 0;
    return AppCard(
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "passengers".tr(),
                        style:
                            kMediumHeavy.copyWith(color: Styles.kSubTextColor),
                      ),
                    ),
                    kVerticalSpacerMini,
                    ...(passengers ?? []).mapIndexed(
                      (index, e) {
                        int number;
                        switch (e.getType) {
                          case PeopleType.adult:
                            adult++;
                            number = adult;
                            break;
                          case PeopleType.child:
                            children++;
                            number = children;
                            break;
                          case PeopleType.infant:
                            infant++;
                            number = infant;
                            break;
                          case null:
                            number = 0;
                            break;
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${e.getType?.name.capitalize()} $number",
                              style: kLargeHeavy,
                            ),
                            kVerticalSpacerMini,
                            Text(
                                "${e.titleToShow} ${e.firstName} ${e.lastName}"),
                            kVerticalSpacerSmall,
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: Visibility(
              visible: superPnr == null,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Edit",
                  style: kMediumRegular.copyWith(color: Styles.kPrimaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
