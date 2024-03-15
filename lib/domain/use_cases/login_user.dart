import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:footloose_app/core/error/failures.dart';
import 'package:footloose_app/domain/models/auth_response.dart';
import 'package:footloose_app/domain/repositories/auth_repository.dart';
import 'package:footloose_app/domain/use_cases/use_case.dart';

class LoginUser implements UseCase<AuthResponse, LoginUserParams> {
  LoginUser(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, AuthResponse>> call(LoginUserParams params) {
    return repository.loginUser(params.email, params.password);
  }
}

class LoginUserParams extends Equatable {
  const LoginUserParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
