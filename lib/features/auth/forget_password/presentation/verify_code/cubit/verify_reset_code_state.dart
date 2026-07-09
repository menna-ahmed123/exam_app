enum VerifyResetCodeStatus { initial, loading, success, resending, failure }

class VerifyResetCodeState {
  const VerifyResetCodeState({
    this.status = VerifyResetCodeStatus.initial,
    this.email = '',
    this.code = '',
    this.codeError,
    this.errorMessage,
    this.resetToken = 0,
  });

  final VerifyResetCodeStatus status;
  final String email;
  final String code;
  final String? codeError;
  final String? errorMessage;
  final int resetToken;

  bool get isLoading => status == VerifyResetCodeStatus.loading;
  bool get isResending => status == VerifyResetCodeStatus.resending;
  bool get isSuccess => status == VerifyResetCodeStatus.success;
  bool get canSubmit => code.length == 4 && !isLoading && !isResending;

  VerifyResetCodeState copyWith({
    VerifyResetCodeStatus? status,
    String? email,
    String? code,
    String? codeError,
    String? errorMessage,
    int? resetToken,
    bool clearCodeError = false,
    bool clearErrorMessage = false,
  }) {
    return VerifyResetCodeState(
      status: status ?? this.status,
      email: email ?? this.email,
      code: code ?? this.code,
      codeError: clearCodeError ? null : codeError ?? this.codeError,
      errorMessage:
          clearErrorMessage ? null : errorMessage ?? this.errorMessage,
      resetToken: resetToken ?? this.resetToken,
    );
  }
}
