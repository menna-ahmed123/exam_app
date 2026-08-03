import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/exam/domain/entities/check_result_entity.dart';
import 'package:exam_app/feature/exam/domain/entities/question_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'taking_exam_state.freezed.dart';

@freezed
abstract class TakingExamState with _$TakingExamState {
  const factory TakingExamState({
    BaseState<List<QuestionEntity>>? questionsState,
    BaseState<CheckResultEntity>? submitState,
    @Default(0) int currentIndex,
    @Default(<String, List<String>>{}) Map<String, List<String>> selectedAnswers,
    @Default(0) int remainingSeconds,
    @Default(0) int totalSeconds,
    @Default(false) bool isTimedOut,
    @Default(false) bool shouldNavigateToScore,
  }) = _TakingExamState;

  factory TakingExamState.initial({required int durationMinutes}) {
    final totalSeconds = durationMinutes * 60;
    return TakingExamState(
      questionsState: const BaseState<List<QuestionEntity>>(isLoading: true),
      submitState: const BaseState<CheckResultEntity>(),
      remainingSeconds: totalSeconds,
      totalSeconds: totalSeconds,
    );
  }
}
