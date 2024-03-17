part of 'product_detail_bloc.dart';

class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

class ProductDetailInitial extends ProductDetailState {
  const ProductDetailInitial();

  @override
  List<Object> get props => [];
}

// GetProduct
class LoadingGetProduct extends ProductDetailState {
  const LoadingGetProduct();

  @override
  List<Object> get props => [];
}

class SuccessGetProduct extends ProductDetailState {
  const SuccessGetProduct({required this.product});

  final Product product;

  @override
  List<Object> get props => [product];
}

class FailureGetProduct extends ProductDetailState {
  const FailureGetProduct();

  @override
  List<Object> get props => [];
}
