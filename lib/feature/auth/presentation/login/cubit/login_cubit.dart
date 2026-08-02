import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/domain/entities/auth_response_entity.dart';
import 'package:exam_app/feature/auth/domain/use_cases/login_use_case.dart';
import 'package:exam_app/feature/auth/presentation/login/cubit/login_event.dart';
import 'package:exam_app/feature/auth/presentation/login/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUseCase) : super(LoginState.initial());

  final LoginUseCase _loginUseCase;

  void onEvent(LoginEvent event) {
    switch (event) {
      case LoginSubmitted():
        _login(email: event.email, password: event.password);
        break;
    }
  }

  Future<void> _login({
    required String email,
    required String password,
  }) async {
    _emitLoading();
    final response = await _loginUseCase(email: email, password: password);
    _emitLoginResult(response);
  }

  void _emitLoading() {
    emit(
      state.copyWith(
        loginState: state.loginState?.copyWith(
          isLoading: true,
          errorMessage: '',
        ),
      ),
    );
  }

  void _emitLoginResult(BaseResponse<AuthResponseEntity> response) {
    switch (response) {
      case SuccessResponse<AuthResponseEntity>():
        _emitSuccess(response.data);
      case ErrorResponse<AuthResponseEntity>():
        _emitError(response.errorMessage);
    }
  }

  void _emitSuccess(AuthResponseEntity data) {
    emit(
      state.copyWith(
        loginState: state.loginState?.copyWith(isLoading: false, data: data),
      ),
    );
  }

  void _emitError(String message) {
    emit(
      state.copyWith(
        loginState: state.loginState?.copyWith(
          isLoading: false,
          errorMessage: message,
        ),
      ),
    );
  }
}
