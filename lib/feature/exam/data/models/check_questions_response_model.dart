import 'package:exam_app/feature/exam/domain/entities/check_result_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_questions_response_model.g.dart';

@JsonSerializable()
class CheckQuestionsResponseModel {
  final String message;
  @JsonKey(fromJson: _intFromJson)
  final int correct;
  @JsonKey(fromJson: _intFromJson)
  final int wrong;
  @JsonKey(fromJson: _percentageFromJson)
  final double percentage;

  CheckQuestionsResponseModel({
    required this.message,
    required this.correct,
    required this.wrong,
    required this.percentage,
  });

  factory CheckQuestionsResponseModel.fromJson(Map<String, dynamic> json) {
    final mapped = Map<String, dynamic>.from(json);
    if (!mapped.containsKey('percentage') && mapped.containsKey('total')) {
      mapped['percentage'] = mapped['total'];
    }
    return _$CheckQuestionsResponseModelFromJson(mapped);
  }

  Map<String, dynamic> toJson() => _$CheckQuestionsResponseModelToJson(this);

  CheckResultEntity toDomain() {
    return CheckResultEntity(
      correct: correct,
      wrong: wrong,
      percentage: percentage,
    );
  }

  static int _intFromJson(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    if (value is String) {
      return int.tryParse(value.replaceAll('%', '').trim()) ?? 0;
    }
    return 0;
  }

  static double _percentageFromJson(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value.replaceAll('%', '').trim()) ?? 0;
    }
    return 0;
  }
}
