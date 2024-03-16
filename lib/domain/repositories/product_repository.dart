import 'package:either_dart/either.dart';
import 'package:footloose_app/core/error/failures.dart';
import 'package:footloose_app/domain/models/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
}
