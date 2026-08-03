import 'package:exam_app/feature/exam/data/models/exam_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exam_by_id_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ExamByIdResponseModel {
  final String message;
  final ExamModel? exam;

  ExamByIdResponseModel({
    required this.message,
    this.exam,
  });

  factory ExamByIdResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ExamByIdResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExamByIdResponseModelToJson(this);
}
