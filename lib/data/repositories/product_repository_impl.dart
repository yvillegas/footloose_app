import 'package:either_dart/either.dart';
import 'package:footloose_app/core/error/failures.dart';
import 'package:footloose_app/data/data_sources/product_data_source.dart';
import 'package:footloose_app/domain/models/product.dart';
import 'package:footloose_app/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required this.productDataSource});

  final ProductDataSource productDataSource;

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final products = await productDataSource.getProducts();
      return Right(products);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
