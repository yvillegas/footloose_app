import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footloose_app/domain/models/color.dart';
import 'package:footloose_app/domain/use_cases/get_colors.dart';
import 'package:footloose_app/domain/use_cases/use_case.dart';

part 'color_event.dart';
part 'color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc({
    required this.getColors,
  }) : super(ColorInitial()) {
    on<OnGetColors>(_onGetColors);
  }

  final GetColors getColors;

  Future<void> _onGetColors(
    OnGetColors event,
    Emitter<ColorState> emit,
  ) async {
    emit(const LoadingGetColors());

    final failureOrResponse = await getColors(NoParams());

    emit(
      failureOrResponse.fold(
        (left) => const FailureGetColors(),
        (colors) => SuccessGetColors(colors: colors),
      ),
    );
  }
}
