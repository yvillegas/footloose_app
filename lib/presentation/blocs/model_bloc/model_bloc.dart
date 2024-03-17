import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footloose_app/domain/models/model.dart';
import 'package:footloose_app/domain/use_cases/get_models.dart';
import 'package:footloose_app/domain/use_cases/use_case.dart';

part 'model_event.dart';
part 'model_state.dart';

class ModelBloc extends Bloc<ModelEvent, ModelState> {
  ModelBloc({
    required this.getModels,
  }) : super(ModelInitial()) {
    on<OnGetModels>(_onGetModels);
  }

  final GetModels getModels;

  Future<void> _onGetModels(
    OnGetModels event,
    Emitter<ModelState> emit,
  ) async {
    emit(const LoadingGetModels());

    final failureOrResponse = await getModels(NoParams());

    emit(
      failureOrResponse.fold(
        (left) => const FailureGetModels(),
        (models) => SuccessGetModels(models: models),
      ),
    );
  }
}
