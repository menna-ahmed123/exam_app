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
    }
  }

  Future<void> _signUp({required SignUpEntity signUpEntity}) async {
    _emitLoading();
    final response = await _signUpUseCase(signUpEntity: signUpEntity);
    _emitResult(response);
  }

  void _emitLoading() {
    emit(
      state.copyWith(
        signUpState: state.signUpState?.copyWith(
          isLoading: true,
          errorMessage: '',
        ),
      ),
    );
  }

  void _emitResult(BaseResponse<ResponseEntity> response) {
    switch (response) {
      case SuccessResponse<ResponseEntity>():
        _emitSuccess(response.data);
      case ErrorResponse<ResponseEntity>():
        _emitError(response.errMessage);
    }
  }

  void _emitSuccess(ResponseEntity data) {
    emit(
      state.copyWith(
        signUpState: state.signUpState?.copyWith(isLoading: false, data: data),
      ),
    );
  }

  void _emitError(String message) {
    emit(
      state.copyWith(
        signUpState: state.signUpState?.copyWith(
          isLoading: false,
          errorMessage: message,
        ),
      ),
    );
  }
}
