import 'package:exam_app/feature/exam/data/models/question_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'questions_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class QuestionsResponseModel {
  final String message;
  @JsonKey(defaultValue: <QuestionModel>[])
  final List<QuestionModel> questions;

  QuestionsResponseModel({
    required this.message,
    this.questions = const [],
  });

  factory QuestionsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionsResponseModelToJson(this);
}
