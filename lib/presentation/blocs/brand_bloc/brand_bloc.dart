import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footloose_app/domain/models/brand.dart';
import 'package:footloose_app/domain/use_cases/get_brands.dart';
import 'package:footloose_app/domain/use_cases/use_case.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  BrandBloc({
    required this.getBrands,
  }) : super(BrandInitial()) {
    on<OnGetBrands>(_onGetBrands);
  }

  final GetBrands getBrands;

  Future<void> _onGetBrands(
    OnGetBrands event,
    Emitter<BrandState> emit,
  ) async {
    emit(const LoadingGetBrands());

    final failureOrResponse = await getBrands(NoParams());

    emit(
      failureOrResponse.fold(
        (left) => const FailureGetBrands(),
        (brands) => SuccessGetBrands(brands: brands),
      ),
    );
  }
}
