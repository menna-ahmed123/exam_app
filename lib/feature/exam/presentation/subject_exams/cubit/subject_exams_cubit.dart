import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/exam/domain/entities/exam_entity.dart';
import 'package:exam_app/feature/exam/domain/use_cases/get_exams_use_case.dart';
import 'package:exam_app/feature/exam/presentation/subject_exams/cubit/subject_exams_event.dart';
import 'package:exam_app/feature/exam/presentation/subject_exams/cubit/subject_exams_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubjectExamsCubit extends Cubit<SubjectExamsState> {
  SubjectExamsCubit(this.getExamsUseCase)
      : super(SubjectExamsState.initial());

  final GetExamsUseCase getExamsUseCase;

  void onEvent(SubjectExamsEvent event) {
    switch (event) {
      case SubjectExamsLoad(:final subjectId):
        load(subjectId);
    }
  }

  Future<void> load(String subjectId) async {
    emitLoading();
    final response = await getExamsUseCase(subjectId: subjectId);
    switch (response) {
      case SuccessResponse<List<ExamEntity>>():
        emitSuccess(response.data);
      case ErrorResponse<List<ExamEntity>>():
        emitError(response.errorMessage);
    }
  }

  void emitLoading() {
    emit(
      state.copyWith(
        examsState: state.examsState?.copyWith(
          isLoading: true,
          errorMessage: '',
        ),
      ),
    );
  }

  void emitSuccess(List<ExamEntity> exams) {
    emit(
      state.copyWith(
        examsState: state.examsState?.copyWith(
          isLoading: false,
          data: exams,
          errorMessage: '',
        ),
      ),
    );
  }

  void emitError(String message) {
    emit(
      state.copyWith(
        examsState: state.examsState?.copyWith(
          isLoading: false,
          errorMessage: message,
        ),
      ),
    );
  }
}
