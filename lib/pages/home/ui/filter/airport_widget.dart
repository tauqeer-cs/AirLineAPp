import 'package:app/app/app_bloc_helper.dart';
import 'package:app/blocs/airports/airports_cubit.dart';
import 'package:app/models/airports.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/theme/my_flutter_app_icons.dart';
import 'package:app/theme/theme.dart';
import 'package:app/widgets/animations/text_field_loader.dart';
import 'package:app/widgets/forms/app_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dropdown_transformer.dart';

class AirportWidget extends StatelessWidget {
  final bool isOrigin;

  const AirportWidget({Key? key, required this.isOrigin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final origin = context.watch<FilterCubit>().state.origin;
    final selected = isOrigin
        ? context.watch<FilterCubit>().state.origin
        : context.watch<FilterCubit>().state.destination;
    return BlocBuilder<AirportsCubit, AirportsState>(
      builder: (context, state) {
        final airports = List<Airports>.from(state.airports);
        airports.sort((a, b) => (a.name ?? "").compareTo(b.name ?? ""));
        final connections = List<Airports>.from(origin?.connections ?? []);
        connections.sort((a, b) => (a.name ?? "").compareTo(b.name ?? ""));
        return blocBuilderWrapper(
          blocState: state.blocState,
          loadingBuilder: const TextFieldLoader(),
          finishedBuilder: AppDropDown<Airports>(
            items: isOrigin ? airports : connections,
            defaultValue: selected,
            onChanged: (val) {
              if (isOrigin) {
                context.read<FilterCubit>().updateOriginAirport(val);
              } else {
                context.read<FilterCubit>().updateDestinationAirport(val);
              }
            },
            prefix: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                isOrigin ? Icons.flight_takeoff : Icons.flight_land,
                size: 20,
                color: Styles.kIconColor,
              ),
            ),
            sheetTitle: isOrigin ? "from".tr() : "to".tr(),
            isEnabled: true,
            valueTransformer: (value) {
              return DropdownTransformerWidget<Airports>(
                value: value,
                //label: isOrigin ? "From" : "To",
                prefix: Icon(
                  isOrigin ? MyFlutterApp.icoflyfrom : MyFlutterApp.icoflyto,
                  size: 20,
                ),
              );
            },
            valueTransformerItem: (value, selected) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      value.toString(),
                      style: kMediumMedium.copyWith(
                        color: selected ? Styles.kPrimaryColor : null,
                      ),
                    ),
                  ),
                  Text(
                    value?.code ?? "",
                    style: kMediumMedium.copyWith(
                      color: selected ? Styles.kPrimaryColor : null,
                    ),
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}
