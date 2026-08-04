import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_history_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam_history_state.freezed.dart';

@freezed
abstract class ExamHistoryState with _$ExamHistoryState {
  const factory ExamHistoryState({
    BaseState<List<ExamHistoryEntity>>? historyState,
  }) = _ExamHistoryState;

  factory ExamHistoryState.initial() {
    return ExamHistoryState(
      historyState: const BaseState<List<ExamHistoryEntity>>(isLoading: true),
    );
  }
}
