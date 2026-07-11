enum ResetPasswordStatus { initial, loading, success, failure }

class ResetPasswordState {
  const ResetPasswordState({
    this.status = ResetPasswordStatus.initial,
    this.email = '',
    this.newPassword = '',
    this.confirmPassword = '',
    this.newPasswordError,
    this.confirmPasswordError,
    this.errorMessage,
  });

  final ResetPasswordStatus status;
  final String email;
  final String newPassword;
  final String confirmPassword;
  final String? newPasswordError;
  final String? confirmPasswordError;
  final String? errorMessage;

  bool get isLoading => status == ResetPasswordStatus.loading;
  bool get isSuccess => status == ResetPasswordStatus.success;
  bool get canSubmit =>
      newPassword.isNotEmpty && confirmPassword.isNotEmpty && !isLoading;

  ResetPasswordState copyWith({
    ResetPasswordStatus? status,
    String? email,
    String? newPassword,
    String? confirmPassword,
    String? newPasswordError,
    String? confirmPasswordError,
    String? errorMessage,
    bool clearNewPasswordError = false,
    bool clearConfirmPasswordError = false,
    bool clearErrorMessage = false,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      email: email ?? this.email,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      newPasswordError: clearNewPasswordError
          ? null
          : newPasswordError ?? this.newPasswordError,
      confirmPasswordError: clearConfirmPasswordError
          ? null
          : confirmPasswordError ?? this.confirmPasswordError,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
    );
  }
}
