import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/profile/domain/entities/profile_entity.dart';
import 'package:exam_app/feature/profile/domain/entities/update_profile_params.dart';
import 'package:exam_app/feature/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:exam_app/feature/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:exam_app/feature/profile/presentation/view_model/profile_event.dart';
import 'package:exam_app/feature/profile/presentation/view_model/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileState> {
  final GetProfileUseCase _getProfileUseCase;
  final UpdateProfileUseCase _updateProfileUseCase;

  ProfileViewModel(this._getProfileUseCase, this._updateProfileUseCase)
    : super(ProfileState.initial());

  void doEvent(ProfileEvent event) {
    switch (event) {
      case GetProfileEvent():
        _getProfile();
        break;
      case UpdateProfileEvent():
        _updateProfile(event.params);
        break;
    }
  }

  Future<void> _getProfile() async {
    emit(
      state.copyWith(
        profileState: state.profileState?.copyWith(
          isLoading: true,
          errorMessage: '',
        ),
      ),
    );

    final BaseResponse<ProfileEntity> response = await _getProfileUseCase();

    switch (response) {
      case SuccessResponse<ProfileEntity>():
        emit(
          state.copyWith(
            profileState: state.profileState?.copyWith(
              isLoading: false,
              data: response.data,
            ),
          ),
        );
        break;

      case ErrorResponse<ProfileEntity>():
        emit(
          state.copyWith(
            profileState: state.profileState?.copyWith(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  Future<void> _updateProfile(UpdateProfileParams params) async {
    emit(
      state.copyWith(
        updateProfileState: state.updateProfileState?.copyWith(
          isLoading: true,
          errorMessage: '',
        ),
      ),
    );

    final BaseResponse<ProfileEntity> response = await _updateProfileUseCase(
      params: params,
    );

    switch (response) {
     case SuccessResponse<ProfileEntity>():
        emit(
          state.copyWith(
            profileState: state.profileState?.copyWith(
              data: response.data,
              errorMessage: '',
            ),
            updateProfileState: state.updateProfileState?.copyWith(
              isLoading: false,
              data: response.data,
              errorMessage: '',
            ),
          ),
        );
        break;

      case ErrorResponse<ProfileEntity>():
        emit(
          state.copyWith(
            updateProfileState: state.updateProfileState?.copyWith(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }
}
