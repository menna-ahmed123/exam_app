import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_history_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_exams_state.freezed.dart';

@freezed
abstract class SubjectExamsState with _$SubjectExamsState {
  const factory SubjectExamsState({
    BaseState<List<ExamEntity>>? examsState,
    @Default(<ExamHistoryEntity>[]) List<ExamHistoryEntity> history,
  }) = _SubjectExamsState;

  factory SubjectExamsState.initial() {
    return SubjectExamsState(
      examsState: const BaseState<List<ExamEntity>>(isLoading: true),
    );
  }
}
