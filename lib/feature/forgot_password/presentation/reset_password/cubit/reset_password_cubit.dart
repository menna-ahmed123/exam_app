import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/message_entity.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/reset_password_entity.dart';
import 'package:exam_app/feature/forgot_password/domain/use_cases/reset_password_use_case.dart';
import 'package:exam_app/feature/forgot_password/presentation/reset_password/cubit/reset_password_event.dart';
import 'package:exam_app/feature/forgot_password/presentation/reset_password/cubit/reset_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._resetPasswordUseCase)
      : super(ResetPasswordState.initial());

  final ResetPasswordUseCase _resetPasswordUseCase;

  void onEvent(ResetPasswordEvent event) {
    switch (event) {
      case ResetPasswordSubmitted():
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
        _emitError(response.errorMessage);
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
