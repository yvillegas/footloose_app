import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footloose_app/domain/models/auth_response.dart';
import 'package:footloose_app/domain/use_cases/login_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.loginUser,
  }) : super(const AuthInitial()) {
    on<OnLoginUser>(_onLoginUser);
  }

  final LoginUser loginUser;

  Future<void> _onLoginUser(OnLoginUser event, Emitter<AuthState> emit) async {
    emit(const LoadingLoginUser());

    final failureOrResponse = await loginUser(
      LoginUserParams(email: event.email, password: event.password),
    );

    emit(
      failureOrResponse.fold(
        (_) => const FailureLoginUser(),
        (authResponse) => SuccessLoginUser(
          authResponse: authResponse,
        ),
      ),
    );
  }
}
