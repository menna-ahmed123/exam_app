import 'package:exam_app/feature/exam/domain/entities/exam_answer_review_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_result_entity.freezed.dart';

@freezed
abstract class CheckResultEntity with _$CheckResultEntity {
  const factory CheckResultEntity({
    required int correct,
    required int wrong,
    required double percentage,
    @Default(<ExamAnswerReviewEntity>[])
    List<ExamAnswerReviewEntity> reviewQuestions,
    @Default(<String>[]) List<String> correctQuestionIds,
    @Default(<String>[]) List<String> wrongQuestionIds,
  }) = _CheckResultEntity;
}
