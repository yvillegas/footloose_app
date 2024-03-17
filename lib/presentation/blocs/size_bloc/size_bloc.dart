import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footloose_app/domain/models/size.dart';
import 'package:footloose_app/domain/use_cases/get_sizes.dart';
import 'package:footloose_app/domain/use_cases/use_case.dart';

part 'size_event.dart';
part 'size_state.dart';

class SizeBloc extends Bloc<SizeEvent, SizeState> {
  SizeBloc({
    required this.getSizes,
  }) : super(SizeInitial()) {
    on<OnGetSizes>(_onGetSizes);
  }

  final GetSizes getSizes;

  Future<void> _onGetSizes(
    OnGetSizes event,
    Emitter<SizeState> emit,
  ) async {
    emit(const LoadingGetSizes());

    final failureOrResponse = await getSizes(NoParams());

    emit(
      failureOrResponse.fold(
        (left) => const FailureGetSizes(),
        (sizes) => SuccessGetSizes(sizes: sizes),
      ),
    );
  }
}
