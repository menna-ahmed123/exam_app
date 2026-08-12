import 'package:exam_app/feature/exam/data/models/subject_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subjects_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class SubjectsResponseModel {
  final String message;
  @JsonKey(defaultValue: <SubjectModel>[])
  final List<SubjectModel> subjects;

  SubjectsResponseModel({
    required this.message,
    this.subjects = const [],
  });

  factory SubjectsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectsResponseModelToJson(this);
}
