import 'package:exam_app/feature/exam/domain/entities/exam_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exam_model.g.dart';

@JsonSerializable()
class ExamModel {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final int duration;
  @JsonKey(name: 'subject', fromJson: _subjectIdFromJson)
  final String subjectId;
  final int numberOfQuestions;
  @JsonKey(defaultValue: true)
  final bool active;

  ExamModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.subjectId,
    required this.numberOfQuestions,
    this.active = true,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) =>
      _$ExamModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamModelToJson(this);

  ExamEntity toDomain() {
    return ExamEntity(
      id: id,
      title: title,
      duration: duration,
      subjectId: subjectId,
      numberOfQuestions: numberOfQuestions,
      active: active,
    );
  }

  static String _subjectIdFromJson(dynamic value) {
    if (value is String) return value;
    if (value is Map<String, dynamic>) {
      return value['_id']?.toString() ?? '';
    }
    return value?.toString() ?? '';
  }
}
