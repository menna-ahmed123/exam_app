import 'package:dio/dio.dart';
import 'package:exam_app/config/base_response/error_handler.dart';

sealed class BaseResponse<T> {
  const BaseResponse();

  static Future<BaseResponse<T>> execute<T>(
    Future<T> Function() request,
  ) async {
    try {
      final data = await request();
      return SuccessResponse(data);
    } on DioException catch (error) {
      return ErrorResponse(
        error: error,
        errMessage: ErrorHandler.fromDioException(error),
      );
    } on Exception catch (error) {
      return ErrorResponse(error: error);
    } catch (error) {
      return ErrorResponse(error: Exception(error.toString()));
    }
  }
}

class SuccessResponse<T> extends BaseResponse<T> {
  final T data;

  const SuccessResponse(this.data);
}
class ErrorResponse<T> extends BaseResponse<T> {
  final Exception? error;
  final String errMessage;

  ErrorResponse({this.error, String? errMessage})
    : errMessage =
          errMessage ??
          (error != null
              ? ErrorHandler.handle(error)
              : 'Something went wrong, please try again.');
}
