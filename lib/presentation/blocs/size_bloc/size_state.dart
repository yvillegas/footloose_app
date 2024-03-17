part of 'size_bloc.dart';

class SizeState extends Equatable {
  const SizeState();

  @override
  List<Object> get props => [];
}

class SizeInitial extends SizeState {}

// GetSizes
class LoadingGetSizes extends SizeState {
  const LoadingGetSizes();

  @override
  List<Object> get props => [];
}

class SuccessGetSizes extends SizeState {
  const SuccessGetSizes({required this.sizes});

  final List<Size> sizes;

  @override
  List<Object> get props => [sizes];
}

class FailureGetSizes extends SizeState {
  const FailureGetSizes();

  @override
  List<Object> get props => [];
}
