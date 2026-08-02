import 'package:exam_app/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request_model.g.dart';

@JsonSerializable()
class SignUpRequestModel {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String phone;

  SignUpRequestModel({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
  });

  factory SignUpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestModelToJson(this);

  factory SignUpRequestModel.fromDomain(SignUpEntity entity) {
    return SignUpRequestModel(
      username: entity.username,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      password: entity.password,
      rePassword: entity.rePassword,
      phone: entity.phone,
    );
  }
}
