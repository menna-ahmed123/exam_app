import 'package:exam_app/feature/exam/domain/entities/subject_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'subject_model.g.dart';

@JsonSerializable()
class SubjectModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  @JsonKey(defaultValue: '')
  final String icon;

  SubjectModel({
    required this.id,
    required this.name,
    this.icon = '',
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectModelToJson(this);

  SubjectEntity toDomain() {
    return SubjectEntity(id: id, name: name, icon: icon);
  }
}
