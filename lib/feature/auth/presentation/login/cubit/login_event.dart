import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_event.freezed.dart';

@freezed
sealed class LoginEvent with _$LoginEvent {
  const factory LoginEvent.submitted({
    required String email,
    required String password,
  }) = LoginSubmitted;
}
