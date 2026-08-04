import 'package:exam_app/feature/exam/domain/entities/exam_history_entity.dart';
import 'package:exam_app/feature/exam/domain/use_cases/get_exam_history_use_case.dart';
import 'package:exam_app/feature/exam/presentation/history/cubit/exam_history_event.dart';
import 'package:exam_app/feature/exam/presentation/history/cubit/exam_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExamHistoryCubit extends Cubit<ExamHistoryState> {
  ExamHistoryCubit(this._getExamHistoryUseCase)
      : super(ExamHistoryState.initial());

  final GetExamHistoryUseCase _getExamHistoryUseCase;

  void onEvent(ExamHistoryEvent event) {
    switch (event) {
      case ExamHistoryLoad():
        _load();
    }
  }

  Future<void> _load() async {
    emit(
      state.copyWith(
        historyState: state.historyState?.copyWith(
          isLoading: true,
          errorMessage: '',
        ),
      ),
    );

    try {
      final history = await _getExamHistoryUseCase();
      emit(
        state.copyWith(
          historyState: state.historyState?.copyWith(
            isLoading: false,
            data: history,
            errorMessage: '',
          ),
        ),
      );
    } on Exception catch (error) {
      emit(
        state.copyWith(
          historyState: state.historyState?.copyWith(
            isLoading: false,
            errorMessage: error.toString(),
          ),
        ),
      );
    }
  }

  Map<String, List<ExamHistoryEntity>> get groupedBySubject {
    final history = state.historyState?.data ?? const <ExamHistoryEntity>[];
    final grouped = <String, List<ExamHistoryEntity>>{};
    for (final entry in history) {
      grouped.putIfAbsent(entry.subjectName, () => []).add(entry);
    }
    return grouped;
  }
}
