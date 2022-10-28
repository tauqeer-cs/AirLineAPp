import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'promotions_state.dart';

class PromotionsCubit extends Cubit<PromotionsState> {
  PromotionsCubit() : super(PromotionsInitial());
}
