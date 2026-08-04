import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exam/domain/use_cases/get_exams_use_case.dart';
import 'package:exam_app/feature/exam/presentation/subject_exams/cubit/subject_exams_event.dart';
import 'package:exam_app/feature/exam/presentation/subject_exams/cubit/subject_exams_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubjectExamsCubit extends Cubit<SubjectExamsState> {
  SubjectExamsCubit(this._getExamsUseCase) : super(SubjectExamsState.initial());

  final GetExamsUseCase _getExamsUseCase;

  void onEvent(SubjectExamsEvent event) {
    switch (event) {
      case SubjectExamsLoad(:final subjectId):
        _load(subjectId);
    }
  }

  Future<void> _load(String subjectId) async {
    emit(
      state.copyWith(
        examsState: state.examsState?.copyWith(
          isLoading: true,
          errorMessage: '',
        ),
      ),
    );

    final response = await _getExamsUseCase(subjectId: subjectId);
    switch (response) {
      case SuccessResponse<List<ExamEntity>>():
        emit(
          state.copyWith(
            examsState: state.examsState?.copyWith(
              isLoading: false,
              data: response.data,
              errorMessage: '',
            ),
          ),
        );
      case ErrorResponse<List<ExamEntity>>():
        emit(
          state.copyWith(
            examsState: state.examsState?.copyWith(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
    }
  }
}
