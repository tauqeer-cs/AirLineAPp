import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/flight_repository.dart';
import 'package:app/data/requests/search_flight_request.dart';
import 'package:app/models/search_date_range.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/utils/date_utils.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

part 'price_range_state.dart';

class PriceRangeCubit extends Cubit<PriceRangeState> {
  PriceRangeCubit() : super(const PriceRangeState());
  final _repository = FlightRepository();

  getPrices(FilterState filterState, {required DateTime startFilter, DateTime? endFilter,String? currency}) async {
    final prevLoaded = List<DateTime>.from(state.loadedDate);
    final checkDate = prevLoaded.firstWhereOrNull((element) => AppDateUtils.sameMonth(element, startFilter));
    DateTime currentDate = DateTime.now();

    if (startFilter.isBefore(currentDate)) {

      return;

    }
    if(checkDate!=null) return;
    emit(state.copyWith(blocState: BlocState.loading, loadingDate: startFilter));
    try {
      final start = startFilter;
      final newFilter = filterState.copyWith(
        departDate: start.isBefore(DateTime.now()) ? DateTime.now() : start,
        returnDate: DateTime(start.year, start.month+1, 0),

      );
      var request = SearchFlight.fromFilter(newFilter,currency ?? 'MYR');


      final prices = await _repository.searchFlightDateRange(request);
      final prevList = List<DateRangePrice>.from(state.prices);
      final prevLoaded = List<DateTime>.from(state.loadedDate);
      prevList.addAll(prices.searchDateRangeResponse?.dateRangePrices ?? []);
      prevLoaded.add(startFilter);
      emit(state.copyWith(
        blocState: BlocState.finished,
        prices: prevList,
        loadedDate: prevLoaded,
      ));
    } catch (e, st) {
      emit(
        state.copyWith(
            message: ErrorUtils.getErrorMessage(e, st),
            blocState: BlocState.failed),
      );
    }
  }

  resetState(){
    emit(const PriceRangeState());
  }
}
