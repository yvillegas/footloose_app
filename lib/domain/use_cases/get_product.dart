import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:footloose_app/core/error/failures.dart';
import 'package:footloose_app/domain/models/product.dart';
import 'package:footloose_app/domain/repositories/product_repository.dart';
import 'package:footloose_app/domain/use_cases/use_case.dart';

class GetProduct implements UseCase<Product, GetProductParams> {
  GetProduct(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, Product>> call(GetProductParams params) {
    return repository.getProduct(params.id);
  }
}

class GetProductParams extends Equatable {
  const GetProductParams({
    required this.id,
  });

  final int id;

  @override
  List<Object> get props => [id];
}
