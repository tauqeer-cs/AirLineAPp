import 'package:app/app/app_router.dart';
import 'package:app/blocs/search_flight/search_flight_cubit.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/utils/user_insider.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../checkout/pages/insurance/bloc/insurance_cubit.dart';

class SubmitSearch extends StatelessWidget {
  final bool isHomePage;

  const SubmitSearch({Key? key, required this.isHomePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filter = context.watch<FilterCubit>().state;
    final isValid = filter.isValid;
    final insuranceBloc = context.watch<InsuranceCubit>();


    return ElevatedButton(
      onPressed: !isValid
          ? null
          : () {
              context
                  .read<SearchFlightCubit>()
                  .searchFlights(filter,  filter.origin?.currency ?? 'MYR');

              if (isHomePage) {

                UserInsider.of(context).registerStandardEvent(
                  InsiderConstants.searchFlightButtonClicked,
                );
                insuranceBloc.resetStates();

                context.router
                    .push(SearchResultRoute(showLoginDialog: isHomePage));
              } else {
                context.router.pop();
              }
            },
      child: Text(
        "searchFlight".tr(),
      ),
    );
  }
}
