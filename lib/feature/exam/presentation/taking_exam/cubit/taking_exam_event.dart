import 'package:exam_app/feature/exam/domain/entities/exam_session_args.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'taking_exam_event.freezed.dart';

@freezed
sealed class TakingExamEvent with _$TakingExamEvent {
  const factory TakingExamEvent.started({
    required ExamSessionArgs session,
  }) = TakingExamStarted;
  const factory TakingExamEvent.selectAnswer(String answerKey) =
      TakingExamSelectAnswer;
  const factory TakingExamEvent.next() = TakingExamNext;
  const factory TakingExamEvent.back() = TakingExamBack;
  const factory TakingExamEvent.finish() = TakingExamFinish;
  const factory TakingExamEvent.timerTick() = TakingExamTimerTick;
  const factory TakingExamEvent.viewScoreAfterTimeout() =
      TakingExamViewScoreAfterTimeout;
}
