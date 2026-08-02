import 'package:exam_app/feature/forgot_password/domain/entities/forgot_password_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request_model.g.dart';

@JsonSerializable()
class ForgotPasswordRequestModel {
  final String email;

  ForgotPasswordRequestModel({required this.email});

  factory ForgotPasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestModelToJson(this);

  factory ForgotPasswordRequestModel.fromDomain(ForgotPasswordEntity entity) {
    return ForgotPasswordRequestModel(email: entity.email);
  }
}
