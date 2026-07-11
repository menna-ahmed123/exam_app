import 'package:exam_app/config/base_response/error_handler.dart';

sealed class BaseResponse<T> {
  const BaseResponse();
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
