class VerifyResetCodeRequest {
  const VerifyResetCodeRequest({required this.resetCode});

  final String resetCode;

  Map<String, dynamic> toJson() => {'resetCode': resetCode};
}
