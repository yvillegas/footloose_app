part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

// LoginUser
class LoadingLoginUser extends AuthState {
  const LoadingLoginUser();
}

class SuccessLoginUser extends AuthState {
  const SuccessLoginUser({
    required this.authResponse,
  });

  final AuthResponse authResponse;

  @override
  List<Object> get props => [authResponse];
}

class FailureLoginUser extends AuthState {
  const FailureLoginUser();
}
