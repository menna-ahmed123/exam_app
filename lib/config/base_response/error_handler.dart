import 'package:dio/dio.dart';

class ErrorHandler {
  ErrorHandler._();

  static String handle(Exception error) {
    if (error is DioException) {
      return fromDioException(error);
    }

    return 'Something went wrong, please try again.';
  }

  static String fromDioException(DioException error) {
    final serverMessage = _extractServerMessage(error.response?.data);
    if (serverMessage != null && serverMessage.isNotEmpty) {
      return serverMessage;
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return 'Connection timeout, please try again.';

      case DioExceptionType.connectionError:
        return 'No internet connection, please check your network.';

      case DioExceptionType.badCertificate:
        return 'Invalid certificate, please try again later.';

      case DioExceptionType.cancel:
        return 'Request was cancelled.';

      case DioExceptionType.badResponse:
        return _mapStatusCode(error.response?.statusCode);

      default:
        return 'Something went wrong, please try again.';
    }
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
      case 401:
      case 403:
      case 404:
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
