import 'package:either_dart/either.dart';
import 'package:footloose_app/core/error/failures.dart';
import 'package:footloose_app/domain/models/size.dart';
import 'package:footloose_app/domain/repositories/product_repository.dart';
import 'package:footloose_app/domain/use_cases/use_case.dart';

class GetSizes implements UseCase<List<Size>, NoParams> {
  GetSizes(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, List<Size>>> call(NoParams params) {
    return repository.getSizes();
  }
}
