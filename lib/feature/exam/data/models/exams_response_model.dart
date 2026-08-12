import 'package:exam_app/feature/exam/data/models/exam_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exams_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ExamsResponseModel {
  final String message;
  @JsonKey(defaultValue: <ExamModel>[])
  final List<ExamModel> exams;

  ExamsResponseModel({
    required this.message,
    this.exams = const [],
  });

  factory ExamsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ExamsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamsResponseModelToJson(this);
}
