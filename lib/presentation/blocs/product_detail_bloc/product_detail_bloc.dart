import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footloose_app/domain/models/product.dart';
import 'package:footloose_app/domain/use_cases/get_product.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc({
    required this.getProduct,
  }) : super(const ProductDetailInitial()) {
    on<OnGetProduct>(_onGetProduct);
  }

  final GetProduct getProduct;

  Future<void> _onGetProduct(
    OnGetProduct event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(const LoadingGetProduct());

    final failureOrResponse = await getProduct(GetProductParams(id: event.id));

    emit(
      failureOrResponse.fold(
        (left) => const FailureGetProduct(),
        (product) => SuccessGetProduct(product: product),
      ),
    );
  }
}
