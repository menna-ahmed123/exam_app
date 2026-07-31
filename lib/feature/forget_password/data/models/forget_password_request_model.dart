import 'package:exam_app/feature/forget_password/domain/entities/forget_password_entity.dart';

class ForgetPasswordRequestModel {
  final String email;

  ForgetPasswordRequestModel({required this.email});

  factory ForgetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordRequestModel(email: json['email'] as String);
  }

  Map<String, dynamic> toJson() => {'email': email};

  factory ForgetPasswordRequestModel.fromDomain(ForgetPasswordEntity entity) {
    return ForgetPasswordRequestModel(email: entity.email);
  }
}
