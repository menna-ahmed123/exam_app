import 'package:exam_app/feature/exam/domain/entities/exam_history_entity.dart';
import 'package:exam_app/feature/exam/domain/use_cases/get_exam_history_use_case.dart';
import 'package:exam_app/feature/exam/presentation/history/cubit/exam_history_event.dart';
import 'package:exam_app/feature/exam/presentation/history/cubit/exam_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExamHistoryCubit extends Cubit<ExamHistoryState> {
  ExamHistoryCubit(this.getExamHistoryUseCase)
      : super(ExamHistoryState.initial());

  final GetExamHistoryUseCase getExamHistoryUseCase;

  void onEvent(ExamHistoryEvent event) {
    switch (event) {
      case ExamHistoryLoad():
        load();
    }
  }

  Future<void> load() async {
    emitLoading();
    try {
      final history = await getExamHistoryUseCase();
      emitSuccess(history);
    } on Exception catch (error) {
      emitError(error.toString());
    }
  }

  void emitLoading() {
    emit(
      state.copyWith(
        historyState: state.historyState?.copyWith(
          isLoading: true,
          errorMessage: '',
        ),
      ),
    );
  }

  void emitSuccess(List<ExamHistoryEntity> history) {
    emit(
      state.copyWith(
        historyState: state.historyState?.copyWith(
          isLoading: false,
          data: history,
          errorMessage: '',
        ),
      ),
    );
  }

  void emitError(String message) {
    emit(
      state.copyWith(
        historyState: state.historyState?.copyWith(
          isLoading: false,
          errorMessage: message,
        ),
      ),
    );
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
