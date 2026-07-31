import 'package:exam_app/feature/forget_password/domain/entities/reset_password_entity.dart';

class ResetPasswordRequestModel {
  final String email;
  final String newPassword;

  ResetPasswordRequestModel({
    required this.email,
    required this.newPassword,
  });

  factory ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordRequestModel(
      email: json['email'] as String,
      newPassword: json['newPassword'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'newPassword': newPassword,
    };
  }

  factory ResetPasswordRequestModel.fromDomain(ResetPasswordEntity entity) {
    return ResetPasswordRequestModel(
      email: entity.email,
      newPassword: entity.newPassword,
    );
  }
}
