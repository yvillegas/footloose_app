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

  @override
  List<Object> get props => [];
}

class SuccessLoginUser extends AuthState {
  const SuccessLoginUser();

  @override
  List<Object> get props => [];
}

class FailureLoginUser extends AuthState {
  const FailureLoginUser();

  @override
  List<Object> get props => [];
}
