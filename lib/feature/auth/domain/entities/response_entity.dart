import 'package:exam_app/feature/auth/domain/entities/user_entity.dart';

class ResponseEntity {
  final String message;
  final String token;
  final UserEntity user;

  ResponseEntity({
    required this.message,
    required this.token,
    required this.user,
  });
}
