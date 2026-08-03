import 'package:exam_app/config/base_response/base_response.dart';
import 'package:exam_app/feature/exam/domain/entities/subject_entity.dart';
import 'package:exam_app/feature/exam/domain/use_cases/get_subjects_use_case.dart';
import 'package:exam_app/feature/exam/presentation/explore/cubit/explore_event.dart';
import 'package:exam_app/feature/exam/presentation/explore/cubit/explore_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit(this._getSubjectsUseCase) : super(ExploreState.initial());

  final GetSubjectsUseCase _getSubjectsUseCase;

  void onEvent(ExploreEvent event) {
    switch (event) {
      case ExploreLoadSubjects():
        _loadSubjects();
      case ExploreSearchChanged(:final query):
        emit(state.copyWith(searchQuery: query));
    }
  }

  Future<void> _loadSubjects() async {
    emit(
      state.copyWith(
        subjectsState: state.subjectsState?.copyWith(
          isLoading: true,
          errorMessage: '',
        ),
      ),
    );
    final response = await _getSubjectsUseCase();
    switch (response) {
      case SuccessResponse<List<SubjectEntity>>():
        emit(
          state.copyWith(
            subjectsState: state.subjectsState?.copyWith(
              isLoading: false,
              data: response.data,
              errorMessage: '',
            ),
          ),
        );
      case ErrorResponse<List<SubjectEntity>>():
        emit(
          state.copyWith(
            subjectsState: state.subjectsState?.copyWith(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
    }
  }

  List<SubjectEntity> get filteredSubjects {
    final subjects = state.subjectsState?.data ?? const <SubjectEntity>[];
    final query = state.searchQuery.trim().toLowerCase();
    if (query.isEmpty) return subjects;
    return subjects
        .where((subject) => subject.name.toLowerCase().contains(query))
        .toList();
  }
}
