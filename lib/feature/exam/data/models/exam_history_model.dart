import 'package:exam_app/feature/exam/data/models/exam_answer_review_model.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_history_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exam_history_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ExamHistoryModel {
  final String id;
  final String subjectId;
  final String subjectName;
  final String examId;
  final String examTitle;
  final int numberOfQuestions;
  final int durationMinutes;
  @JsonKey(defaultValue: 1)
  final int timeTakenMinutes;
  final int correct;
  final int wrong;
  final double percentage;
  final String completedAt;
  @JsonKey(defaultValue: <ExamAnswerReviewModel>[])
  final List<ExamAnswerReviewModel> reviewQuestions;

  ExamHistoryModel({
    required this.id,
    required this.subjectId,
    required this.subjectName,
    required this.examId,
    required this.examTitle,
    required this.numberOfQuestions,
    required this.durationMinutes,
    this.timeTakenMinutes = 1,
    required this.correct,
    required this.wrong,
    required this.percentage,
    required this.completedAt,
    this.reviewQuestions = const [],
  });

  factory ExamHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$ExamHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamHistoryModelToJson(this);

  factory ExamHistoryModel.fromDomain(ExamHistoryEntity entity) {
    return ExamHistoryModel(
      id: entity.id,
      subjectId: entity.subjectId,
      subjectName: entity.subjectName,
      examId: entity.examId,
      examTitle: entity.examTitle,
      numberOfQuestions: entity.numberOfQuestions,
      durationMinutes: entity.durationMinutes,
      timeTakenMinutes: entity.timeTakenMinutes,
      correct: entity.correct,
      wrong: entity.wrong,
      percentage: entity.percentage,
      completedAt: entity.completedAt.toIso8601String(),
      reviewQuestions: entity.reviewQuestions
          .map(ExamAnswerReviewModel.fromDomain)
          .toList(),
    );
  }

  ExamHistoryEntity toDomain() {
    return ExamHistoryEntity(
      id: id,
      subjectId: subjectId,
      subjectName: subjectName,
      examId: examId,
      examTitle: examTitle,
      numberOfQuestions: numberOfQuestions,
      durationMinutes: durationMinutes,
      timeTakenMinutes: timeTakenMinutes,
      correct: correct,
      wrong: wrong,
      percentage: percentage,
      completedAt: DateTime.tryParse(completedAt) ?? DateTime.now(),
      reviewQuestions:
          reviewQuestions.map((question) => question.toDomain()).toList(),
    );
  }
}
