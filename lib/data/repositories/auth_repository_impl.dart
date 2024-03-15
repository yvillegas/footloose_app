import 'package:either_dart/either.dart';
import 'package:footloose_app/core/error/failures.dart';
import 'package:footloose_app/data/data_sources/auth_data_source.dart';
import 'package:footloose_app/domain/models/auth_response.dart';
import 'package:footloose_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.authDataSource});

  final AuthDataSource authDataSource;

  @override
  Future<Either<Failure, AuthResponse>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final response = await authDataSource.loginUser(email, password);
      return Right(response);
    } catch (e) {
      return Left(RequestFailure());
    }
  }
}
