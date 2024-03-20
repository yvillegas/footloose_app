import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footloose_app/domain/models/product.dart';
import 'package:footloose_app/domain/models/shopping_cart.dart';
import 'package:footloose_app/domain/use_cases/save_shopping_cart.dart';

part 'shopping_cart_event.dart';
part 'shopping_cart_state.dart';

class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  ShoppingCartBloc({
    required this.saveShoppingCart,
  }) : super(const ShoppingCartInitial()) {
    on<OnAddProduct>(_onAddProduct);
    on<OnRemoveProduct>(_onRemoveProduct);
    on<OnSaveShoppingCart>(_onSaveShoppingCart);
  }

  final SaveShoppingCart saveShoppingCart;

  final products = <ShoppingCartProduct>[];

  Future<void> _onAddProduct(
    OnAddProduct event,
    Emitter<ShoppingCartState> emit,
  ) async {
    emit(const LoadingShoppingCart());

    final currentProduct = products;
    currentProduct.add(
      ShoppingCartProduct(
        product: event.product,
        total: event.total,
      ),
    );

    emit(LoadedShoppingCart(products: currentProduct));
  }

  Future<void> _onRemoveProduct(
    OnRemoveProduct event,
    Emitter<ShoppingCartState> emit,
  ) async {
    emit(const LoadingShoppingCart());

    final currentProduct = products;
    currentProduct.removeAt(event.index);

    emit(LoadedShoppingCart(products: currentProduct));
  }

  Future<void> _onSaveShoppingCart(
    OnSaveShoppingCart event,
    Emitter<ShoppingCartState> emit,
  ) async {
    emit(const LoadingSaveShoppingCart());

    final failureOrResponse =
        await saveShoppingCart(SaveShoppingCartParams(products: products));

    emit(
      failureOrResponse.fold(
        (left) => const FailureSaveShoppingCart(),
        (right) {
          products.clear();
          return const SuccessSaveShoppingCart();
        },
      ),
    );
  }
}
