import 'package:exam_app/feature/forget_password/domain/entities/verify_reset_code_entity.dart';

class VerifyResetCodeRequestModel {
  final String resetCode;

  VerifyResetCodeRequestModel({required this.resetCode});

  factory VerifyResetCodeRequestModel.fromJson(Map<String, dynamic> json) {
    return VerifyResetCodeRequestModel(
      resetCode: json['resetCode'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'resetCode': resetCode};

  factory VerifyResetCodeRequestModel.fromDomain(
    VerifyResetCodeEntity entity,
  ) {
    return VerifyResetCodeRequestModel(resetCode: entity.resetCode);
  }
}
