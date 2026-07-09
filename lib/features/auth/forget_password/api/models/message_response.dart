class MessageResponse {
  const MessageResponse({this.message});

  final String? message;

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
      message: json['message'] as String?,
    );
  }
}
