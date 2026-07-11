enum ForgetPasswordStatus { initial, loading, success, failure }

class ForgetPasswordState {
  const ForgetPasswordState({
    this.status = ForgetPasswordStatus.initial,
    this.email = '',
    this.emailError,
    this.errorMessage,
  });

  final ForgetPasswordStatus status;
  final String email;
  final String? emailError;
  final String? errorMessage;

  bool get isLoading => status == ForgetPasswordStatus.loading;
  bool get isSuccess => status == ForgetPasswordStatus.success;
  bool get canSubmit => email.trim().isNotEmpty && !isLoading;

  ForgetPasswordState copyWith({
    ForgetPasswordStatus? status,
    String? email,
    String? emailError,
    String? errorMessage,
    bool clearEmailError = false,
    bool clearErrorMessage = false,
  }) {
    return ForgetPasswordState(
      status: status ?? this.status,
      email: email ?? this.email,
      emailError: clearEmailError ? null : emailError ?? this.emailError,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
    );
  }
}
