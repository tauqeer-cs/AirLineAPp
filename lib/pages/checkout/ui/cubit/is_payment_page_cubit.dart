import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'is_payment_page_state.dart';

class IsPaymentPageCubit extends Cubit<bool> {
  IsPaymentPageCubit(isPaymentPage) : super(isPaymentPage);
}
