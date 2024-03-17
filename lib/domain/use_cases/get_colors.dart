import 'package:either_dart/either.dart';
import 'package:footloose_app/core/error/failures.dart';
import 'package:footloose_app/domain/models/color.dart';
import 'package:footloose_app/domain/repositories/product_repository.dart';
import 'package:footloose_app/domain/use_cases/use_case.dart';

class GetColors implements UseCase<List<Color>, NoParams> {
  GetColors(this.repository);

  final ProductRepository repository;

  @override
  Future<Either<Failure, List<Color>>> call(NoParams params) {
    return repository.getColors();
  }
}
