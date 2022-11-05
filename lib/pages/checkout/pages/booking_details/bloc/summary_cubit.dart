import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/flight_repository.dart';
import 'package:app/data/requests/summary_request.dart';
import 'package:app/data/responses/summary_response.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'summary_state.dart';

class SummaryCubit extends Cubit<SummaryState> {
  SummaryCubit() : super(const SummaryState());
  final _repository = FlightRepository();

  submitSummary(SummaryRequest summaryRequest) async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final response = await _repository.summaryFlight(summaryRequest);
      emit(state.copyWith(
        blocState: BlocState.finished,
        summaryResponse:response,
        summaryRequest: summaryRequest,
      ));
    } catch (e, st) {
      emit(
        state.copyWith(
          message: ErrorUtils.getErrorMessage(e, st),
          blocState: BlocState.failed,
        ),
      );
    }
  }
}
