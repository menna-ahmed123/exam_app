import 'package:exam_app/feature/exam/data/models/check_answer_request_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_questions_request_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CheckQuestionsRequestModel {
  final List<CheckAnswerRequestModel> answers;
  final int time;

  CheckQuestionsRequestModel({
    required this.answers,
    required this.time,
  });

  factory CheckQuestionsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CheckQuestionsRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckQuestionsRequestModelToJson(this);
}
