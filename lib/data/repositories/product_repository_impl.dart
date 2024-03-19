import 'package:either_dart/either.dart';
import 'package:footloose_app/core/error/failures.dart';
import 'package:footloose_app/data/data_sources/product_data_source.dart';
import 'package:footloose_app/domain/models/brand.dart';
import 'package:footloose_app/domain/models/color.dart';
import 'package:footloose_app/domain/models/model.dart';
import 'package:footloose_app/domain/models/product.dart';
import 'package:footloose_app/domain/models/shopping_cart.dart';
import 'package:footloose_app/domain/models/size.dart';
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

  @override
  Future<Either<Failure, List<Brand>>> getBrands() async {
    try {
      final brands = await productDataSource.getBrands();
      return Right(brands);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Model>>> getModels() async {
    try {
      final models = await productDataSource.getModels();
      return Right(models);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Color>>> getColors() async {
    try {
      final colors = await productDataSource.getColors();
      return Right(colors);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<Size>>> getSizes() async {
    try {
      final sizes = await productDataSource.getSizes();
      return Right(sizes);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> getProduct(int id) async {
    try {
      final product = await productDataSource.getProduct(id);
      return Right(product);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveShoppingCart(
    List<ShoppingCartProduct> products,
  ) async {
    try {
      final saved = await productDataSource.saveShoppingCart(products);
      return Right(saved);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
