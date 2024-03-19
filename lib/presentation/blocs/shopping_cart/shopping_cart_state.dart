part of 'shopping_cart_bloc.dart';

class ShoppingCartState extends Equatable {
  const ShoppingCartState();

  @override
  List<Object> get props => [];
}

class ShoppingCartInitial extends ShoppingCartState {
  const ShoppingCartInitial();

  @override
  List<Object> get props => [];
}

class LoadingShoppingCart extends ShoppingCartState {
  const LoadingShoppingCart();

  @override
  List<Object> get props => [];
}

class LoadedShoppingCart extends ShoppingCartState {
  const LoadedShoppingCart({
    required this.products,
  });

  final List<ShoppingCartProduct> products;

  @override
  List<Object> get props => [];
}

class LoadingSaveShoppingCart extends ShoppingCartState {
  const LoadingSaveShoppingCart();

  @override
  List<Object> get props => [];
}

class SuccessSaveShoppingCart extends ShoppingCartState {
  const SuccessSaveShoppingCart();

  @override
  List<Object> get props => [];
}

class FailureSaveShoppingCart extends ShoppingCartState {
  const FailureSaveShoppingCart();

  @override
  List<Object> get props => [];
}
