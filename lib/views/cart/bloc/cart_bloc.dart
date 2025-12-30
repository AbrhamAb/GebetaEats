import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gebeta_eats/models/cart_item_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import '../../../models/mock_data.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState.initial()) {
    on<AddDish>(_onAddDish);
    on<RemoveDish>(_onRemoveDish);
  }

  void _onAddDish(AddDish event, Emitter<CartState> emit) {
  final updatedItems = Map<String, CartItem>.from(state.items);

  if (updatedItems.containsKey(event.dish.id)) {
    updatedItems[event.dish.id] = updatedItems[event.dish.id]!
        .copyWith(quantity: updatedItems[event.dish.id]!.quantity + 1);
  } else {
    updatedItems[event.dish.id] = CartItem(
      id: event.dish.id,
      name: event.dish.name,
      price: event.dish.price,
      quantity: 1,
    );
  }

  final total = updatedItems.values.fold<double>(
    0,
    (sum, item) => sum + item.price * item.quantity,
  );

  emit(state.copyWith(items: updatedItems, total: total));
}


  void _onRemoveDish(RemoveDish event, Emitter<CartState> emit) {
  final updatedItems = Map<String, CartItem>.from(state.items);

  if (!updatedItems.containsKey(event.dish.id)) return;

  final item = updatedItems[event.dish.id]!;
  if (item.quantity > 1) {
    updatedItems[event.dish.id] = item.copyWith(quantity: item.quantity - 1);
  } else {
    updatedItems.remove(event.dish.id);
  }

  final total = updatedItems.values.fold<double>(
    0,
    (sum, item) => sum + item.price * item.quantity,
  );

  emit(state.copyWith(items: updatedItems, total: total));
}

}
