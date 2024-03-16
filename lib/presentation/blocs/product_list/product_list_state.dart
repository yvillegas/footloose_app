part of 'product_list_bloc.dart';

sealed class ProductListState extends Equatable {
  const ProductListState();

  @override
  List<Object> get props => [];
}

class ProductListInitial extends ProductListState {}

// LoginUser
class LoadingGetProducts extends ProductListState {
  const LoadingGetProducts();

  @override
  List<Object> get props => [];
}

class SuccessGetProducts extends ProductListState {
  const SuccessGetProducts({required this.products});

  final List<Product> products;

  @override
  List<Object> get props => [products];
}

class FailureGetProducts extends ProductListState {
  const FailureGetProducts();

  @override
  List<Object> get props => [];
}
