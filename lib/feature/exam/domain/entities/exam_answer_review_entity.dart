import 'package:exam_app/feature/exam/domain/entities/answer_option_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exam_answer_review_entity.freezed.dart';

@freezed
abstract class ExamAnswerReviewEntity with _$ExamAnswerReviewEntity {
  const factory ExamAnswerReviewEntity({
    required String questionId,
    required String question,
    required List<AnswerOptionEntity> answers,
    @Default('single_choice') String type,
    @Default(<String>[]) List<String> selectedKeys,
    @Default(<String>[]) List<String> correctKeys,
  }) = _ExamAnswerReviewEntity;
}
