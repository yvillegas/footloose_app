import 'package:either_dart/either.dart';
import 'package:footloose_app/core/error/failures.dart';
import 'package:footloose_app/domain/models/product.dart';
import 'package:footloose_app/domain/repositories/product_repository.dart';
import 'package:footloose_app/domain/use_cases/use_case.dart';

class GetProducts implements UseCase<List<Product>, NoParams> {
  GetProducts(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, List<Product>>> call(NoParams params) {
    return repository.getProducts();
  }
}
