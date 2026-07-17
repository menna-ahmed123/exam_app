import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/auth/domain/entities/response_entity.dart';
import 'package:exam_app/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:exam_app/feature/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/view_model/sign_up_event.dart';
import 'package:exam_app/feature/auth/presentation/sign_up/view_model/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpViewModel extends Cubit<SignUpState> {
  SignUpViewModel(this._signUpUseCase) : super(SignUpState.initial());

  final SignUpUseCase _signUpUseCase;

  void doEvent(SignUpEvent event) {
    switch (event) {
      case MakeSignUp():
        _signUp(signUpEntity: event.signUpEntity);
        break;
    }
  }

  Future<void> _signUp({required SignUpEntity signUpEntity}) async {
    emit(
      state.copyWith(
        signUpState: state.signUpState?.copyWith(
          isLoading: true,
          errorMessage: '',
        ),
      ),
    );

    final BaseResponse<ResponseEntity> signUpResponse = await _signUpUseCase(
      signUpEntity: signUpEntity,
    );

    switch (signUpResponse) {
      case SuccessResponse<ResponseEntity>():
        emit(
          state.copyWith(
            signUpState: state.signUpState?.copyWith(
              isLoading: false,
              data: signUpResponse.data,
            ),
          ),
        );
        break;

      case ErrorResponse<ResponseEntity>():
        emit(
          state.copyWith(
            signUpState: state.signUpState?.copyWith(
              isLoading: false,
              errorMessage: signUpResponse.errMessage,
            ),
          ),
        );
        break;
    }
  }
}
