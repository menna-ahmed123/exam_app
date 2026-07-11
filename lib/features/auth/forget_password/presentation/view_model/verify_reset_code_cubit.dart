import 'package:exam_app/core/utils/validators.dart';
import 'package:exam_app/features/auth/forget_password/domain/usecases/forgot_password.dart';
import 'package:exam_app/features/auth/forget_password/domain/usecases/verify_reset_code.dart';
import 'package:exam_app/features/auth/forget_password/presentation/view_model/verify_reset_code_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class VerifyResetCodeCubit extends Cubit<VerifyResetCodeState> {
  VerifyResetCodeCubit(
    this._verifyResetCodeUseCase,
    this._forgotPasswordUseCase,
  ) : super(const VerifyResetCodeState());

  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  void init(String email) {
    emit(state.copyWith(email: email));
  }

  void codeChanged(String value) {
    emit(
      state.copyWith(
        code: value,
        clearCodeError: true,
        clearErrorMessage: true,
        status: VerifyResetCodeStatus.initial,
      ),
    );
  }

  Future<void> submit() async {
    final codeError = Validators.resetCode(state.code);
    if (codeError != null) {
      emit(
        state.copyWith(
          codeError: codeError,
          status: VerifyResetCodeStatus.failure,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: VerifyResetCodeStatus.loading,
        clearCodeError: true,
        clearErrorMessage: true,
      ),
    );

    final result = await _verifyResetCodeUseCase(state.code);

    if (result.failure != null) {
      emit(
        state.copyWith(
          status: VerifyResetCodeStatus.failure,
          codeError: result.failure!.message,
        ),
      );
      return;
    }

    emit(state.copyWith(status: VerifyResetCodeStatus.success));
  }

  Future<void> resendCode() async {
    if (state.email.isEmpty || state.isResending) return;

    emit(
      state.copyWith(
        status: VerifyResetCodeStatus.resending,
        clearCodeError: true,
        clearErrorMessage: true,
      ),
    );

    final result = await _forgotPasswordUseCase(state.email);

    if (result.failure != null) {
      emit(
        state.copyWith(
          status: VerifyResetCodeStatus.failure,
          errorMessage: result.failure!.message,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: VerifyResetCodeStatus.initial,
        code: '',
        resetToken: state.resetToken + 1,
      ),
    );
  }
}
