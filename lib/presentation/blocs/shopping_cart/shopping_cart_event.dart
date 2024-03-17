part of 'shopping_cart_bloc.dart';

class ShoppingCartEvent extends Equatable {
  const ShoppingCartEvent();

  @override
  List<Object> get props => [];
}

class OnAddProduct extends ShoppingCartEvent {
  const OnAddProduct({
    required this.product,
    required this.total,
  });

  final Product product;
  final int total;

  @override
  List<Object> get props => [product, total];
}

class OnRemoveProduct extends ShoppingCartEvent {
  const OnRemoveProduct({
    required this.index,
  });

  final int index;

  @override
  List<Object> get props => [index];
}
