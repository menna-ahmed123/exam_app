import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

@freezed
abstract class AuthState with _$AuthState {
  const AuthState._();

  const factory AuthState({
    @Default(AuthStatus.unknown) AuthStatus status,
  }) = _AuthState;

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;
  bool get isUnknown => status == AuthStatus.unknown;
}
