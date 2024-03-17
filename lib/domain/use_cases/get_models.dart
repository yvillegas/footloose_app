import 'package:either_dart/either.dart';
import 'package:footloose_app/core/error/failures.dart';
import 'package:footloose_app/domain/models/model.dart';
import 'package:footloose_app/domain/repositories/product_repository.dart';
import 'package:footloose_app/domain/use_cases/use_case.dart';

class GetModels implements UseCase<List<Model>, NoParams> {
  GetModels(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, List<Model>>> call(NoParams params) {
    return repository.getModels();
  }
}
