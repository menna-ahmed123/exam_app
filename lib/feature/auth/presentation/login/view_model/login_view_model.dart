import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/domain/entities/response_entity.dart';
import 'package:exam_app/feature/auth/domain/use_cases/login_use_case.dart';
import 'package:exam_app/feature/auth/presentation/login/view_model/login_event.dart';
import 'package:exam_app/feature/auth/presentation/login/view_model/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class LoginViewModel extends Cubit<LoginState> {
  LoginViewModel(this._loginUseCase) : super(LoginState.initial());

  final LoginUseCase _loginUseCase;

  void doEvent(LoginEvent event) {
    switch (event) {
      case MakeLogin():
        _login(email: event.email, password: event.password);
        break;
    }
  }

  Future<void> _login({required String email, required String password}) async {
    emit(
      state.copyWith(
        loginState: state.loginState?.copyWith(
          isLoading: true,
          errorMessage: '',
        ),
      ),
    );

    final BaseResponse<ResponseEntity> loginResponse = await _loginUseCase(
      email: email,
      password: password,
    );

    switch (loginResponse) {
      case SuccessResponse<ResponseEntity>():
        emit(
          state.copyWith(
            loginState: state.loginState?.copyWith(
              isLoading: false,
              data: loginResponse.data,
            ),
          ),
        );
        break;

      case ErrorResponse<ResponseEntity>():
        emit(
          state.copyWith(
            loginState: state.loginState?.copyWith(
              isLoading: false,
              errorMessage: loginResponse.errMessage,
            ),
          ),
        );
        break;
    }
  }
}
