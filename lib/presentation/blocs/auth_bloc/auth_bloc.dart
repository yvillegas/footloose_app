import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footloose_app/domain/models/auth_response.dart';
import 'package:footloose_app/domain/use_cases/login_user.dart';
import 'package:footloose_app/domain/use_cases/save_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.loginUser,
    required this.saveUser,
  }) : super(const AuthInitial()) {
    on<OnLoginUser>(_onLoginUser);
  }

  final LoginUser loginUser;
  final SaveUser saveUser;

  Future<void> _onLoginUser(OnLoginUser event, Emitter<AuthState> emit) async {
    emit(const LoadingLoginUser());

    emit(
      await loginUser(
        LoginUserParams(
          email: event.email,
          password: event.password,
        ),
      ).thenRight((right) {
        return saveUser(
          SaveUserParams(authResponse: right),
        );
      }).fold(
        (left) => const FailureLoginUser(),
        (right) => const SuccessLoginUser(),
      ),
    );
  }
}
