import 'package:exam_app/feature/exam/data/models/answer_option_model.dart';
import 'package:exam_app/feature/exam/domain/entities/answer_option_entity.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_answer_review_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exam_answer_review_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ExamAnswerReviewModel {
  final String questionId;
  final String question;
  @JsonKey(defaultValue: <AnswerOptionModel>[])
  final List<AnswerOptionModel> answers;
  @JsonKey(defaultValue: 'single_choice')
  final String type;
  @JsonKey(defaultValue: <String>[])
  final List<String> selectedKeys;
  @JsonKey(defaultValue: <String>[])
  final List<String> correctKeys;

  ExamAnswerReviewModel({
    required this.questionId,
    required this.question,
    this.answers = const [],
    this.type = 'single_choice',
    this.selectedKeys = const [],
    this.correctKeys = const [],
  });

  factory ExamAnswerReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ExamAnswerReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamAnswerReviewModelToJson(this);

  factory ExamAnswerReviewModel.fromDomain(ExamAnswerReviewEntity entity) {
    return ExamAnswerReviewModel(
      questionId: entity.questionId,
      question: entity.question,
      answers: entity.answers
          .map(
            (option) => AnswerOptionModel(
              answer: option.answer,
              key: option.key,
            ),
          )
          .toList(),
      type: entity.type,
      selectedKeys: entity.selectedKeys,
      correctKeys: entity.correctKeys,
    );
  }

  ExamAnswerReviewEntity toDomain() {
    return ExamAnswerReviewEntity(
      questionId: questionId,
      question: question,
      answers: answers
          .map(
            (option) => AnswerOptionEntity(
              answer: option.answer,
              key: option.key,
            ),
          )
          .toList(),
      type: type,
      selectedKeys: selectedKeys,
      correctKeys: correctKeys,
    );
  }
}
