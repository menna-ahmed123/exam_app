import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/forget_password/domain/entities/forget_password_entity.dart';
import 'package:exam_app/feature/forget_password/domain/entities/message_entity.dart';
import 'package:exam_app/feature/forget_password/domain/use_cases/forget_password_use_case.dart';
import 'package:exam_app/feature/forget_password/presentation/forget_password/view_model/forget_password_event.dart';
import 'package:exam_app/feature/forget_password/presentation/forget_password/view_model/forget_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {
  ForgetPasswordViewModel(this._forgetPasswordUseCase)
      : super(ForgetPasswordState.initial());

  final ForgetPasswordUseCase _forgetPasswordUseCase;

  void doEvent(ForgetPasswordEvent event) {
    switch (event) {
      case MakeForgetPassword():
        _forgetPassword(email: event.email);
    }
  }

  Future<void> _forgetPassword({required String email}) async {
    _emitLoading();
    final response = await _forgetPasswordUseCase(
      forgetPasswordEntity: ForgetPasswordEntity(email: email),
    );
    _emitResult(response);
  }

  void _emitLoading() {
    emit(
      state.copyWith(
        forgetPasswordState: state.forgetPasswordState?.copyWith(
          isLoading: true,
          errorMessage: '',
        ),
      ),
    );
  }

  void _emitResult(BaseResponse<MessageEntity> response) {
    switch (response) {
      case SuccessResponse<MessageEntity>():
        _emitSuccess(response.data);
      case ErrorResponse<MessageEntity>():
        _emitError(response.errMessage);
    }
  }

  void _emitSuccess(MessageEntity data) {
    emit(
      state.copyWith(
        forgetPasswordState: state.forgetPasswordState?.copyWith(
          isLoading: false,
          data: data,
        ),
      ),
    );
  }

  void _emitError(String message) {
    emit(
      state.copyWith(
        forgetPasswordState: state.forgetPasswordState?.copyWith(
          isLoading: false,
          errorMessage: message,
        ),
      ),
    );
  }
}
