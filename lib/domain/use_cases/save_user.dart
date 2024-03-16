import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:footloose_app/core/error/failures.dart';
import 'package:footloose_app/domain/models/auth_response.dart';
import 'package:footloose_app/domain/repositories/auth_repository.dart';
import 'package:footloose_app/domain/use_cases/use_case.dart';

class SaveUser implements UseCase<bool, SaveUserParams> {
  SaveUser(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, bool>> call(SaveUserParams params) {
    return repository.saveUser(params.authResponse);
  }
}

class SaveUserParams extends Equatable {
  const SaveUserParams({
    required this.authResponse,
  });

  final AuthResponse authResponse;

  @override
  List<Object> get props => [authResponse];
}
