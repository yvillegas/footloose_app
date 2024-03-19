import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:footloose_app/core/error/failures.dart';
import 'package:footloose_app/domain/models/shopping_cart.dart';
import 'package:footloose_app/domain/repositories/product_repository.dart';
import 'package:footloose_app/domain/use_cases/use_case.dart';

class SaveShoppingCart implements UseCase<bool, SaveShoppingCartParams> {
  SaveShoppingCart(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, bool>> call(SaveShoppingCartParams params) {
    return repository.saveShoppingCart(params.products);
  }
}

class SaveShoppingCartParams extends Equatable {
  const SaveShoppingCartParams({
    required this.products,
  });

  final List<ShoppingCartProduct> products;

  @override
  List<Object> get props => [products];
}
