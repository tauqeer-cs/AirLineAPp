import 'package:app/models/number_person.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/bloc/price_range/price_range_cubit.dart';
import 'package:app/pages/home/ui/filter/calendar_sheet.dart';
import 'package:app/pages/home/ui/filter/passengers_sheet.dart';
import 'package:app/pages/home/ui/filter/table_range.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/widgets/containers/bordered_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dropdown_transformer.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({Key? key}) : super(key: key);

  _onCalendarPick(BuildContext context) {
    final priceCubit = context.read<PriceRangeCubit>();
    final filter = context.read<FilterCubit>().state;
    context.read<PriceRangeCubit>().getPrices(filter);
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      builder: (_) => BlocProvider.value(
        value: priceCubit,
        child: CalendarSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final departDate = context.watch<FilterCubit>().state.departDate;
    final returnDate = context.watch<FilterCubit>().state.returnDate;
    final List<String> texts = [];
    if (departDate != null) {
      final dateText = AppDateUtils.formatDateWithoutLocale(departDate);
      texts.add(dateText);
    }
    if (returnDate != null) {
      final dateText = AppDateUtils.formatDateWithoutLocale(returnDate);
      texts.add(dateText);
    }
    if (texts.isEmpty) {
      texts.add("Please input date");
    }

    return GestureDetector(
      onTap: () => _onCalendarPick(context),
      child: BorderedContainer(
        child: DropdownTransformerWidget<String>(
          value: texts.join(" to "),
          label: null,
          prefix: Icon(
            Icons.calendar_today_outlined,
            size: 20,
          ),
        ),
      ),
    );
  }
}
