import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebeta_eats/views/cart/bloc/cart_event.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';
import '../../cart/bloc/cart_bloc.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final CartBloc cartBloc;

  CheckoutBloc({required this.cartBloc})
      : super(const CheckoutState()) {
    on<ConfirmOrder>(_onConfirmOrder);
  }

  Future<void> _onConfirmOrder(
    ConfirmOrder event,
    Emitter<CheckoutState> emit,
  ) async {
    try {
      emit(state.copyWith(status: CheckoutStatus.loading));

      // simulate backend call
      await Future.delayed(const Duration(seconds: 2));

      cartBloc.add(ClearCart() as CartEvent);

      emit(state.copyWith(status: CheckoutStatus.success));
    } catch (_) {
      emit(
        state.copyWith(
          status: CheckoutStatus.failure,
          errorMessage: 'Order failed',
        ),
      );
    }
  }
}
