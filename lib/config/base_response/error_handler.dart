import 'package:dio/dio.dart';

class ErrorHandler {
  ErrorHandler._();

  static String handle(Exception error) {
    if (error is DioException) {
      return fromDioException(error);
    }
    final message = error.toString();
    if (message.contains('subtype') ||
        message.contains('FormatException') ||
        message.contains('CheckedFromJsonException') ||
        message.contains('type \'')) {
      return 'Failed to read exam result. Please try again.';
    }
    if (message.isNotEmpty && message != 'Exception') {
      final cleaned = message.replaceFirst(RegExp(r'^Exception:?\s*'), '');
      if (cleaned.isNotEmpty) return cleaned;
    }
    return 'Something went wrong, please try again.';
  }

  static String fromDioException(DioException error) {
    final serverMessage = _extractServerMessage(error.response?.data);
    if (serverMessage != null && serverMessage.isNotEmpty) {
      return serverMessage;
    }
    return _mapDioExceptionType(error);
  }

  static String _mapDioExceptionType(DioException error) {
    return switch (error.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.transformTimeout =>
        'Connection timeout, please try again.',
      DioExceptionType.connectionError =>
        'No internet connection, please check your network.',
      DioExceptionType.badCertificate =>
        'Invalid certificate, please try again later.',
      DioExceptionType.cancel => 'Request was cancelled.',
      DioExceptionType.badResponse =>
        _mapStatusCode(error.response?.statusCode),
      _ => 'Something went wrong, please try again.',
    };
  }

  static String? _extractServerMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      final message = data['message'];
      if (message is String && message.isNotEmpty) {
        return message;
      }
    }
    return null;
  }

  static String _mapStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Invalid answers submitted, please try again.';
      case 401:
        return 'Session expired, please login again.';
      case 403:
        return 'You are not allowed to submit this exam.';
      case 404:
        return 'Question not found.';
      case 409:
        return 'Something went wrong, please try again.';
      case 422:
        return 'No Data Found.';
      case 500:
      case 502:
      case 503:
        return 'Internal server error, please try again later.';
      default:
        return 'Something went wrong, please try again.';
    }
  }
}
