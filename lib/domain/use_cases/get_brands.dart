import 'package:either_dart/either.dart';
import 'package:footloose_app/core/error/failures.dart';
import 'package:footloose_app/domain/models/brand.dart';
import 'package:footloose_app/domain/repositories/product_repository.dart';
import 'package:footloose_app/domain/use_cases/use_case.dart';

class GetBrands implements UseCase<List<Brand>, NoParams> {
  GetBrands(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, List<Brand>>> call(NoParams params) {
    return repository.getBrands();
  }
}
