import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/bloc/price_range/price_range_cubit.dart';
import 'package:app/pages/home/ui/filter/calendar_sheet_vertical.dart';
import 'package:app/pages/home/ui/filter/please_select_place.dart';
import 'package:app/theme/my_flutter_app_icons.dart';
import 'package:app/theme/styles.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/widgets/containers/bordered_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dropdown_transformer.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  _onCalendarPick(BuildContext context) {
    final priceCubit = context.read<PriceRangeCubit>();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: const Color.fromRGBO(235, 235, 235, 0.85),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (_) => BlocProvider.value(
        value: priceCubit..resetState(),
        child: const CalendarSheetVertical(),
      ),
    );
  }

  _showPlaceNeedToBeSelected(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: const Color.fromRGBO(235, 235, 235, 0.85),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (_) => const PleaseSelectPlace(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filterState = context.watch<FilterCubit>().state;
    final departDate = filterState.departDate;
    final returnDate = filterState.returnDate;
    final origin = filterState.origin;
    final destination = filterState.destination;
    final List<String> texts = [];
    if (departDate != null) {
      final dateText = AppDateUtils.formatDateWithoutLocale(departDate);
      texts.add(dateText);
    }
    if (returnDate != null) {
      final dateText = AppDateUtils.formatDateWithoutLocale(returnDate);
      texts.add(dateText);
    }
    /*if (texts.isEmpty) {
      texts.add("Please input date");
    }*/

    return InkWell(
      onTap: origin == null || destination == null
          ? () => _showPlaceNeedToBeSelected(context)
          : () => _onCalendarPick(context),
      child: BorderedContainer(
        child: DropdownTransformerWidget<String>(
          value: texts.isEmpty ? null : texts.join(" to "),
          hintText: "Choose Date",
          prefix: Icon(
            MyFlutterApp.icodate,
            size: 20,
            color: Styles.kIconColor,
          ),
        ),
      ),
    );
  }
}
