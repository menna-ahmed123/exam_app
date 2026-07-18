import 'package:exam_app/feature/forget_password/domain/entities/forget_password_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'forget_password_request_model.g.dart';

@JsonSerializable()
class ForgetPasswordRequestModel {
  @JsonKey(name: 'email')
  final String email;

  ForgetPasswordRequestModel({required this.email});

  factory ForgetPasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordRequestModelToJson(this);

  factory ForgetPasswordRequestModel.fromDomain(ForgetPasswordEntity entity) {
    return ForgetPasswordRequestModel(email: entity.email);
  }
}
