import 'package:exam_app/feature/exam/domain/entities/exam_answer_review_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam_history_entity.freezed.dart';

@freezed
abstract class ExamHistoryEntity with _$ExamHistoryEntity {
  const factory ExamHistoryEntity({
    required String id,
    required String subjectId,
    required String subjectName,
    required String examId,
    required String examTitle,
    required int numberOfQuestions,
    required int durationMinutes,
    required int timeTakenMinutes,
    required int correct,
    required int wrong,
    required double percentage,
    required DateTime completedAt,
    @Default(<ExamAnswerReviewEntity>[])
    List<ExamAnswerReviewEntity> reviewQuestions,
  }) = _ExamHistoryEntity;
}
