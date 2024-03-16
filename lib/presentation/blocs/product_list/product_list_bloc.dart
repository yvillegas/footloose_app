import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footloose_app/domain/models/product.dart';
import 'package:footloose_app/domain/use_cases/get_products.dart';
import 'package:footloose_app/domain/use_cases/use_case.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc({
    required this.getProducts,
  }) : super(ProductListInitial()) {
    on<OnGetProducts>(_onGetProducts);
  }

  final GetProducts getProducts;

  Future<void> _onGetProducts(
    OnGetProducts event,
    Emitter<ProductListState> emit,
  ) async {
    emit(const LoadingGetProducts());

    final failureOrResponse = await getProducts(NoParams());

    emit(
      failureOrResponse.fold(
        (left) => const FailureGetProducts(),
        (products) => SuccessGetProducts(products: products),
      ),
    );
  }
}
