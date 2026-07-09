import 'package:exam_app/core/utils/validators.dart';
import 'package:exam_app/features/auth/forget_password/domain/usecases/forgot_password.dart';
import 'package:exam_app/features/auth/forget_password/presentation/forget_password/cubit/forget_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit(this._forgotPasswordUseCase)
      : super(const ForgetPasswordState());

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  void emailChanged(String value) {
    emit(
      state.copyWith(
        email: value,
        clearEmailError: true,
        clearErrorMessage: true,
        status: ForgetPasswordStatus.initial,
      ),
    );
  }

  Future<void> submit() async {
    final emailError = Validators.email(state.email);
    if (emailError != null) {
      emit(
        state.copyWith(
          emailError: emailError,
          status: ForgetPasswordStatus.failure,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: ForgetPasswordStatus.loading,
        clearEmailError: true,
        clearErrorMessage: true,
      ),
    );

    final result = await _forgotPasswordUseCase(state.email.trim());

    if (result.failure != null) {
      emit(
        state.copyWith(
          status: ForgetPasswordStatus.failure,
          errorMessage: result.failure!.message,
        ),
      );
      return;
    }

    emit(state.copyWith(status: ForgetPasswordStatus.success));
  }
}
