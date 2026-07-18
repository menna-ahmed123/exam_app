import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/config/base_state/base_state.dart';
import 'package:exam_app/feature/auth/domain/entities/forget_password_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/message_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/verify_reset_code_entity.dart';
import 'package:exam_app/feature/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:exam_app/feature/auth/domain/use_cases/verify_reset_code_use_case.dart';
import 'package:exam_app/feature/auth/presentation/email_verification/view_model/email_verification_event.dart';
import 'package:exam_app/feature/auth/presentation/email_verification/view_model/email_verification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class EmailVerificationViewModel extends Cubit<EmailVerificationState> {
  EmailVerificationViewModel(
    this._verifyResetCodeUseCase,
    this._forgetPasswordUseCase,
  ) : super(EmailVerificationState.initial());

  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;

  void doEvent(EmailVerificationEvent event) {
    switch (event) {
      case MakeVerifyResetCode():
        _verifyResetCode(resetCode: event.resetCode);
      case MakeResendCode():
        _resendCode(email: event.email);
    }
  }

  Future<void> _verifyResetCode({required String resetCode}) async {
    emit(
      state.copyWith(
        emailVerificationState: BaseState<MessageEntity>(isLoading: true),
        resendCodeState: BaseState<MessageEntity>(),
      ),
    );

    final response = await _verifyResetCodeUseCase(
      verifyResetCodeEntity: VerifyResetCodeEntity(resetCode: resetCode),
    );

    switch (response) {
      case SuccessResponse<MessageEntity>():
        emit(
          state.copyWith(
            emailVerificationState: state.emailVerificationState?.copyWith(
              isLoading: false,
              data: response.data,
            ),
          ),
        );
      case ErrorResponse<MessageEntity>():
        emit(
          state.copyWith(
            emailVerificationState: state.emailVerificationState?.copyWith(
              isLoading: false,
              errorMessage: response.errMessage,
            ),
          ),
        );
    }
  }

  Future<void> _resendCode({required String email}) async {
    if (email.isEmpty) return;

    emit(
      state.copyWith(
        resendCodeState: BaseState<MessageEntity>(isLoading: true),
        emailVerificationState: BaseState<MessageEntity>(),
      ),
    );

    final response = await _forgetPasswordUseCase(
      forgetPasswordEntity: ForgetPasswordEntity(email: email),
    );

    switch (response) {
      case SuccessResponse<MessageEntity>():
        emit(
          state.copyWith(
            resendCodeState: state.resendCodeState?.copyWith(
              isLoading: false,
              data: response.data,
            ),
            resetToken: state.resetToken + 1,
          ),
        );
      case ErrorResponse<MessageEntity>():
        emit(
          state.copyWith(
            resendCodeState: state.resendCodeState?.copyWith(
              isLoading: false,
              errorMessage: response.errMessage,
            ),
          ),
        );
    }
  }
}
