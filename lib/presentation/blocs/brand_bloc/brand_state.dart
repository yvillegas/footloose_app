part of 'brand_bloc.dart';

class BrandState extends Equatable {
  const BrandState();

  @override
  List<Object> get props => [];
}

class BrandInitial extends BrandState {}

// GetBrands
class LoadingGetBrands extends BrandState {
  const LoadingGetBrands();

  @override
  List<Object> get props => [];
}

class SuccessGetBrands extends BrandState {
  const SuccessGetBrands({required this.brands});

  final List<Brand> brands;

  @override
  List<Object> get props => [brands];
}

class FailureGetBrands extends BrandState {
  const FailureGetBrands();

  @override
  List<Object> get props => [];
}
