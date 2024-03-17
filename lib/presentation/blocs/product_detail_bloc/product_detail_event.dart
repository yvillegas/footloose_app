part of 'product_detail_bloc.dart';

class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class OnGetProduct extends ProductDetailEvent {
  const OnGetProduct({required this.id});

  final int id;

  @override
  List<Object> get props => [];
}
