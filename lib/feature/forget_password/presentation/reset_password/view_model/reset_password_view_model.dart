import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/forget_password/domain/entities/message_entity.dart';
import 'package:exam_app/feature/forget_password/domain/entities/reset_password_entity.dart';
import 'package:exam_app/feature/forget_password/domain/use_cases/reset_password_use_case.dart';
import 'package:exam_app/feature/forget_password/presentation/reset_password/view_model/reset_password_event.dart';
import 'package:exam_app/feature/forget_password/presentation/reset_password/view_model/reset_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordViewModel extends Cubit<ResetPasswordState> {
  ResetPasswordViewModel(this._resetPasswordUseCase)
      : super(ResetPasswordState.initial());

  final ResetPasswordUseCase _resetPasswordUseCase;

  void doEvent(ResetPasswordEvent event) {
    switch (event) {
      case MakeResetPassword():
        _resetPassword(email: event.email, newPassword: event.newPassword);
    }
  }

  Future<void> _resetPassword({
    required String email,
    required String newPassword,
  }) async {
    _emitLoading();
    final response = await _resetPasswordUseCase(
      resetPasswordEntity: ResetPasswordEntity(
        email: email,
        newPassword: newPassword,
      ),
    );
    _emitResult(response);
  }

  void _emitLoading() {
    emit(
      state.copyWith(
        resetPasswordState: state.resetPasswordState?.copyWith(
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
        resetPasswordState: state.resetPasswordState?.copyWith(
          isLoading: false,
          data: data,
        ),
      ),
    );
  }

  void _emitError(String message) {
    emit(
      state.copyWith(
        resetPasswordState: state.resetPasswordState?.copyWith(
          isLoading: false,
          errorMessage: message,
        ),
      ),
    );
  }
}
