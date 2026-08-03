import 'package:exam_app/feature/exam/domain/entities/answer_option_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'answer_option_model.g.dart';

@JsonSerializable()
class AnswerOptionModel {
  final String answer;
  final String key;

  AnswerOptionModel({
    required this.answer,
    required this.key,
  });

  factory AnswerOptionModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerOptionModelToJson(this);

  AnswerOptionEntity toDomain() {
    return AnswerOptionEntity(answer: answer, key: key);
  }
}
