import 'package:exam_app/core/utils/validators.dart';
import 'package:exam_app/features/auth/forget_password/domain/usecases/reset_password.dart';
import 'package:exam_app/features/auth/forget_password/presentation/view_model/reset_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(this._resetPasswordUseCase)
      : super(const ResetPasswordState());

  final ResetPasswordUseCase _resetPasswordUseCase;

  void init(String email) {
    emit(state.copyWith(email: email));
  }

  void newPasswordChanged(String value) {
    emit(
      state.copyWith(
        newPassword: value,
        clearNewPasswordError: true,
        clearErrorMessage: true,
        status: ResetPasswordStatus.initial,
      ),
    );
  }

  void confirmPasswordChanged(String value) {
    emit(
      state.copyWith(
        confirmPassword: value,
        clearConfirmPasswordError: true,
        clearErrorMessage: true,
        status: ResetPasswordStatus.initial,
      ),
    );
  }

  Future<void> submit() async {
    final newPasswordError = Validators.password(state.newPassword);
    final confirmPasswordError = Validators.confirmPassword(
      state.confirmPassword,
      state.newPassword,
    );

    if (newPasswordError != null || confirmPasswordError != null) {
      emit(
        state.copyWith(
          newPasswordError: newPasswordError,
          confirmPasswordError: confirmPasswordError,
          status: ResetPasswordStatus.failure,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: ResetPasswordStatus.loading,
        clearNewPasswordError: true,
        clearConfirmPasswordError: true,
        clearErrorMessage: true,
      ),
    );

    final result = await _resetPasswordUseCase(
      email: state.email,
      newPassword: state.newPassword,
    );

    if (result.failure != null) {
      emit(
        state.copyWith(
          status: ResetPasswordStatus.failure,
          errorMessage: result.failure!.message,
        ),
      );
      return;
    }

    emit(state.copyWith(status: ResetPasswordStatus.success));
  }
}
