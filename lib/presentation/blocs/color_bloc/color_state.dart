part of 'color_bloc.dart';

class ColorState extends Equatable {
  const ColorState();

  @override
  List<Object> get props => [];
}

class ColorInitial extends ColorState {}

// GetColors
class LoadingGetColors extends ColorState {
  const LoadingGetColors();

  @override
  List<Object> get props => [];
}

class SuccessGetColors extends ColorState {
  const SuccessGetColors({required this.colors});

  final List<Color> colors;

  @override
  List<Object> get props => [colors];
}

class FailureGetColors extends ColorState {
  const FailureGetColors();

  @override
  List<Object> get props => [];
}
