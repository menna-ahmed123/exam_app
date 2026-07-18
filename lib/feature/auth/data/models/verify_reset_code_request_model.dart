import 'package:exam_app/feature/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_reset_code_request_model.g.dart';

@JsonSerializable()
class VerifyResetCodeRequestModel {
  @JsonKey(name: 'resetCode')
  final String resetCode;

  VerifyResetCodeRequestModel({required this.resetCode});

  factory VerifyResetCodeRequestModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResetCodeRequestModelToJson(this);

  factory VerifyResetCodeRequestModel.fromDomain(
    VerifyResetCodeEntity entity,
  ) {
    return VerifyResetCodeRequestModel(resetCode: entity.resetCode);
  }
}
