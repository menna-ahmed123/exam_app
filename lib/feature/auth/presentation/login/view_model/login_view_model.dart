import 'dart:developer';

import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/domain/entities/response_entity.dart';
import 'package:exam_app/feature/auth/domain/use_cases/login_use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel {
  final LoginUseCase loginUseCase;

  LoginViewModel(this.loginUseCase);

  void login() async {
    log('login called', name: 'LoginViewModel');

    final BaseResponse<LoginResponseEntity> loginResponse = await loginUseCase(
      email: 'menna.dev2026@gmail.com',
      password: 'Menna@123',
    );

    switch (loginResponse) {
      case SuccessResponse<LoginResponseEntity>():
        final response = loginResponse.data;

        log('Message: ${response.message}', name: 'LoginViewModel');

        log('Token: ${response.token}', name: 'LoginViewModel');

        log(
          'User Name: ${response.user.firstName} ${response.user.lastName}',
          name: 'LoginViewModel',
        );

        log('Email: ${response.user.email}', name: 'LoginViewModel');

        break;

      case ErrorResponse<LoginResponseEntity>():
        log('Error: ${loginResponse.errMessage}', name: 'LoginViewModel');
    }
  }
}
