import 'package:exam_app/feature/exam/domain/entities/answer_option_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_entity.freezed.dart';

@freezed
abstract class QuestionEntity with _$QuestionEntity {
  const factory QuestionEntity({
    required String id,
    required String question,
    required List<AnswerOptionEntity> answers,
    @Default('single_choice') String type,
    /// Correct option key(s), comma-separated when multiple. From API when present.
    String? correctAnswer,
  }) = _QuestionEntity;
}
