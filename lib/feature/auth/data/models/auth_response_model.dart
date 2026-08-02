import 'package:exam_app/feature/auth/data/models/user_model.dart';
import 'package:exam_app/feature/auth/domain/entities/auth_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthResponseModel {
  final String message;
  final String token;
  final UserModel user;

  AuthResponseModel({
    required this.message,
    required this.token,
    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);

  AuthResponseEntity toDomain() {
    return AuthResponseEntity(
      message: message,
      token: token,
      user: user.toDomain(),
    );
  }
}
