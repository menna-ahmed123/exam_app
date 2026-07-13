import 'package:exam_app/feature/auth/domain/entities/response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'user_model.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'token')
  final String token;

  @JsonKey(name: 'user')
  final UserModel user;

  LoginResponseModel({
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);

  LoginResponseEntity toDomain() {
    return LoginResponseEntity(
      message: message,
      token: token,
      user: user.toDomain(),
    );
  }
}
