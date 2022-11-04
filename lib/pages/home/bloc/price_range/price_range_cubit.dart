import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/flight_repository.dart';
import 'package:app/data/requests/search_flight_request.dart';
import 'package:app/models/search_date_range.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'price_range_state.dart';

class PriceRangeCubit extends Cubit<PriceRangeState> {
  PriceRangeCubit() : super(PriceRangeState());
  final _repository = FlightRepository();

  getPrices(FilterState filterState, {DateTime? startFilter, DateTime? endFilter}) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final start = startFilter ?? filterState.departDate ?? DateTime.now();
      print("start is $start");
      final newFilter = filterState.copyWith(
        departDate: start.isBefore(DateTime.now()) ? DateTime.now() : start,
        returnDate: DateTime(start.year, start.month+2, 0),
      );
      final request = SearchFlight.fromFilter(newFilter);
      final prices = await _repository.searchFlightDateRange(request);

      emit(state.copyWith(
        blocState: BlocState.finished,
        prices: prices.searchDateRangeResponse?.dateRangePrices ?? [],
      ));
    } catch (e, st) {
      emit(
        state.copyWith(
            message: ErrorUtils.getErrorMessage(e, st),
            blocState: BlocState.failed),
      );
    }
  }
}
