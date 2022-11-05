import 'package:app/app/app_bloc_helper.dart';
import 'package:app/data/repositories/public_repository.dart';
import 'package:app/models/country.dart';
import 'package:app/utils/error_utils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'countries_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  CountriesCubit() : super(const CountriesState());

  final _repository = PublicRepository();

  getCountries() async {
    emit(state.copyWith(blocState: BlocState.loading));
    try {
      final countries = await _repository.getCountries();
      emit(state.copyWith(
        blocState: BlocState.finished,
        countries: countries.countries ?? [],
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
