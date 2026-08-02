import 'package:exam_app/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_event.freezed.dart';

@freezed
sealed class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.submitted({
    required SignUpEntity signUpEntity,
  }) = SignUpSubmitted;
}
