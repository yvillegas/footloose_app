import 'package:either_dart/either.dart';
import 'package:footloose_app/core/error/failures.dart';
import 'package:footloose_app/domain/models/brand.dart';
import 'package:footloose_app/domain/models/color.dart';
import 'package:footloose_app/domain/models/model.dart';
import 'package:footloose_app/domain/models/product.dart';
import 'package:footloose_app/domain/models/size.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  Future<Either<Failure, List<Brand>>> getBrands();
  Future<Either<Failure, List<Model>>> getModels();
  Future<Either<Failure, List<Color>>> getColors();
  Future<Either<Failure, List<Size>>> getSizes();
  Future<Either<Failure, Product>> getProduct(int id);
}
