import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/forgot_password_entity.dart';
import 'package:exam_app/feature/forgot_password/domain/entities/message_entity.dart';
import 'package:exam_app/feature/forgot_password/domain/use_cases/forgot_password_use_case.dart';
import 'package:exam_app/feature/forgot_password/presentation/forgot_password/cubit/forgot_password_event.dart';
import 'package:exam_app/feature/forgot_password/presentation/forgot_password/cubit/forgot_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this._forgotPasswordUseCase)
      : super(ForgotPasswordState.initial());

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  void onEvent(ForgotPasswordEvent event) {
    switch (event) {
      case ForgotPasswordSubmitted():
        _forgotPassword(email: event.email);
    }
  }

  Future<void> _forgotPassword({required String email}) async {
    _emitLoading();
    final response = await _forgotPasswordUseCase(
      forgotPasswordEntity: ForgotPasswordEntity(email: email),
    );
    _emitResult(response);
  }

  void _emitLoading() {
    emit(
      state.copyWith(
        forgotPasswordState: state.forgotPasswordState?.copyWith(
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
        forgotPasswordState: state.forgotPasswordState?.copyWith(
          isLoading: false,
          data: data,
        ),
      ),
    );
  }

  void _emitError(String message) {
    emit(
      state.copyWith(
        forgotPasswordState: state.forgotPasswordState?.copyWith(
          isLoading: false,
          errorMessage: message,
        ),
      ),
    );
  }
}
