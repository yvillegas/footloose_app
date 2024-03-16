import 'package:either_dart/either.dart';
import 'package:footloose_app/core/error/failures.dart';
import 'package:footloose_app/domain/models/auth_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> loginUser(
    String email,
    String password,
  );
  Future<Either<Failure, bool>> saveUser(
    AuthResponse authResponse,
  );
}
