import 'package:exam_app/feature/forget_password/domain/entities/message_entity.dart';

class MessageResponseModel {
  final String? message;

  MessageResponseModel({this.message});

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) {
    return MessageResponseModel(message: json['message'] as String?);
  }

  Map<String, dynamic> toJson() => {'message': message};

  MessageEntity toDomain() {
    return MessageEntity(message: message ?? '');
  }
}
