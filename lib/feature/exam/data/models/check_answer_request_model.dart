import 'package:json_annotation/json_annotation.dart';

part 'check_answer_request_model.g.dart';

@JsonSerializable()
class CheckAnswerRequestModel {
  final String questionId;
  final String correct;

  CheckAnswerRequestModel({
    required this.questionId,
    required this.correct,
  });

  factory CheckAnswerRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CheckAnswerRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckAnswerRequestModelToJson(this);
}
