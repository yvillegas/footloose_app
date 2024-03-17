part of 'model_bloc.dart';

class ModelState extends Equatable {
  const ModelState();

  @override
  List<Object> get props => [];
}

class ModelInitial extends ModelState {}

// GetModels
class LoadingGetModels extends ModelState {
  const LoadingGetModels();

  @override
  List<Object> get props => [];
}

class SuccessGetModels extends ModelState {
  const SuccessGetModels({required this.models});

  final List<Model> models;

  @override
  List<Object> get props => [models];
}

class FailureGetModels extends ModelState {
  const FailureGetModels();

  @override
  List<Object> get props => [];
}
