import 'package:exam_app/feature/forget_password/domain/entities/message_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_response_model.g.dart';

@JsonSerializable()
class MessageResponseModel {
  @JsonKey(name: 'message')
  final String? message;

  MessageResponseModel({this.message});

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageResponseModelToJson(this);

  MessageEntity toDomain() {
    return MessageEntity(message: message ?? '');
  }
}
